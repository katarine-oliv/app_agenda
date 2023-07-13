import 'package:app_agenda/telas/android/login.dart';
import 'package:app_agenda/telas/android/tarefaLista.dart';
import 'package:flutter/material.dart';

class Principal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        theme: ThemeData(
        primarySwatch: Colors.purple,
    ),
    home: Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Home')) ,

          actions: [
            InkWell(
              /*onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                (context) => Login()
                ));
              },*/
              child: Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                //child: Icon(Icons.exit_to_app),
              ),
            )
          ],
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(decoration: BoxDecoration(color: Colors.purple),
                  accountName: Text('Katarine Oliveira'),
                  accountEmail: Text('kath@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('KO', style: TextStyle(fontSize: 40)),
                ),
              ),

              ListTile(leading: Icon(Icons.settings, color: Colors.purple,),
                title: Text('Configurações'),
              ),

              ListTile(leading: Icon(Icons.exit_to_app, color: Colors.purple,),
                title: Text('Sair'),
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                      (context) => Login()
                  ));
                },
              ),

            ],

          ),
        ),

        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 20.0),
                 child: Transform.scale(
                   scale: 0.9,
                   child: Image.asset('img/calendario.png'),
                 ),


               ),
                Text('Gerencie aqui seus compromissos e tarefas.',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return TarefaLista();
                    }));
                  },
                  child: Text('Tarefas'),
                ),
                SizedBox(height: 12.0),
                /*ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Anotacoes();
                    }));
                  },
                  child: Text('Anotações'),
                ),*/
                SizedBox(height: 12.0),
              ],
            ),
            ),
        )
    );

}
}
