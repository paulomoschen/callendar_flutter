import 'package:callander_flutter/tarefa_bloc.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
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
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: tarefaBloc.descricaoController,
                decoration: const InputDecoration(
                    label: Text("descrição"),
                    alignLabelWithHint: true,
                    filled: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
