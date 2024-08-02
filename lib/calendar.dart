import 'package:callander_flutter/cadastro_tarefa.dart';
import 'package:callander_flutter/tarefa_bloc.dart';
import 'package:callander_flutter/tarefa_data_source.dart';
import 'package:callander_flutter/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarController _calendarController = CalendarController();
  late TarefaBloc tarefaBloc = TarefaBloc(context: context);

  @override
  void initState() {
    tarefaBloc = TarefaBloc(context: context);
    super.initState();
  }

  List<TarefaModel> _getDataSource() {
    final List<TarefaModel> tarefaList = <TarefaModel>[];
    final DateTime startTime = DateTime.utc(2024, 7, 19, 9);
    final DateTime endTime = DateTime.utc(2024, 7, 19, 11);
    tarefaList.add(TarefaModel(
        'Lavar o carro', startTime, endTime, const Color(0xFF0F8644), false));
    return tarefaList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calendário"),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: TarefaDataSource(_getDataSource()),
        onTap: (calendarTapDetails) {
          if (_calendarController.view == CalendarView.month) {
            _calendarController.view = CalendarView.day;
            tarefaBloc.changeIsMonthOrDay(true);
          }
        },
        controller: _calendarController,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      floatingActionButton: StreamBuilder<bool>(
          stream: tarefaBloc.outIsMonthOrDay,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: () {
                if (tarefaBloc.getIsMonthOrDay) {
                  _calendarController.view = CalendarView.month;
                  tarefaBloc.changeIsMonthOrDay(false);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CadastroTarefaPage()),
                  );
                }
              },
              child: Icon(
                tarefaBloc.getIsMonthOrDay ? Icons.arrow_back : Icons.add,
              ),
            );
          }),
    );
  }
}
