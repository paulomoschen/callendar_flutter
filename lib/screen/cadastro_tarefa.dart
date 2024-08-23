import 'package:callander_flutter/bloc/tarefa_bloc.dart';
import 'package:callander_flutter/components/time_text_input_formatter.dart';
import 'package:callander_flutter/model/tarefa_model.dart';
import 'package:callander_flutter/screen/text_componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

showAddUpdateTarefaModal({
  required BuildContext context,
  required TarefaBloc tarefaBloc,
  TarefaModel? tarefa,
}) {
  WidgetStateProperty<Icon?> getIcon() {
    WidgetStateProperty<Icon?>? thumbIcon =
        WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );
    return thumbIcon;
  }

  if (tarefa != null) {
    tarefaBloc.dataController.text =
        DateFormat("dd/mm/yyyy").format(tarefa.startTime);
    tarefaBloc.startTimeController.text =
        "${tarefa.startTime.hour} ${tarefa.startTime.minute}";
    tarefaBloc.endTimeController.text =
        "${tarefa.endTime.hour} ${tarefa.endTime.minute}";
    tarefaBloc.descricaoController.text = tarefa.descricao;
    tarefaBloc.changeIsDone(tarefa.isDone);
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.55,
          padding: const EdgeInsets.all(28.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: tarefaBloc.dataController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                      tarefaBloc.dataController.text = formattedDate;
                    }
                  },
                  decoration: inputDecoration(label: "Data"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: tarefaBloc.startTimeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      decoration:
                          inputDecoration(label: "Inicio", hintText: "00:00"),
                      inputFormatters: <TextInputFormatter>[
                        TimeTextInputFormatter()
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: tarefaBloc.endTimeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      decoration:
                          inputDecoration(label: "Fim", hintText: "00:00"),
                      inputFormatters: <TextInputFormatter>[
                        TimeTextInputFormatter()
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  controller: tarefaBloc.descricaoController,
                  decoration: inputDecoration(label: "Descrição"),
                ),
              ),
              StreamBuilder<bool>(
                  stream: tarefaBloc.outIsDone,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () =>
                          tarefaBloc.changeIsDone(!tarefaBloc.getIsDone),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Marcar como concluida',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Switch(
                              value: tarefaBloc.getIsDone,
                              thumbIcon: getIcon(),
                              onChanged: (bool value) =>
                                  tarefaBloc.changeIsDone(value),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  TextButton(
                    onPressed: () async {
                      bool ok = await tarefaBloc.insertTarefa();
                      if (ok) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
