import 'package:app_agenda/dao/tarefaDao.dart';
import 'package:app_agenda/model/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditarTarefa extends StatefulWidget {
  final Tarefa tarefa;

  EditarTarefa({required this.tarefa});

  @override
  _EditarTarefaState createState() => _EditarTarefaState();
}

class _EditarTarefaState extends State<EditarTarefa> {
  final TextEditingController _nomeController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  TimeOfDay _horarioSelecionado = TimeOfDay.now();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preenche os campos com os valores da tarefa
    _nomeController.text = widget.tarefa.nome;
    _descricaoController.text = widget.tarefa.descricao;
    _dataSelecionada = DateTime.parse(widget.tarefa.data);
    _horarioSelecionado = TimeOfDay(hour: _dataSelecionada.hour, minute: _dataSelecionada.minute);
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _dataSelecionada) {
      setState(() {
        _dataSelecionada = pickedDate;
      });
    }
  }

  Future<String?> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _horarioSelecionado,
    );

    if (pickedTime != null && pickedTime != _horarioSelecionado) {
      final DateTime now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      final DateFormat formatter = DateFormat('HH:mm');
      final String formattedTime = formatter.format(selectedDateTime);

      return formattedTime;
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Editar Tarefa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nome da tarefa obrigatório';
                    }
                    return null;
                  },
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: "Nova tarefa",
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    _selectDateTime(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Data obrigatória';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                        text: DateFormat('dd/MM/yyyy').format(_dataSelecionada),
                      ),
                      decoration: InputDecoration(
                        labelText: "Data",
                      ),
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Horário obrigatório';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                        text: _horarioSelecionado.format(context),
                      ),
                      decoration: InputDecoration(
                        labelText: "Horário",
                      ),
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String nome = _nomeController.text;
                      String data = _dataSelecionada.toString();
                      String horario = _horarioSelecionado.format(context);
                      String descricao = _descricaoController.text;

                      print(nome);
                      print(data);
                      print(horario);
                      print(descricao);
                      Tarefa t = Tarefa(nome, data, horario, descricao);

                      t.id_tarefa = widget.tarefa.id_tarefa;
                      print(t.id_tarefa);
                      TarefaDao().atualizar(t);

                      Navigator.pop(context); //retorna a nova tarefa para a tela anterior
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(18.0),
                      elevation: 5.0,
                      primary: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
