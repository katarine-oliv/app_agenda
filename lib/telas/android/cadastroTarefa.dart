import 'package:app_agenda/dao/tarefaDao.dart';
import 'package:app_agenda/model/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroTarefa extends StatefulWidget {
  final Tarefa? tarefa;

  CadastroTarefa({this.tarefa});

  @override
  _CadastroTarefaState createState() => _CadastroTarefaState();
}

class _CadastroTarefaState extends State<CadastroTarefa> {
  final TextEditingController _nomeController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  TimeOfDay _horarioSelecionado = TimeOfDay.now();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      _nomeController.text = widget.tarefa!.nome;
      _dataSelecionada = DateFormat('yyyy-MM-dd').parse(widget.tarefa!.data);
      _horarioSelecionado = TimeOfDay(
        hour: int.parse(widget.tarefa!.horario.split(':')[0]),
        minute: int.parse(widget.tarefa!.horario.split(':')[1]),
      );
      _descricaoController.text = widget.tarefa!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.tarefa != null ? 'Editar Tarefa' : 'Cadastrar Tarefa'),
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
                  onTap: () => _selecionarData(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Data obrigatória';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                          text: DateFormat('dd/MM').format(_dataSelecionada)),
                      decoration: InputDecoration(
                        labelText: "Data",
                      ),
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _selecionarHorario(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Horário obrigatório';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                          text: _horarioSelecionado.format(context)),
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
                      String data = DateFormat('yyyy-MM-dd').format(_dataSelecionada);
                      String horario = _horarioSelecionado.format(context);
                      String descricao = _descricaoController.text;

                      Tarefa t = Tarefa(nome, data, horario, descricao);
                      TarefaDao().adicionar(t);

                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cadastrar',
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

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (dataSelecionada != null && dataSelecionada != _dataSelecionada) {
      setState(() {
        _dataSelecionada = dataSelecionada;
      });
    }
  }

  Future<void> _selecionarHorario(BuildContext context) async {
    final TimeOfDay? horarioSelecionado = await showTimePicker(
      context: context,
      initialTime: _horarioSelecionado,
    );

    if (horarioSelecionado != null && horarioSelecionado != _horarioSelecionado) {
      setState(() {
        _horarioSelecionado = horarioSelecionado;
      });
    }
  }
}
