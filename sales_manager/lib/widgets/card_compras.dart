import 'package:flutter/material.dart';
import 'package:sales_manager/objects/produto.dart';
import 'package:sales_manager/screens/pagamento.dart';

class ClienteSimples extends StatelessWidget {
  final Produto produtos;
  final String idCliente;
  final double divida, totalCompra;

  const ClienteSimples(
      {Key? key,
      required this.produtos,
      required this.idCliente,
      required this.divida,
      required this.totalCompra})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    _pagamento(){
      Navigator.push(
        context, 
        MaterialPageRoute<void>(builder: (BuildContext context) => 
          Pagamento(nome: produtos.nome, totalCompra: totalCompra, 
          idCliente: idCliente, idProduto: produtos.id, dividaCliente: divida),
        ),
      );
    }

    return GestureDetector(
      onTap: _pagamento,

      child: Card(
        elevation: 3,
        color: const Color(0xFF6D3F8C),
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    
        child: Container(
          padding: const EdgeInsets.all(15), // afastamento

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ListTile(
              
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                  children: [
                    Text(
                      produtos.nome, 
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                
                    Text(
                      "R\$ ${produtos.preco}", 
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                
                  children: [
                    const Divider(color: Colors.white),

                    Text(
                      "Quantidade: ${produtos.quantidade}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                
                    Text(
                      "Restam: R\$ $totalCompra",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
