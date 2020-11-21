class Formulario {
  String _nomeLoja;
  String _produto;
  String _quantidade;
  String _quantidadeEnviada;
  String _dataPedido;

  Formulario(this._nomeLoja, this._produto, this._quantidade,
      this._quantidadeEnviada, this._dataPedido);

  String toParams() =>
      "?nomeLoja=$_nomeLoja&produto=$_produto&quantidade=$_quantidade&quantidadeEnviada=$_quantidadeEnviada&dataPedido=$_dataPedido";
}
