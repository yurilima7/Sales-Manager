import 'package:flutter/material.dart';

class BotaoTexto extends StatelessWidget {
  final String mensagem;
  final double tamanhoFonte;
  final Function() passaTela;

  const BotaoTexto(
      {required this.mensagem,
      Key? key,
      required this.tamanhoFonte,
      required this.passaTela,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => passaTela(),

      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: tamanhoFonte),
      ),

      child: Text(mensagem),
    );
  }
}
