import 'dart:async';
import 'dart:collection';
import 'package:angel_migration/angel_migration.dart';
import '../runner.dart';
import '../util.dart';
import 'schema.dart';
import 'package:mysql1/mysql1.dart';

class MySqlMigrationRunner implements MigrationRunner {
  final Map<String, Migration> migrations = {};
  MySqlConnection connection;
  final Queue<Migration> _migrationQueue = new Queue();
  final ConnectionSettings connectionSettings;
  bool _connected = false;

  MySqlMigrationRunner(this.connectionSettings,
      {Iterable<Migration> migrations = const [], bool connected: false}) {
    if (migrations?.isNotEmpty == true) migrations.forEach(addMigration);
    _connected = connected == true;
  }

  @override
  void addMigration(Migration migration) {
    _migrationQueue.addLast(migration);
  }

  Future _init() async {
    while (_migrationQueue.isNotEmpty) {
      var migration = _migrationQueue.removeFirst();
      var path = await absoluteSourcePath(migration.runtimeType);
      migrations.putIfAbsent(path.replaceAll("\\", "\\\\"), () => migration);
    }

    this.connection = await MySqlConnection.connect(connectionSettings);
    _connected = true;

    await connection.query('''
    CREATE TABLE IF NOT EXISTS migrations (
      id serial PRIMARY KEY,
      batch integer,
      path VARCHAR(255)
    );
    ''');
  }

  @override
  Future up() async {
    await _init();
    var r = await connection.query('SELECT path from migrations;');
    Iterable<String> existing = r.expand((x) => x).cast<String>();
    List<String> toRun = [];

    migrations.forEach((k, v) {
      if (!existing.contains(k)) toRun.add(k);
    });

    if (toRun.isNotEmpty) {
      var r = await connection.query('SELECT MAX(batch) from migrations;');
      int curBatch = 0;
      r.first == null ? curBatch = 0 : curBatch = (r.single[0] ?? 0) as int;
      int batch = curBatch + 1;

      for (var k in toRun) {
        var migration = migrations[k];
        var schema = new MySqlSchema();
        migration.up(schema);
        print('Bringing up "$k"...');
        await schema.run(connection).then((_) {
          return connection.query(
              'INSERT INTO MIGRATIONS (batch, path) VALUES ($batch, \'$k\');');
        });
      }
    } else {
      print('No migrations found to bring up.');
    }
  }

  @override
  Future rollback() async {
    await _init();

    var r = await connection.query('SELECT MAX(batch) from migrations;');
    // int curBatch = (r.first[0] ?? 0) as int;
    int curBatch = 0;
    r.first == null ? curBatch = 0 : curBatch = (r.single[0] ?? 0) as int;
    r = await connection
        .query('SELECT path from migrations WHERE batch = $curBatch;');
    Iterable<String> existing = r.expand((x) => x).cast<String>();
    List<String> toRun = [];

    migrations.forEach((k, v) {
      if (existing.contains(k)) toRun.add(k);
    });

    if (toRun.isNotEmpty) {
      for (var k in toRun.reversed) {
        var migration = migrations[k];
        var schema = new MySqlSchema();
        migration.down(schema);
        print('Bringing down "$k"...');
        await schema.run(connection).then((_) {
          return connection
              .query('DELETE FROM migrations WHERE path = \'$k\';');
        });
      }
    } else {
      print('No migrations found to roll back.');
    }
  }

  @override
  Future reset() async {
    await _init();
    var r = await connection
        .query('SELECT path from migrations ORDER BY batch DESC;');
    Iterable<String> existing = r.expand((x) => x).cast<String>();
    var toRun = existing.where(migrations.containsKey).toList();

    if (toRun.isNotEmpty) {
      for (var k in toRun.reversed) {
        var migration = migrations[k];
        var schema = new MySqlSchema();
        migration.down(schema);
        print('Bringing down "$k"...');
        await schema.run(connection).then((_) {
          return connection
              .query('DELETE FROM migrations WHERE path = \'$k\';');
        });
      }
    } else {
      print('No migrations found to roll back.');
    }
  }

  @override
  Future close() {
    return connection.close();
  }
}
