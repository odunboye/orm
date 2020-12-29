import 'dart:io';
import 'package:angel_orm_postgres/angel_orm_postgres.dart';
import 'package:postgres/postgres.dart';
// import 'package:angel_orm/angel_orm.dart';
import 'package:angel_serialize/angel_serialize.dart';

import 'package:angel_migration/angel_migration.dart';
import 'package:angel_model/angel_model.dart';
import 'package:angel_orm/angel_orm.dart';

// import 'package:angel_serialize/angel_serialize.dart';
// import 'package:logging/logging.dart';

part 'main.g.dart';

main() async {
  var executor = new PostgreSqlExecutorPool(Platform.numberOfProcessors, () {
    return new PostgreSQLConnection('localhost', 5432, 'test',
        username: 'oadeboye');
  });

  var query = TodoQuery();
  query.values
    ..text = 'Clean your room!'
    ..isComplete = false
    ..userId = 1;

  var todo = await query.insert(executor);
  print(todo.toJson());

  var query2 = TodoQuery()..where.id.equals(todo.idAsInt);
  var todo2 = await query2.getOne(executor);
  print(todo2.toJson());
  print(todo == todo2);

  // var rows = await executor.query('users', 'SELECT * FROM users', {});
  // print(rows);
}

@serializable
@orm
abstract class _Todo extends Model {
  int get userId;
  String get text;

  @DefaultsTo(false)
  bool isComplete;
}
