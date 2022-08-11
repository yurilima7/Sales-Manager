import 'package:flutter/material.dart';
import 'package:sales_manager/objects/produto.dart';
import 'package:sales_manager/screens/pagamento.dart';

class ClienteSimples extends StatelessWidget {
  final Produto produtos;
  final String idCliente;
  final double divida, totalCompra;
  
  const ClienteSimples({Key? key, required this.produtos, 
        required this.idCliente, required this.divida, required this.totalCompra}) 
        : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute<void>(builder: (BuildContext context) => 
                Pagamento(nome: produtos.nome, totalCompra: totalCompra, idCliente: idCliente, idProduto: produtos.id, dividaCliente: divida)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(produtos.nome, style: const TextStyle(color: Colors.black, fontSize: 16)),
              Text("Restante para quitamento: R\$ ${produtos.total}", style: const TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute<void>(builder: (BuildContext context) => 
                Pagamento(nome: produtos.nome, totalCompra: totalCompra, idCliente: idCliente, idProduto: produtos.id, dividaCliente: divida)),
            );
          },
          child: Text("R\$ ${produtos.preco}", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        
      ],
    );
  }
}