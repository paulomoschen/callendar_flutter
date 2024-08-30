import 'dart:io';

import 'package:callander_flutter/model/tarefa_model.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part "tarefa_db.g.dart";

class TarefaTable extends Table {
  IntColumn get id => integer().named("id").autoIncrement()();
  TextColumn get name => text().named("descricao").withLength(min: 1, max: 30)();
  DateTimeColumn get startTime => dateTime().named("startTime")();
  DateTimeColumn get endTime => dateTime().named("endTime")();
  BoolColumn get isDone => boolean().named('isDone')();
  DateTimeColumn get dateCreate => dateTime().named("dateCreate")();
  DateTimeColumn get dateUpdate => dateTime().named("dateUpdate")();
}

@DriftDatabase(tables: [TarefaTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertTarefa(TarefaModel tarefa) async {
    TarefaTableCompanion novaLinha = TarefaTableCompanion(
      name: Value(tarefa.descricao),
      startTime: Value(tarefa.startTime),
      endTime: Value(tarefa.endTime),
      isDone: Value(tarefa.isDone),
      dateCreate: Value(tarefa.dateCreate),
      dateUpdate: Value(tarefa.dateUpdate),
    );

    return await into(tarefaTable).insert(novaLinha);
  }

  Future<List<TarefaModel>> getTarefa() async {
    List<TarefaModel> temp = [];

    List<TarefaTableData> listData = await select(tarefaTable).get();

    for (TarefaTableData row in listData) {
      temp.add(TarefaModel(
        id: row.id.toString(),
        descricao: row.name,
        isDone: row.isDone,
        startTime: row.startTime,
        endTime: row.endTime,
        dateCreate: row.dateCreate,
        dateUpdate: row.dateUpdate,
      ));
    }

    return temp;
  }

  Future<bool> updateTarefa(TarefaModel tarefa) async {
    return await update(tarefaTable).replace(TarefaTableCompanion(
      id: Value(int.parse(tarefa.id)),
      name: Value(tarefa.descricao),
      isDone: Value(tarefa.isDone),
      startTime: Value(tarefa.startTime),
      endTime: Value(tarefa.endTime),
      dateCreate: Value(tarefa.dateCreate),
      dateUpdate: Value(tarefa.dateUpdate),
    ));
  }

  Future<int> deleteTarefa(int id) async {
    return await (delete(tarefaTable)..where((row) => row.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "db.sqlite"));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  });
}
