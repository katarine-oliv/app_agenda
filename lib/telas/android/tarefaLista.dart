import 'package:app_agenda/dao/tarefaDao.dart';
import 'package:app_agenda/model/tarefa.dart';
import 'package:app_agenda/telas/android/cadastroTarefa.dart';
import 'package:app_agenda/telas/android/editarTarefa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TarefaLista extends StatefulWidget {
  @override
  State<TarefaLista> createState() => _TarefaListaState();
}

class _TarefaListaState extends State<TarefaLista> {
  List<Tarefa> _tarefas = [];
  final GlobalKey _cadastroTarefaKey = GlobalKey();
  Offset? _cadastroTarefaPosition;
  String _textoPesquisa = '';

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    List<Tarefa> tarefas = await TarefaDao().getTarefas();
    setState(() {
      _tarefas = tarefas;
    });
  }

  String formatarData(String dataHora) {
    final formatter = DateFormat('dd/MM');
    return formatter.format(DateTime.parse(dataHora));
  }

  void _exibirDetalhesTarefa(Tarefa tarefa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tarefa.nome),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
                Text('Data: ${formatarData(tarefa.data)}'),

                SizedBox(height: 10),

                Text('Horário: ${tarefa.horario.substring(0, 5)}'),

                SizedBox(height: 10),

                Text('Descrição: ${tarefa.descricao}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Fechar',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
    );
  }

  void _editarTarefa(Tarefa tarefa) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditarTarefa(tarefa: tarefa)),
    ).then((value) {
      _carregarTarefas();
    });
  }

  void _removerTarefa(Tarefa tarefa) async {
    await TarefaDao().remover(tarefa.id_tarefa!);
    _carregarTarefas(); // atualiza a lista de tarefas após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final RenderBox? appBarBox = _cadastroTarefaKey.currentContext?.findRenderObject() as RenderBox?;
      if (appBarBox != null) {
        final appBarPosition = appBarBox.localToGlobal(Offset.zero);
        setState(() {
          _cadastroTarefaPosition = appBarPosition;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          TextField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              labelText: "Pesquisar",
              hintText: "Pesquisar",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (texto) {
              setState(() {
                _textoPesquisa = texto;
              });
            },
          ),
          Expanded(
            child: Container(
              child: _listViewTarefa(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroTarefa()),
          ).then((value) {
            _carregarTarefas();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Widget _listViewTarefa() {
    List<Tarefa> tarefasFiltradas = _tarefas.where((tarefa) {
      final nomeLowerCase = tarefa.nome.toLowerCase();
      final textoPesquisaLowerCase = _textoPesquisa.toLowerCase();
      return nomeLowerCase.contains(textoPesquisaLowerCase);
    }).toList();

    return ListView.builder(
      itemCount: tarefasFiltradas.length,
      itemBuilder: (context, index) {
        Tarefa tarefa = tarefasFiltradas[index];
        return ItemTarefa(
          tarefa,
          onClick: () {
            _exibirDetalhesTarefa(tarefa);
          },
          onEdit: () {
            _editarTarefa(tarefa);
          },
          onDelete: () {
            _removerTarefa(tarefa);
          },
        );
      },
    );
  }
}

class ItemTarefa extends StatelessWidget {
  Tarefa _tarefa;
  VoidCallback onClick;
  VoidCallback onEdit;
  VoidCallback onDelete;

  ItemTarefa(this._tarefa, {required this.onClick, required this.onEdit, required this.onDelete});

  String formatarData(String dataHora) {
    final formatter = DateFormat('dd/MM');
    return formatter.format(DateTime.parse(dataHora));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onClick,
          leading: CircleAvatar(
            backgroundImage: AssetImage('img/tarefa.png'),
            backgroundColor: Colors.white,
          ),
          title: Text(
            this._tarefa.nome,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Row(
            children: [
              Text(
                formatarData(this._tarefa.data),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 10),
              Text(
                this._tarefa.horario.substring(0, 5),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit, color: Colors.black45),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirmação'),
                      content: Text('Deseja excluir a tarefa?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar', style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            onDelete();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Excluir',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.purple,
          indent: 70.0,
          endIndent: 20,
          thickness: 1.0,
          height: 0.0,
        ),
      ],
    );
  }
}
