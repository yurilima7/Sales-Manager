import 'package:flutter/material.dart';

class ClienteSimples extends StatelessWidget {
  final String nome;
  final String valor;
  
  const ClienteSimples({Key? key, required this.nome, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        TextButton(
          onPressed: () {  Navigator.pushNamed(context, '/pagamento'); },
          child: Text(nome, style: const TextStyle(color: Colors.black, fontSize: 16)),
        ),

        TextButton(
          onPressed: () { Navigator.pushNamed(context, '/pagamento'); },
          child: Text(valor, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        
      ],
    );
  }
}