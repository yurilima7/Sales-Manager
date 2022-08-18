import 'package:sales_manager/util/formato_numero.dart';

class Produto {
  String nome;
  DateTime data;
  int quantidade;
  double preco, total;
  String id;

  Produto(this.nome, this.data, this.quantidade, this.preco, this.id, this.total);

  String exibePreco() {
    return FormatoNumero().formatoBR(preco);
  }

  String exibeTotal() {
    return FormatoNumero().formatoBR(total);
  }
}
