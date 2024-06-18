import 'package:flutter/material.dart';

class TarefaModel {

  TarefaModel(this.descricao, this.dia, this.tempoTarefa, this.background, this.isAllDay);

  String descricao;
  DateTime dia;
  DateTime tempoTarefa;
  Color background;
  bool isAllDay;
}