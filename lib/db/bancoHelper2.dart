import 'dart:io';

import 'package:projeto_ifpi/model/usuarios.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String tabelaNome = 'tabela_usuario';
  String colId = 'id';
  String colNome = 'nome';
  String colSenha = 'senha';
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await inicializaBanco();
    }

    return _database;
  }

  Future<Database> inicializaBanco() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String path = diretorio.path + 'usuarios2021.db';

    var bandoDeUsuarios =
        await openDatabase(path, version: 1, onCreate: _criaBanco);
    return bandoDeUsuarios;
  }

  void _criaBanco(Database db, int versao) async {
    await db.execute('CREATE TABLE $tabelaNome('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colNome TEXT,'
        '$colSenha TEXT);');
/*
De uma forma direta, esse seria o SQL
CREATE TABLE tabela_contato(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome TEXT,
email TEXT
);
*/
  }

  Future<List<Map<String, dynamic>>> getUsuarioMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM tabela_usuario");
    return result;
  }

  Future<int> inserirUsuario(Usuario usuario) async {
    Database db = await this.database;
    var result = await db.insert(tabelaNome, usuario.toMap());
    return result;
  }

  Future<int> atualizarUsuario(Usuario usuario, int id) async {
    var db = await this.database;
    var result = await db.rawUpdate(
        "UPDATE $tabelaNome SET $colNome = '${usuario.nome}', $colSenha = '${usuario.senha}' WHERE $colId = '$id'");
    return result;
  }

  Future<int> apagarUsuario(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tabelaNome WHERE $colId = $id');
    return result;
  }

  Future<List<Usuario>> getListaDeUsuario() async {
    var contatoMapList = await getUsuarioMapList();
    int count = contatoMapList.length;
    List<Usuario> listaDeUsuarios = List<Usuario>();
    for (int i = 0; i < count; i++) {
      listaDeUsuarios.add(Usuario.fromMapObject(contatoMapList[i]));
    }
    return listaDeUsuarios;
  }

  getUsuario() {}

  updateUsuario(usuarioRecebido) {}

  insertUsuario(usuarioRecebido) {}

  void deleteUsuario(int usuarioid) {}
}
