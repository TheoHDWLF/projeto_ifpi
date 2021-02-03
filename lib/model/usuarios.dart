class Usuario {
  String nome;
  String senha;
  int id;
  Usuario(this.nome, this.senha);
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['nome'] = nome;
    map['senha'] = senha;
    return map;
  }

  Usuario.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.senha = map['senha'];
  }
}
