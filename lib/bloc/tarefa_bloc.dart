import 'package:callander_flutter/model/tarefa_db.dart';
import 'package:callander_flutter/model/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class TarefaBloc extends ChangeNotifier {
  final dataController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final descricaoController = TextEditingController();

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

  getTarefa() async {
    List<TarefaModel> tarefaList = await _appDatabase.getTarefa();
    return tarefaList.isEmpty ? [] : tarefaList;
  }

  Future<bool> insertTarefa({TarefaModel? tarefaEdit}) async {
    try {
      String startAux = "${dataController.text} ${startTimeController.text}";
      DateTime dataTarefa = DateFormat("dd/MM/yyyy HH:mm").parse(startAux);

      String endAux = "${dataController.text} ${endTimeController.text}";
      DateTime endTarefa = DateFormat("dd/MM/yyyy HH:mm").parse(endAux);

      TarefaModel tarefa = TarefaModel(
        id: "0",
        descricao: descricaoController.text,
        startTime: dataTarefa,
        endTime: endTarefa,
        isDone: getIsDone,
        dateCreate: DateTime.now(),
        dateUpdate: DateTime.now(),
      );

      if (tarefaEdit == null) {
        await _appDatabase.insertTarefa(tarefa);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    tarefaList.close();
    isMonthOrDay.close();
    isDone.close();
    _appDatabase.close();

    dataController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    descricaoController.dispose();
    super.dispose();
  }
}
