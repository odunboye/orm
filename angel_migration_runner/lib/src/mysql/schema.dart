import 'dart:async';
import 'package:angel_migration/angel_migration.dart';
import 'package:mysql1/mysql1.dart';
import '../../mysql.dart';

class MySqlSchema extends Schema {
  final int _indent;
  final StringBuffer _buf;

  MySqlSchema._(this._buf, this._indent);

  factory MySqlSchema() => new MySqlSchema._(new StringBuffer(), 0);

  Future run(MySqlConnection connection) => connection.query(compile());

  String compile() => _buf.toString();

  void _writeln(String str) {
    for (int i = 0; i < _indent; i++) {
      _buf.write('  ');
    }

    _buf.writeln(str);
  }

  @override
  void drop(String tableName, {bool cascade: false}) {
    var c = cascade == true ? ' CASCADE' : '';
    _writeln('DROP TABLE $tableName$c;');
  }

  @override
  void alter(String tableName, void callback(MutableTable table)) {
    var tbl = new MySqlAlterTable(tableName);
    callback(tbl);
    _writeln('ALTER TABLE $tableName');
    tbl.compile(_buf, _indent + 1);
    _buf.write(';');
  }

  void _create(String tableName, void callback(Table table), bool ifNotExists) {
    var op = ifNotExists ? ' IF NOT EXISTS' : '';
    var tbl = new MySqlTable();
    callback(tbl);
    _writeln('CREATE TABLE$op $tableName (');
    tbl.compile(_buf, _indent + 1);
    _buf.writeln();
    _writeln(');');
  }

  @override
  void create(String tableName, void callback(Table table)) =>
      _create(tableName, callback, false);

  @override
  void createIfNotExists(String tableName, void callback(Table table)) =>
      _create(tableName, callback, true);
}
