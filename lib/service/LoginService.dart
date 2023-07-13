import 'dart:convert';
import 'dart:io';
import 'package:app_agenda/model/login.dart';
import 'package:flutter/material.dart';
import '../dao/loginDAO.dart';

class LoginService{

    final String API_REST = "http://10.0.2.2:8080";

    Map<String, String> headers = <String, String>{
      "Content-type":"application/json",
    };

    String? tokenUsuarioLogado(){
      LoginDAO().getUsuarioLogado().then((value) {
        print("-->> token: "+value!.token);
        return value!.token;
      });
    }

    Future<bool> login( String login, String senha ) async{

      final conteudo = json.encode(<String, String>{'login': login, 'senha': senha});

      final httpClient = HttpClient(); // Inicialize a variável httpClient

      try {
        final request = await httpClient.postUrl(Uri.parse(API_REST + "/login"));
        request.headers.set('content-type', 'application/json');
        request.add(utf8.encode(conteudo));

        final response = await request.close();
        final responseBody = await response.transform(utf8.decoder).join();

        print("Status Code: " + response.statusCode.toString());
        print("valor: " + responseBody);

        if (response.statusCode == 200) {
          Login usuarioLogado = Login.fromJson(jsonDecode(responseBody));
          LoginDAO().adicionar(usuarioLogado);
          return true;
        }
      } catch (e) {
        print("Erro durante a requisição HTTP: $e");
      } finally {
        httpClient.close(); // Feche a conexão com o servidor
      }

      return false;
    }
}