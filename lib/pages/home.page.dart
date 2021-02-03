import 'package:flutter/material.dart';
import 'package:projeto_ifpi/pages/contatoPage.dart';
import 'package:projeto_ifpi/pages/usuarioPage.dart';
import 'maps.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Text("OP"),
        title: Text("Menu"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Container(
            height: 150.0,
            margin: EdgeInsets.only(
              top: 50,
              bottom: 90,
            ),
            child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Logotipo_IFET.svg/764px-Logotipo_IFET.svg.png"),
          ),
          GestureDetector(
            child: Container(
              height: 60.0,
              //width: 160.0,
              color: Colors.orange[300],
              margin: EdgeInsets.fromLTRB(35, 10, 35, 0),
              //padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Contatos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  //textAlign: TextAlign.right,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListaDeContatos(titulo: 'Lista de Contatos'),
                ),
              );
            },
          ),
          GestureDetector(
            child: Container(
              height: 60.0,
              //width: 160.0,
              color: Colors.orange[300],
              margin: EdgeInsets.fromLTRB(35, 10, 35, 0),
              //padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Mapa",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  //textAlign: TextAlign.right,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Maps(),
                ),
              );
            },
          ),
          GestureDetector(
            child: Container(
              height: 60.0,
              //width: 160.0,
              color: Colors.orange[300],
              margin: EdgeInsets.fromLTRB(35, 10, 35, 0),
              //padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Usuários",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  //textAlign: TextAlign.right,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListaDeUsuarios(titulo: 'Lista de Contatos'),
                ),
              );
            },
          ),
          GestureDetector(
            child: Container(
              height: 60.0,
              //width: 160.0,
              color: Colors.orange[300],
              margin: EdgeInsets.fromLTRB(35, 10, 35, 0),
              //padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Extra",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  //textAlign: TextAlign.right,
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
