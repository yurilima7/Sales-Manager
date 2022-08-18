import 'package:flutter/material.dart';
import 'package:sales_manager/screens/adicionar_produto.dart';
import 'package:sales_manager/screens/seleciona_compra.dart';
import 'package:sales_manager/util/formato_numero.dart';

class CardLista extends StatelessWidget {
  final String nome, id;
  final double valor;
  final bool selecionaProduto;

  const CardLista({Key? key, required this.nome, required this.valor, 
                  required this.id, this.selecionaProduto = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    _proximaTela(){
      selecionaProduto
        ?
          Navigator.push(
          context, 
          MaterialPageRoute<void>(builder: (BuildContext context) => 
            SelecionaProduto(nomeCliente: nome, idCliente: id, divida: valor))
          )
        :
          Navigator.push(
          context, 
          MaterialPageRoute<void>(builder: (BuildContext context) => 
            AdicionarProduto(nome: nome, clienteExistente: true, divida: valor))
          );
    }

    return GestureDetector(
      onTap: _proximaTela,

      child: Card(
        color: const Color(0xFF6D3F8C),
        elevation: 3,
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        
        child: Container(
          padding: EdgeInsets.only(
            left: 20, 
            right: 20, 
            top: MediaQuery.of(context).size.height * 0.001, 
            bottom: MediaQuery.of(context).size.height * 0.001,
          ),
    
          child: ListTile(
            title: Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        
            trailing: Text(FormatoNumero().formatoBR(valor), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
