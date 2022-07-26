import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String titulo;
  final Function()? funcaoGeral;

  const Botao({required this.titulo, this.funcaoGeral, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle botaoDeSelecao = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 3,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width *
          0.4, // definindo a largura do botão
      height: MediaQuery.of(context).size.height *
          0.07, // definindo a altuta do botão
      child: ElevatedButton(
        style: botaoDeSelecao,
        onPressed: () {
          funcaoGeral!();     
        },
        child: Text(titulo, textAlign: TextAlign.center),
      ),
    );
  }
}
