//import 'package:projeto_ifpi/pages/reset-password.page.dart';
import 'package:projeto_ifpi/db/bancoHelper2.dart';
//import 'package:projeto_ifpi/model/usuarios.dart';
import 'package:projeto_ifpi/pages/home.page.dart';
import 'package:projeto_ifpi/pages/signup.page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.titulo}) : super(key: key);
  final String titulo;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
//variavel para o banco
  static DatabaseHelper banco;
  @override
  void initState() {
    // instanciamos o banco;
    banco = new DatabaseHelper();
    // chamamos o método para inicializar
    banco.inicializaBanco();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Logotipo_IFET.svg/764px-Logotipo_IFET.svg.png"),
              ),
              SizedBox(
                height: 20,
              ),
              campoDeNome(),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _senha,
                obscureText: true,
                validator: (valor) {
                  if (valor.isEmpty && valor.length == 0) {
                    return "Campo Obrigatório"; // retorna a mensagem
                    // caso o campo esteja vazio
                  }
                },
                decoration: new InputDecoration(
                  hintText: 'Senha',
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                height: 60,
                //alignment: Alignment.center,
                color: Colors.orange[300],
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      //textAlign: TextAlign.right,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                alignment: Alignment.centerLeft,
                color: Colors.orange[300],
                child: SizedBox.expand(
                  child: FlatButton(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      //textAlign: TextAlign.right,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget campoDeNome() {
    return new TextFormField(
      controller: _nome,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor.isEmpty && valor.length == 0) {
          return "Campo Obrigatório"; // retorna a mensagem
          //caso o campo esteja vazio
        }
      },
      decoration: new InputDecoration(
        hintText: 'Email',
        labelText: 'Email do usuário',
        border: OutlineInputBorder(),
      ),
    );
  }
}
