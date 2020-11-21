class UpdateForm {
  String _quantidadeEnviada;

  UpdateForm(this._quantidadeEnviada);
  String toUpdate() => "?quantidadeEnviada=$_quantidadeEnviada";
}
