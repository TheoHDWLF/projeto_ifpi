import 'package:flutter/material.dart';
import 'package:projeto_ifpi/db/bancoHelper2.dart';
import 'package:projeto_ifpi/model/usuarios.dart';
//import 'package:projeto_ifpi/pages/home.page.dart';

import 'login.page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key, this.titulo}) : super(key: key);
  final String titulo;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //constantes para o formulário
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
//variavel para o banco
  static DatabaseHelper banco;
  int tamanhoDaLista = 0;
  List<Usuario> listaDeUsuarios;
  @override
  void initState() {
    // instanciamos o banco;
    banco = new DatabaseHelper();
    // chamamos o método para inicializar
    banco.inicializaBanco();

    //chamamos o metodo para retornar a lista de usuários do banco
    Future<List<Usuario>> listaDeUsuarios = banco.getListaDeUsuario();

    listaDeUsuarios.then((novaListaDeUsuarios) {
      //chamo o setState para alterar o estado
      //da lista com os novos valores
      setState(() {
        // pego os resultados do meu banco
        // atribuo a novaListaDeUsuarios a minha variavel local
        // assim a inicializando
        this.listaDeUsuarios = novaListaDeUsuarios;

        // chamo a funcão length para retornar
        // o tamanho da minha lista
        // e atribuir o valor a minha variavel local
        this.tamanhoDaLista = novaListaDeUsuarios.length;
      });
    });
  }

  // metodo para carregar a lista com novos dados
  _carregarLista() {
//crio objeto do banco novamente
    banco = new DatabaseHelper();
//inicializo o banco novamente
    banco.inicializaBanco();
//pego os novos registros do banco caso haja
    Future<List<Usuario>> noteListFuture = banco.getListaDeUsuario();
    noteListFuture.then((novaListaDeUsuarios) {
      //altero o estado da minha lista
      //com os novos valores retornado do banco
      setState(() {
        //atribuo os novos valores a minha variavel local
        this.listaDeUsuarios = novaListaDeUsuarios;

        // atribuo o novo tamanho a minha variavel local
        this.tamanhoDaLista = novaListaDeUsuarios.length;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(
          'Clique no botão azul para cadastro.',
          style: TextStyle(
            //fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        color: Colors.green[200],
        alignment: Alignment.center,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarUsuario(); //chamo o AlertDialog
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _adicionarUsuario() {
    _senha.text = '';
    _nome.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Novo Usuário"),
          content: new Container(
            child: new Form(
              key: _formKey,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  campoDeNome(),
                  Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                  campoDeSenha()
                ],
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Salvar"),
              onPressed: () {
                Usuario _usuario;
                if (_formKey.currentState.validate()) {
                  //crio o objeto do meu usuario, passando seus parametros
                  _usuario = new Usuario(_nome.text, _senha.text);

                  // chamo o metodo para inserir  usuario
                  banco.inserirUsuario(_usuario);

                  // carrego a lista com o novo registro
                  _carregarLista();

                  // limpo os campos do formulario
                  _formKey.currentState.reset();

                  // remove o AlertDialog da tela;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget campoDeNome() {
    return new TextFormField(
      controller: _nome,
      keyboardType: TextInputType.emailAddress,
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

  Widget campoDeSenha() {
    return new TextFormField(
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
    );
  }
}
