import 'package:callander_flutter/bloc/tarefa_bloc.dart';
import 'package:callander_flutter/components/time_text_input_formatter.dart';
import 'package:callander_flutter/model/tarefa_model.dart';
import 'package:callander_flutter/screen/text_componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

showAddUpdateTarefaModal({
  required BuildContext context,
  required Function onRefresh,
  required TarefaBloc tarefaBloc,
  TarefaModel? tarefaEdit,
}) {
  final dataController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final descricaoController = TextEditingController();

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

  if (tarefaEdit != null) {
    dataController.text = DateFormat("dd/MM/yyyy").format(tarefaEdit.startTime);
    startTimeController.text =
        "${tarefaEdit.startTime.hour} ${tarefaEdit.startTime.minute}";
    endTimeController.text =
        "${tarefaEdit.endTime.hour} ${tarefaEdit.endTime.minute}";
    descricaoController.text = tarefaEdit.descricao;
    tarefaBloc.changeIsDone(tarefaEdit.isDone);
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
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *
                  (tarefaEdit != null ? 0.45 : 0.55),
              padding: const EdgeInsets.all(28.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      controller: dataController,
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

                          dataController.text = formattedDate;
                        }
                      },
                      decoration: inputDecoration(label: "Data"),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: startTimeController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          decoration: inputDecoration(
                              label: "Inicio", hintText: "00:00"),
                          inputFormatters: <TextInputFormatter>[
                            TimeTextInputFormatter()
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: endTimeController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
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
                      controller: descricaoController,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
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
                          String startAux =
                              "${dataController.text} ${startTimeController.text}";
                          DateTime dataTarefa =
                              DateFormat("dd/MM/yyyy HH:mm").parse(startAux);

                          String endAux =
                              "${dataController.text} ${endTimeController.text}";
                          DateTime endTarefa =
                              DateFormat("dd/MM/yyyy HH:mm").parse(endAux);

                          TarefaModel tarefa = TarefaModel(
                            id: "0",
                            descricao: descricaoController.text,
                            startTime: dataTarefa,
                            endTime: endTarefa,
                            isDone: tarefaBloc.getIsDone,
                            dateCreate: DateTime.now(),
                            dateUpdate: DateTime.now(),
                          );
                          if (tarefaEdit != null) {
                            tarefa.id = tarefaEdit.id;
                            tarefa.dateCreate = tarefaEdit.dateCreate;
                          }
                          tarefaBloc.insertOrUpdateTarefa(tarefa: tarefa);

                          onRefresh();
                          Navigator.pop(context);
                        },
                        child: const Text("Salvar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: tarefaEdit != null,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0, bottom: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      tarefaBloc.deleteTarefa(tarefa: tarefaEdit!);

                      onRefresh();
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.delete),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
