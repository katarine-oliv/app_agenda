class Usuario {
  int id;
  String nome;
  String email;
  String senha;

  Usuario(this.id, this.nome, this.email, this.senha);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

}