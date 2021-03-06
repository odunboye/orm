// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// MigrationGenerator
// **************************************************************************

class TodoMigration extends Migration {
  @override
  up(Schema schema) {
    schema.create('todos', (table) {
      table.serial('id')..primaryKey();
      table.timeStamp('created_at');
      table.timeStamp('updated_at');
      table.boolean('is_complete')..defaultsTo(false);
      table.varChar('text');
    });
  }

  @override
  down(Schema schema) {
    schema.drop('todos');
  }
}

// **************************************************************************
// OrmGenerator
// **************************************************************************

class TodoQuery extends Query<Todo, TodoQueryWhere> {
  TodoQuery({Query parent, Set<String> trampoline}) : super(parent: parent) {
    trampoline ??= Set();
    trampoline.add(tableName);
    _where = TodoQueryWhere(this);
  }

  @override
  final TodoQueryValues values = TodoQueryValues();

  TodoQueryWhere _where;

  @override
  get casts {
    return {};
  }

  @override
  get tableName {
    return 'todos';
  }

  @override
  get fields {
    return const ['id', 'created_at', 'updated_at', 'is_complete', 'text'];
  }

  @override
  TodoQueryWhere get where {
    return _where;
  }

  @override
  TodoQueryWhere newWhereClause() {
    return TodoQueryWhere(this);
  }

  static Todo parseRow(List row) {
    if (row.every((x) => x == null)) return null;
    var model = Todo(
        id: row[0].toString(),
        createdAt: (row[1] as DateTime),
        updatedAt: (row[2] as DateTime),
        is_complete: (row[3] as bool),
        text: (row[4] as String));
    return model;
  }

  @override
  deserialize(List row) {
    return parseRow(row);
  }
}

class TodoQueryWhere extends QueryWhere {
  TodoQueryWhere(TodoQuery query)
      : id = NumericSqlExpressionBuilder<int>(query, 'id'),
        createdAt = DateTimeSqlExpressionBuilder(query, 'created_at'),
        updatedAt = DateTimeSqlExpressionBuilder(query, 'updated_at'),
        is_complete = BooleanSqlExpressionBuilder(query, 'is_complete'),
        text = StringSqlExpressionBuilder(query, 'text');

  final NumericSqlExpressionBuilder<int> id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final BooleanSqlExpressionBuilder is_complete;

  final StringSqlExpressionBuilder text;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, is_complete, text];
  }
}

class TodoQueryValues extends MapQueryValues {
  @override
  get casts {
    return {};
  }

  String get id {
    return (values['id'] as String);
  }

  set id(String value) => values['id'] = value;
  DateTime get createdAt {
    return (values['created_at'] as DateTime);
  }

  set createdAt(DateTime value) => values['created_at'] = value;
  DateTime get updatedAt {
    return (values['updated_at'] as DateTime);
  }

  set updatedAt(DateTime value) => values['updated_at'] = value;
  bool get is_complete {
    return (values['is_complete'] as bool);
  }

  set is_complete(bool value) => values['is_complete'] = value;
  String get text {
    return (values['text'] as String);
  }

  set text(String value) => values['text'] = value;
  void copyFrom(Todo model) {
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    is_complete = model.is_complete;
    text = model.text;
  }
}

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class Todo extends _Todo {
  Todo(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.is_complete = false,
      this.text});

  /// A unique identifier corresponding to this item.
  @override
  String id;

  /// The time at which this item was created.
  @override
  DateTime createdAt;

  /// The last time at which this item was updated.
  @override
  DateTime updatedAt;

  @override
  bool is_complete;

  @override
  final String text;

  Todo copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      bool is_complete,
      String text}) {
    return Todo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        is_complete: is_complete ?? this.is_complete,
        text: text ?? this.text);
  }

  bool operator ==(other) {
    return other is _Todo &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.is_complete == is_complete &&
        other.text == text;
  }

  @override
  int get hashCode {
    return hashObjects([id, createdAt, updatedAt, is_complete, text]);
  }

  @override
  String toString() {
    return "Todo(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, is_complete=$is_complete, text=$text)";
  }

  Map<String, dynamic> toJson() {
    return TodoSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
// **************************************************************************

const TodoSerializer todoSerializer = TodoSerializer();

class TodoEncoder extends Converter<Todo, Map> {
  const TodoEncoder();

  @override
  Map convert(Todo model) => TodoSerializer.toMap(model);
}

class TodoDecoder extends Converter<Map, Todo> {
  const TodoDecoder();

  @override
  Todo convert(Map map) => TodoSerializer.fromMap(map);
}

class TodoSerializer extends Codec<Todo, Map> {
  const TodoSerializer();

  @override
  get encoder => const TodoEncoder();
  @override
  get decoder => const TodoDecoder();
  static Todo fromMap(Map map) {
    return Todo(
        id: map['id'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null,
        is_complete: map['is_complete'] as bool ?? false,
        text: map['text'] as String);
  }

  static Map<String, dynamic> toMap(_Todo model) {
    if (model == null) {
      return null;
    }
    return {
      'id': model.id,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String(),
      'is_complete': model.is_complete,
      'text': model.text
    };
  }
}

abstract class TodoFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    is_complete,
    text
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String is_complete = 'is_complete';

  static const String text = 'text';
}
