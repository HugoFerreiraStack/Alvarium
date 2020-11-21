class Usuario {
  String _email;
  String _senha;
  String _loja;

  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "email": this.email,
      "loja": this.loja,
    };
    return map;
  }

  String get loja => _loja;
  set loja(String value) {
    _loja = value;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }
}
