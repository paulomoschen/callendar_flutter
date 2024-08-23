import 'package:callander_flutter/bloc/tarefa_bloc.dart';
import 'package:callander_flutter/model/tarefa_data_source.dart';
import 'package:callander_flutter/model/tarefa_model.dart';
import 'package:callander_flutter/screen/cadastro_tarefa.dart';
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
  List<TarefaModel>? tarefaList;

  @override
  void initState() {
    tarefaBloc = TarefaBloc(context: context);
    _getTarefas();
    super.initState();
  }

  _getTarefas() async {
    tarefaBloc.changeTarefaList(await tarefaBloc.getTarefa());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Calendário"),
      ),
      body: StreamBuilder(
          stream: tarefaBloc.outTarefaList,
          builder: (context, snapshot) {
            return SfCalendar(
              view: CalendarView.month,
              dataSource: TarefaDataSource(tarefaBloc.getTarefaList),
              onTap: (calendarTapDetails) {
                if (_calendarController.view == CalendarView.month) {
                  _calendarController.view = CalendarView.day;
                  tarefaBloc.changeIsMonthOrDay(true);
                }
              },
              controller: _calendarController,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
            );
          }),
      floatingActionButton: StreamBuilder<bool>(
          stream: tarefaBloc.outIsMonthOrDay,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: () {
                if (tarefaBloc.getIsMonthOrDay) {
                  _calendarController.view = CalendarView.month;
                  tarefaBloc.changeIsMonthOrDay(false);
                } else {
                  showAddUpdateTarefaModal(
                      context: context, tarefaBloc: tarefaBloc);
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
