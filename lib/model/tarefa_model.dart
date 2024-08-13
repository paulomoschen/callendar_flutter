import 'package:flutter/material.dart';

class TarefaModel {

  TarefaModel(this.descricao, this.startTime, this.endTime, this.background, this.isAllDay);

  String descricao;
  DateTime startTime;
  DateTime endTime;
  Color background;
  bool isAllDay;
}