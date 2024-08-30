import 'package:callander_flutter/model/tarefa_db.dart';
import 'package:callander_flutter/model/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TarefaBloc extends ChangeNotifier {
  late AppDatabase _appDatabase;

  final tarefaList = BehaviorSubject<List<TarefaModel>>();
  Stream<List<TarefaModel>> get outTarefaList => tarefaList.stream;
  Function(List<TarefaModel>) get changeTarefaList => tarefaList.sink.add;
  List<TarefaModel> get getTarefaList => tarefaList.value;

  final isMonthOrDay = BehaviorSubject<bool>();
  Stream<bool> get outIsMonthOrDay => isMonthOrDay.stream;
  Function(bool) get changeIsMonthOrDay => isMonthOrDay.sink.add;
  bool get getIsMonthOrDay => isMonthOrDay.value;

  final isDone = BehaviorSubject<bool>();
  Stream<bool> get outIsDone => isDone.stream;
  Function(bool) get changeIsDone => isDone.sink.add;
  bool get getIsDone => isDone.value;

  TarefaBloc({required BuildContext context}) {
    tarefaList.add([]);
    isMonthOrDay.add(false);
    isDone.add(false);

    _appDatabase = AppDatabase();
  }

  Future<List<TarefaModel>> getTarefa() async {
    List<TarefaModel> tarefaList = await _appDatabase.getTarefa();
    return tarefaList.isEmpty ? [] : tarefaList;
  }

  insertOrUpdateTarefa({required TarefaModel tarefa}) async {
    if (tarefa.id == "0") {
      _appDatabase.insertTarefa(tarefa);
    } else {
      return _appDatabase.updateTarefa(tarefa);
    }
  }

  void deleteTarefa({required TarefaModel tarefa}) async {
    await _appDatabase.deleteTarefa(int.parse(tarefa.id));
  }

  @override
  void dispose() {
    tarefaList.close();
    isMonthOrDay.close();
    isDone.close();
    _appDatabase.close();

    super.dispose();
  }
}
