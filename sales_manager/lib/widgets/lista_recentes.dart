import 'package:flutter/material.dart';
import 'package:sales_manager/util/formato_numero.dart';

class ListaRecentes extends StatelessWidget {
  final String cliente;
  final String produto;
  final double valor;

  const ListaRecentes({Key? key, required this.cliente, required this.produto, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(cliente,
                style: const TextStyle(
                  color: Color(0xFF6D3F8C),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
            ),

            Text(produto,
                style: const TextStyle(color: Color(0xFF734D8C), fontSize: 12)),
          ],
        ),
        
        Text(
          FormatoNumero().formatoBR(valor),
          
          style: const TextStyle(
            color: Color(0xFF6D3F8C),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
