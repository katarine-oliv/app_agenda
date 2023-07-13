
import 'package:flutter/material.dart';

class Tarefa{

    int? id_tarefa;
    String nome;
    String data = DateTime.now().toIso8601String();
    String horario = TimeOfDay.now().toString();
    String descricao;


    Map<String, dynamic> toMap(){
        return{
            'id_tarefa': id_tarefa,
            'nome': nome,
            'data': data,
            'horario': horario,
            'descricao': descricao,
        };
    }


    Tarefa(this.nome, this.data, this.horario, this.descricao);

    factory Tarefa.fromMap(Map<String, dynamic> map) {
      return Tarefa(
          map['nome'],
          map ['data'],
          map['horario'],
          map['descricao'],
      )..id_tarefa = map['id_tarefa'];
    }

}