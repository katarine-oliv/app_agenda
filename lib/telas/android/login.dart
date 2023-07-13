import 'package:app_agenda/telas/android/CadastrarUs.dart';
import 'package:app_agenda/telas/android/dashboard.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("App Agenda"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(padding: EdgeInsets.symmetric(vertical: 80.0)),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    child: const Text("Entrar"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Principal();
                        }),
                      );
                    },
                  ),
                ), // Adiciona chave de fechamento para o primeiro ElevatedButton
                TextButton(

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return CadastroUs();
                      }),
                    );
                  },
                  child: const Text('Não tem uma conta? Cadastre-se aqui!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


