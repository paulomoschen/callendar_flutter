import 'package:callander_flutter/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TarefaDataSource extends CalendarDataSource {
  TarefaDataSource(List<TarefaModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getTarefaData(index).dia;
  }

  @override
  DateTime getEndTime(int index) {
    return _getTarefaData(index).tempoTarefa;
  }

  @override
  String getSubject(int index) {
    return _getTarefaData(index).descricao;
  }

  @override
  Color getColor(int index) {
    return _getTarefaData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getTarefaData(index).isAllDay;
  }

  TarefaModel _getTarefaData(int index) {
    final dynamic tarefa = appointments![index];
    late final TarefaModel tarefaData;
    if (tarefa is TarefaModel) {
      tarefaData = tarefa;
    }

    return tarefaData;
  }
}