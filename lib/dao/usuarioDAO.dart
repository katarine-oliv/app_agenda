import 'package:app_agenda/dao/openDataBase.dart';
import 'package:app_agenda/model/usuario_login.dart';
import 'package:sqflite/sqflite.dart';
import '../model/usuario.dart';

class Usuariodao{

  usuarioLogado(UsuarioLogin u) async{
    final Database db = await getDataBase();
    db.insert('USUARIO',u.toMap());
  }

  adicionar(Usuario u) async{
    final Database db = await getDataBase();
    db.insert('USUARIO',u.toMap());
  }

  Future<UsuarioLogin?> getUserLogado() async {
    // Get a reference to the database.
    print('GET USUARIO');
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> maps = await db.query('usuario');

    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return UsuarioLogin(maps[i]['login'], maps[i]['senha'], maps[i]['token']);
      })[0];
    } else {
      return null;
    }
  }

  Future<List<Usuario>> getUsuarios() async{
    final Database db = await getDataBase();

    final List<Map<String, dynamic>> maps = await db.query('USUARIO');

    return List.generate(maps.length, (i) {
      return Usuario(maps[i]['id'], maps[i]['nome'], maps[i]['email'], maps[i]['senha']);
    });
  }

}


// adicionar(Usuario usuario) async{
//     final Database tabela = await getDataBase();
//     tabela.insert('Usuario',usuario.toMap());
//   }
//
//   Future<List<Usuario>> getUsuarios()async{
//     final Database tabela = await getDataBase();
//     final List<Map<String,dynamic>>maps=await tabela.query('USUARIO');
//
//     return List.generate(maps.length, (i){
//       return Usuario(maps[i]['email'],maps[i]['senha']);
//     });
//
//   }
//
//   Future<void> deleteDataBae() => databaseFactory.deleteDatabase("tabela");