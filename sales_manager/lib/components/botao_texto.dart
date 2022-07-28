import 'package:flutter/material.dart';

class BotaoTexto extends StatelessWidget {
  final String mensagem;
  final double tamanhoFonte;
  final String proxima;
  final bool desempilha;

  const BotaoTexto(
      {required this.mensagem,
      required this.proxima,
      Key? key,
      required this.tamanhoFonte,
      this.desempilha = true
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        desempilha? Navigator.pushNamedAndRemoveUntil(context, proxima, (route) => false)
        : Navigator.pushNamed(context, proxima);
      },

      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: tamanhoFonte),
      ),

      child: Text(mensagem),
    );
  }
}
