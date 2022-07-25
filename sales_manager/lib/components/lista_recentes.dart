import 'package:flutter/material.dart';

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
          children: const [
            Text("Fulano",
                style: TextStyle(
                    color: Color(0xFF6D3F8C),
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            Text("Cinto",
                style: TextStyle(color: Color(0xFF734D8C), fontSize: 12)),
          ],
        ),
        
        Text(
          "R\$ $valor",
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
