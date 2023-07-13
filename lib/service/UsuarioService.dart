import 'dart:convert';
import 'dart:io';
import 'package:app_agenda/dao/usuarioDAO.dart';
import 'package:app_agenda/model/usuario_login.dart';
import 'package:flutter/material.dart';

class UsuarioService{

    final String API_REST = 'http://10.0.2.2:8080';

    Map<String, String> headers = <String, String>{
      'Content-type':'application/json'
    };

    Future<UsuarioLogin?> getUsuario_logado() async{
      print('Vai retornar o usuário...');


      return Usuariodao().getUserLogado().then((value) {
        return value;
      });
    }

    Future<bool> login({required String email, required String senha}) async{

      final conteudo = json.encode(<String, String>{'login': email, 'senha':senha});

      final httpClient = HttpClient();

      try {
        final request = await httpClient.postUrl(Uri.parse(API_REST + '/login'));
        request.headers.set('content-type', 'application/json');
        request.add(utf8.encode(conteudo));

        final response = await request.close();
        final responseBody = await response.transform(utf8.decoder).join();

        print('-->' + response.statusCode.toString());
        print('-->' + responseBody);

        if (response.statusCode == 200) {
          UsuarioLogin u = UsuarioLogin.fronJson(jsonDecode(responseBody));
          print('-->' + responseBody);
          Usuariodao().usuarioLogado(u);
          return true;
        }
      } catch (e) {
        print('Erro durante a requisição HTTP: $e');
      } finally {
        httpClient.close();
      }

      return false;
    }
}