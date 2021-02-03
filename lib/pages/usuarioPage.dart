import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_ifpi/db/bancoHelper2.dart';
//import 'package:contatos/pages/contato_page.dart';
//import "package:contatos/pages/home_page.dart";
//import 'db/bancoHelper.dart';
import 'package:projeto_ifpi/model/usuarios.dart';

class ListaDeUsuarios extends StatefulWidget {
  ListaDeUsuarios({Key key, this.titulo}) : super(key: key);
  final String titulo;
  @override
  _ListaDeUsuariosState createState() => _ListaDeUsuariosState();
}

class _ListaDeUsuariosState extends State<ListaDeUsuarios> {
//constantes para o formulário
  final _senha = TextEditingController();
  final _nome = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
//variavel para o banco
  static DatabaseHelper banco;
// variaveis para a lista de usuários
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuários"),
      ),
      body: _listaDeUsuarios(),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: () {
      //    _adicionarUsuario(); //chamo o AlertDialog
      //  },
      //  child: Icon(Icons.add),
      //  backgroundColor: Colors.blueAccent,
      //),
    );
  }

  void _removerItem(Usuario contato, int index) {
    // chamo novamente para atualizar a lista ao remover item
    setState(() {
      // minha lista de contatos atual,
      // recebe a nova lista,
      //menos o indice que eu estou passando
      listaDeUsuarios = List.from(listaDeUsuarios)..removeAt(index);

      // pego o id do contato para remove-lo
      banco.apagarUsuario(contato.id);
      //minha lista recebe ela mesma,
      // meno uma posicao que é o indice que eu removi;
      tamanhoDaLista = tamanhoDaLista - 1;
    });
  }

  void _atualizarUsuario(Usuario usuario) {
    _senha.text = usuario.senha;
    _nome.text = usuario.nome;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Atualizar Usuário"),
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
              child: new Text("Atualizar"),
              onPressed: () {
                Usuario _usuario;

                // faz a validacao do formulario
                if (_formKey.currentState.validate()) {
                  // crio um novo objeto  passando seus atributos
                  _usuario = new Usuario(_nome.text, _senha.text);

                  //chamo o metodo para atualizar com os novos valores
                  banco.atualizarUsuario(_usuario, usuario.id);

                  //carrego a lista com os novos valores
                  _carregarLista();

                  //reseto os campos do formulario
                  _formKey.currentState.reset();

                  // retiro o alerta da tela
                  Navigator.of(context).pop();
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
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor.isEmpty && valor.length == 0) {
          return "Campo Obrigatório"; // retorna a mensagem
          //caso o campo esteja vazio
        }
      },
      decoration: new InputDecoration(
        hintText: 'Nome',
        labelText: 'Nome do usuário',
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

  Widget _listaDeUsuarios() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tamanhoDaLista,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ListTile(
            //pego o nome do usuario com base na posicao da lista
            title: Text(listaDeUsuarios[index].nome),

            //pego a senha do usuario com base na posicao da lista
            //subtitle: Text("******"),

            leading: CircleAvatar(
              //pego o nome do usuario com base no indice
              // da lista e pego a primeira letra do nome
              child: Text(
                listaDeUsuarios[index].nome[0],
              ),
            ),

            trailing: IconButton(
              icon: Icon(Icons.delete),
              //color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Excluir Usuário"),
                      content: Text("Deseja excluir?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("Excluir"),
                          onPressed: () {
                            setState(() {
                              _removerItem(listaDeUsuarios[0], index);
                            });
                            Navigator.of(context).pop();
                          },
                        )
                      ], //widget
                    );
                  },
                );
              },
            ),
          ),

          //clique curto para remover
          onTap: () => _atualizarUsuario(listaDeUsuarios[index]),
        );
      },
    );
  }
}

//_removerItem(listaDeUsuarios[0], index)
