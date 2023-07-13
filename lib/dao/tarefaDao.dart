import 'package:app_agenda/dao/openDataBase.dart';
import 'package:sqflite/sqflite.dart';

import '../model/tarefa.dart';

class TarefaDao {

  Future<void> adicionar(Tarefa tarefa) async {
    final db = await getDataBase();
    final id = await db.insert(
        'Tarefa',
        tarefa.toMap()..['id_tarefa'] = null,
    conflictAlgorithm: ConflictAlgorithm.replace);
    tarefa.id_tarefa = id;
  }

  Future<void> remover(int id) async {
    final db = await getDataBase();
    await db.delete(
      'Tarefa',
      where: 'id_tarefa = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase(String s) async {
    await deleteDatabase(s);
  }

  Future<void> atualizar(Tarefa tarefa) async {
    final db = await getDataBase();

    await db.update(
        'Tarefa',
        tarefa.toMap(),
        where: 'id_tarefa = ?',
        whereArgs: [tarefa.id_tarefa],
    );

  }


  Future<List<Tarefa>> getTarefas() async {
    final db = await getDataBase();
    final List<Map<String, dynamic>> maps = await db.query('Tarefa');

    return List.generate(maps.length, (index) {
      return Tarefa(
        maps[index]['nome'],
        maps[index]['data'],
        maps[index]['horario'],
        maps[index]['descricao'],
      )..id_tarefa = maps[index]['id_tarefa'];
    });
  }

}
