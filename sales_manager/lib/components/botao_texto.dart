import 'package:flutter/material.dart';

class BotaoTexto extends StatelessWidget {
  final String mensagem;
  final String proxima;
  const BotaoTexto({required this.mensagem, required this.proxima, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, proxima, (route) => false);
      },
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 10),
      ),
      child: Text(mensagem),
    );
  }
}
