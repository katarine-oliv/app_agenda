import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../dao/usuarioDAO.dart';
import '../../model/usuario.dart';
import 'login.dart';

class CadastroUs extends StatefulWidget {
  @override
  _CadastroUsState createState() => _CadastroUsState();
}

class _CadastroUsState extends State<CadastroUs> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Crie a sua conta'),

        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {

                          Usuario u = Usuario(1, 'Jane', 'jane@teste','123');
                          new Usuariodao().adicionar(u);

                          debugPrint('Cadastrou usuario');

                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                        child: Text('Cadastrar'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple, // Define a cor de fundo
                          onPrimary: Colors.white, // Define a cor do texto
                        ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
