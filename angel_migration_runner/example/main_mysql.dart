import 'package:angel_migration/angel_migration.dart';
import 'package:angel_migration_runner/angel_migration_runner.dart';
import 'package:angel_migration_runner/mysql.dart';
import 'package:angel_orm/angel_orm.dart';
import 'package:mysql1/mysql1.dart';
import '../../angel_migration/example/todo.dart';

var migrationRunner = MySqlMigrationRunner(
  ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '1234',
    db: 'testdb',
  ),
  migrations: [
    new UserMigration(),
    new TodoMigration(),
    new FooMigration(),
  ],
);

main(List<String> args) => runMigrations(migrationRunner, args);

class FooMigration extends Migration {
  @override
  void up(Schema schema) {
    schema.create('foos', (table) {
      table
        ..serial('id').primaryKey()
        ..varChar('bar', length: 64)
        ..timeStamp('created_at').defaultsTo(currentTimestamp);
    });
  }

  @override
  void down(Schema schema) => schema.drop('foos');
}
