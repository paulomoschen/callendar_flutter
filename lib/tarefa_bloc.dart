import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TarefaBloc extends ChangeNotifier {

  final dataController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final descricaoController = TextEditingController();

  final isMonthOrDay = BehaviorSubject<bool>();
  Stream<bool> get outIsMonthOrDay => isMonthOrDay.stream;
  Function(bool) get changeIsMonthOrDay => isMonthOrDay.sink.add;
  bool get getIsMonthOrDay => isMonthOrDay.value;

  TarefaBloc({required BuildContext context}) {
    isMonthOrDay.add(false);
  }

  @override
  void dispose() {
    isMonthOrDay.close();

    dataController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    descricaoController.dispose();
    super.dispose();
  }
}
