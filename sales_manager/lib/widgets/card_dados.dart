import 'package:flutter/material.dart';

class CardDados extends StatelessWidget {
  final String nome;
  final double valor;

  const CardDados({Key? key, required this.nome, required this.valor}) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6D3F8C),
      elevation: 3,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      
      child: Container(
        padding: EdgeInsets.only(
          left: 20, 
          right: 20, 
          top: MediaQuery.of(context).size.height * 0.01, 
          bottom: MediaQuery.of(context).size.height * 0.01,
        ),

        child: ListTile(
          
          title: Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16)),
        
          trailing: Text("R\$ $valor", style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}