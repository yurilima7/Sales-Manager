import 'package:flutter/material.dart';
import 'package:sales_manager/objects/produto.dart';
import 'package:sales_manager/screens/pagamento.dart';

class ClienteSimples extends StatelessWidget {
  final Produto produtos;
  
  const ClienteSimples({Key? key, required this.produtos}) : super(key: key);

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
                Pagamento(nome: produtos.nome, valor: produtos.preco)),
            );
          },
          child: Text(produtos.nome, style: const TextStyle(color: Colors.black, fontSize: 16)),
        ),

        TextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute<void>(builder: (BuildContext context) => 
                Pagamento(nome: produtos.nome, valor: produtos.preco)),
            );
          },
          child: Text("R\$ ${produtos.preco}", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        
      ],
    );
  }
}