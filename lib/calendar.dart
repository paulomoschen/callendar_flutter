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

  List<TarefaModel> _getDataSource() {
    final List<TarefaModel> tarefaList = <TarefaModel>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    tarefaList.add(TarefaModel(
        'Lavar o carro', startTime, endTime, const Color(0xFF0F8644), true));
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
          }
        },
        controller: _calendarController,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _calendarController.view = CalendarView.month,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
