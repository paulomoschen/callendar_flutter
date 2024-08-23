// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_db.dart';

// ignore_for_file: type=lint
class $TarefaTableTable extends TarefaTable
    with TableInfo<$TarefaTableTable, TarefaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarefaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'descricao', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'startTime', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'endTime', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'isDone', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("isDone" IN (0, 1))'));
  static const VerificationMeta _dateCreateMeta =
      const VerificationMeta('dateCreate');
  @override
  late final GeneratedColumn<DateTime> dateCreate = GeneratedColumn<DateTime>(
      'dateCreate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateUpdateMeta =
      const VerificationMeta('dateUpdate');
  @override
  late final GeneratedColumn<DateTime> dateUpdate = GeneratedColumn<DateTime>(
      'dateUpdate', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, startTime, endTime, isDone, dateCreate, dateUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarefa_table';
  @override
  VerificationContext validateIntegrity(Insertable<TarefaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['descricao']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('startTime')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['startTime']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('endTime')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['endTime']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('isDone')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['isDone']!, _isDoneMeta));
    } else if (isInserting) {
      context.missing(_isDoneMeta);
    }
    if (data.containsKey('dateCreate')) {
      context.handle(
          _dateCreateMeta,
          dateCreate.isAcceptableOrUnknown(
              data['dateCreate']!, _dateCreateMeta));
    } else if (isInserting) {
      context.missing(_dateCreateMeta);
    }
    if (data.containsKey('dateUpdate')) {
      context.handle(
          _dateUpdateMeta,
          dateUpdate.isAcceptableOrUnknown(
              data['dateUpdate']!, _dateUpdateMeta));
    } else if (isInserting) {
      context.missing(_dateUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TarefaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TarefaTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}startTime'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}endTime'])!,
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}isDone'])!,
      dateCreate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dateCreate'])!,
      dateUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}dateUpdate'])!,
    );
  }

  @override
  $TarefaTableTable createAlias(String alias) {
    return $TarefaTableTable(attachedDatabase, alias);
  }
}

class TarefaTableData extends DataClass implements Insertable<TarefaTableData> {
  final int id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final bool isDone;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  const TarefaTableData(
      {required this.id,
      required this.name,
      required this.startTime,
      required this.endTime,
      required this.isDone,
      required this.dateCreate,
      required this.dateUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['descricao'] = Variable<String>(name);
    map['startTime'] = Variable<DateTime>(startTime);
    map['endTime'] = Variable<DateTime>(endTime);
    map['isDone'] = Variable<bool>(isDone);
    map['dateCreate'] = Variable<DateTime>(dateCreate);
    map['dateUpdate'] = Variable<DateTime>(dateUpdate);
    return map;
  }

  TarefaTableCompanion toCompanion(bool nullToAbsent) {
    return TarefaTableCompanion(
      id: Value(id),
      name: Value(name),
      startTime: Value(startTime),
      endTime: Value(endTime),
      isDone: Value(isDone),
      dateCreate: Value(dateCreate),
      dateUpdate: Value(dateUpdate),
    );
  }

  factory TarefaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TarefaTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      dateCreate: serializer.fromJson<DateTime>(json['dateCreate']),
      dateUpdate: serializer.fromJson<DateTime>(json['dateUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'isDone': serializer.toJson<bool>(isDone),
      'dateCreate': serializer.toJson<DateTime>(dateCreate),
      'dateUpdate': serializer.toJson<DateTime>(dateUpdate),
    };
  }

  TarefaTableData copyWith(
          {int? id,
          String? name,
          DateTime? startTime,
          DateTime? endTime,
          bool? isDone,
          DateTime? dateCreate,
          DateTime? dateUpdate}) =>
      TarefaTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isDone: isDone ?? this.isDone,
        dateCreate: dateCreate ?? this.dateCreate,
        dateUpdate: dateUpdate ?? this.dateUpdate,
      );
  TarefaTableData copyWithCompanion(TarefaTableCompanion data) {
    return TarefaTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      dateCreate:
          data.dateCreate.present ? data.dateCreate.value : this.dateCreate,
      dateUpdate:
          data.dateUpdate.present ? data.dateUpdate.value : this.dateUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TarefaTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isDone: $isDone, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateUpdate: $dateUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, startTime, endTime, isDone, dateCreate, dateUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TarefaTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.isDone == this.isDone &&
          other.dateCreate == this.dateCreate &&
          other.dateUpdate == this.dateUpdate);
}

class TarefaTableCompanion extends UpdateCompanion<TarefaTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<bool> isDone;
  final Value<DateTime> dateCreate;
  final Value<DateTime> dateUpdate;
  const TarefaTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.isDone = const Value.absent(),
    this.dateCreate = const Value.absent(),
    this.dateUpdate = const Value.absent(),
  });
  TarefaTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required bool isDone,
    required DateTime dateCreate,
    required DateTime dateUpdate,
  })  : name = Value(name),
        startTime = Value(startTime),
        endTime = Value(endTime),
        isDone = Value(isDone),
        dateCreate = Value(dateCreate),
        dateUpdate = Value(dateUpdate);
  static Insertable<TarefaTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<bool>? isDone,
    Expression<DateTime>? dateCreate,
    Expression<DateTime>? dateUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'descricao': name,
      if (startTime != null) 'startTime': startTime,
      if (endTime != null) 'endTime': endTime,
      if (isDone != null) 'isDone': isDone,
      if (dateCreate != null) 'dateCreate': dateCreate,
      if (dateUpdate != null) 'dateUpdate': dateUpdate,
    });
  }

  TarefaTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<bool>? isDone,
      Value<DateTime>? dateCreate,
      Value<DateTime>? dateUpdate}) {
    return TarefaTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isDone: isDone ?? this.isDone,
      dateCreate: dateCreate ?? this.dateCreate,
      dateUpdate: dateUpdate ?? this.dateUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['descricao'] = Variable<String>(name.value);
    }
    if (startTime.present) {
      map['startTime'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['endTime'] = Variable<DateTime>(endTime.value);
    }
    if (isDone.present) {
      map['isDone'] = Variable<bool>(isDone.value);
    }
    if (dateCreate.present) {
      map['dateCreate'] = Variable<DateTime>(dateCreate.value);
    }
    if (dateUpdate.present) {
      map['dateUpdate'] = Variable<DateTime>(dateUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarefaTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isDone: $isDone, ')
          ..write('dateCreate: $dateCreate, ')
          ..write('dateUpdate: $dateUpdate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TarefaTableTable tarefaTable = $TarefaTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tarefaTable];
}

typedef $$TarefaTableTableCreateCompanionBuilder = TarefaTableCompanion
    Function({
  Value<int> id,
  required String name,
  required DateTime startTime,
  required DateTime endTime,
  required bool isDone,
  required DateTime dateCreate,
  required DateTime dateUpdate,
});
typedef $$TarefaTableTableUpdateCompanionBuilder = TarefaTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> startTime,
  Value<DateTime> endTime,
  Value<bool> isDone,
  Value<DateTime> dateCreate,
  Value<DateTime> dateUpdate,
});

class $$TarefaTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TarefaTableTable> {
  $$TarefaTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isDone => $state.composableBuilder(
      column: $state.table.isDone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateCreate => $state.composableBuilder(
      column: $state.table.dateCreate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dateUpdate => $state.composableBuilder(
      column: $state.table.dateUpdate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TarefaTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TarefaTableTable> {
  $$TarefaTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startTime => $state.composableBuilder(
      column: $state.table.startTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get endTime => $state.composableBuilder(
      column: $state.table.endTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isDone => $state.composableBuilder(
      column: $state.table.isDone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateCreate => $state.composableBuilder(
      column: $state.table.dateCreate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dateUpdate => $state.composableBuilder(
      column: $state.table.dateUpdate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$TarefaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TarefaTableTable,
    TarefaTableData,
    $$TarefaTableTableFilterComposer,
    $$TarefaTableTableOrderingComposer,
    $$TarefaTableTableCreateCompanionBuilder,
    $$TarefaTableTableUpdateCompanionBuilder,
    (
      TarefaTableData,
      BaseReferences<_$AppDatabase, $TarefaTableTable, TarefaTableData>
    ),
    TarefaTableData,
    PrefetchHooks Function()> {
  $$TarefaTableTableTableManager(_$AppDatabase db, $TarefaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TarefaTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TarefaTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime> endTime = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<DateTime> dateCreate = const Value.absent(),
            Value<DateTime> dateUpdate = const Value.absent(),
          }) =>
              TarefaTableCompanion(
            id: id,
            name: name,
            startTime: startTime,
            endTime: endTime,
            isDone: isDone,
            dateCreate: dateCreate,
            dateUpdate: dateUpdate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required DateTime startTime,
            required DateTime endTime,
            required bool isDone,
            required DateTime dateCreate,
            required DateTime dateUpdate,
          }) =>
              TarefaTableCompanion.insert(
            id: id,
            name: name,
            startTime: startTime,
            endTime: endTime,
            isDone: isDone,
            dateCreate: dateCreate,
            dateUpdate: dateUpdate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TarefaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TarefaTableTable,
    TarefaTableData,
    $$TarefaTableTableFilterComposer,
    $$TarefaTableTableOrderingComposer,
    $$TarefaTableTableCreateCompanionBuilder,
    $$TarefaTableTableUpdateCompanionBuilder,
    (
      TarefaTableData,
      BaseReferences<_$AppDatabase, $TarefaTableTable, TarefaTableData>
    ),
    TarefaTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TarefaTableTableTableManager get tarefaTable =>
      $$TarefaTableTableTableManager(_db, _db.tarefaTable);
}
