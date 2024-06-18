import 'package:callander_flutter/tarefa_model.dart';
import 'package:rxdart/rxdart.dart';

class TarefaBloc {
  final teste = BehaviorSubject<TarefaModel>();
  Stream<TarefaModel> get outTeste => teste.stream;
  Function(TarefaModel) get changeTeste => teste.sink.add;
  TarefaModel get getTeste => teste.value;
}
