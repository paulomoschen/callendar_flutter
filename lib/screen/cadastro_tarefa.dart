import 'package:callander_flutter/bloc/tarefa_bloc.dart';
import 'package:callander_flutter/components/time_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CadastroTarefaPage extends StatefulWidget {
  const CadastroTarefaPage({super.key});

  @override
  State<CadastroTarefaPage> createState() => _CadastroTarefaPageState();
}

class _CadastroTarefaPageState extends State<CadastroTarefaPage> {
  late TarefaBloc tarefaBloc = TarefaBloc(context: context);

  @override
  void initState() {
    tarefaBloc = TarefaBloc(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("Cadastro Tarefa"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
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
                        setState(() {
                          tarefaBloc.dataController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                    decoration: const InputDecoration(
                        label: Text("Data"),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        filled: true),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: tarefaBloc.startTimeController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          decoration: const InputDecoration(
                              label: Text("Inicio"),
                              hintText: '00:00',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              alignLabelWithHint: true,
                              filled: true),
                          inputFormatters: <TextInputFormatter>[
                            TimeTextInputFormatter()
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: tarefaBloc.startTimeController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          decoration: const InputDecoration(
                              label: Text("Fim"),
                              hintText: '00:00',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              alignLabelWithHint: true,
                              filled: true),
                          inputFormatters: <TextInputFormatter>[
                            TimeTextInputFormatter()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    controller: tarefaBloc.descricaoController,
                    decoration: const InputDecoration(
                        label: Text("descrição"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        alignLabelWithHint: true,
                        filled: true),
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
                                thumbIcon: _getIcon(),
                                onChanged: (bool value) =>
                                    tarefaBloc.changeIsDone(value),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.sizeOf(context).width, 55),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: const Text(
              "Salvar",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  WidgetStateProperty<Icon?> _getIcon() {
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
}
