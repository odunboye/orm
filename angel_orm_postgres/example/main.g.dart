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
      table.integer('user_id');
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
    return const [
      'id',
      'created_at',
      'updated_at',
      'is_complete',
      'user_id',
      'text'
    ];
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
        isComplete: (row[3] as bool),
        userId: (row[4] as int),
        text: (row[5] as String));
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
        isComplete = BooleanSqlExpressionBuilder(query, 'is_complete'),
        userId = NumericSqlExpressionBuilder<int>(query, 'user_id'),
        text = StringSqlExpressionBuilder(query, 'text');

  final NumericSqlExpressionBuilder<int> id;

  final DateTimeSqlExpressionBuilder createdAt;

  final DateTimeSqlExpressionBuilder updatedAt;

  final BooleanSqlExpressionBuilder isComplete;

  final NumericSqlExpressionBuilder<int> userId;

  final StringSqlExpressionBuilder text;

  @override
  get expressionBuilders {
    return [id, createdAt, updatedAt, isComplete, userId, text];
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
  bool get isComplete {
    return (values['is_complete'] as bool);
  }

  set isComplete(bool value) => values['is_complete'] = value;
  int get userId {
    return (values['user_id'] as int);
  }

  set userId(int value) => values['user_id'] = value;
  String get text {
    return (values['text'] as String);
  }

  set text(String value) => values['text'] = value;
  void copyFrom(Todo model) {
    createdAt = model.createdAt;
    updatedAt = model.updatedAt;
    isComplete = model.isComplete;
    userId = model.userId;
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
      this.isComplete = false,
      this.userId,
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
  bool isComplete;

  @override
  final int userId;

  @override
  final String text;

  Todo copyWith(
      {String id,
      DateTime createdAt,
      DateTime updatedAt,
      bool isComplete,
      int userId,
      String text}) {
    return Todo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isComplete: isComplete ?? this.isComplete,
        userId: userId ?? this.userId,
        text: text ?? this.text);
  }

  bool operator ==(other) {
    return other is _Todo &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isComplete == isComplete &&
        other.userId == userId &&
        other.text == text;
  }

  @override
  int get hashCode {
    return hashObjects([id, createdAt, updatedAt, isComplete, userId, text]);
  }

  @override
  String toString() {
    return "Todo(id=$id, createdAt=$createdAt, updatedAt=$updatedAt, isComplete=$isComplete, userId=$userId, text=$text)";
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
        isComplete: map['is_complete'] as bool ?? false,
        userId: map['user_id'] as int,
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
      'is_complete': model.isComplete,
      'user_id': model.userId,
      'text': model.text
    };
  }
}

abstract class TodoFields {
  static const List<String> allFields = <String>[
    id,
    createdAt,
    updatedAt,
    isComplete,
    userId,
    text
  ];

  static const String id = 'id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const String isComplete = 'is_complete';

  static const String userId = 'user_id';

  static const String text = 'text';
}
