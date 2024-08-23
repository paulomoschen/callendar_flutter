import 'package:flutter/material.dart';

class TarefaModel {
  String id;
  String descricao;
  DateTime startTime;
  DateTime endTime;
  Color? background;
  bool? isAllDay;
  bool isDone;
  DateTime dateCreate;
  DateTime dateUpdate;

  TarefaModel({
    required this.id,
    required this.descricao,
    required this.startTime,
    required this.endTime,
    this.background = Colors.green,
    this.isAllDay = false,
    required this.isDone,
    required this.dateCreate,
    required this.dateUpdate,
  });
}
