import 'package:flutter/material.dart';

class CardDados extends StatelessWidget {
  final String nome;
  const CardDados({Key? key, required this.nome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6D3F8C),
      elevation: 3,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
            Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const Text("R\$ 200", style: TextStyle(color: Colors.white, fontSize: 16)),
            
          ],
        ),
      ),
    );
  }
}