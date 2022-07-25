import 'package:flutter/material.dart';

class BotaoAcesso extends StatelessWidget {
  final String local;
  final String titulo;

  const BotaoAcesso({required this.local, required this.titulo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Image.asset(
          local,
        ),

        Text(titulo,
            style: const TextStyle(color: Color(0xFF734D8C), fontSize: 12)),
      ],
    );
  }
}
