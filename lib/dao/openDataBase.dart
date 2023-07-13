import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase()async{

  final String path = join(await getDatabasesPath(),'aa.db');
  return openDatabase(
      path,
      onCreate:(db,version){
        db.execute('CREATE TABLE USUARIO (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT, senha TEXT) ');
        db.execute('CREATE TABLE LOGIN (id INTEGER PRIMARY KEY, login TEXT, senha TEXT, permissao TEXT, token TEXT) ');
        db.execute('CREATE TABLE TAREFA (id_tarefa INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, data TEXT, horario TEXT, descricao TEXT)');
      },
      version: 1);
}
