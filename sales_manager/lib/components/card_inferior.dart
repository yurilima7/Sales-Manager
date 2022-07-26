import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardInferior extends StatelessWidget {
  final String caminho;
  final String caminho2;
  final String caminho3;

  const CardInferior(
      {Key? key,
      required this.caminho,
      required this.caminho2,
      required this.caminho3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget botaoIcone(String nome) { // Função que retorna o widget de botão
      return Ink(
        width: MediaQuery.of(context).size.width * 0.1,

        child: IconButton(
          onPressed: () => {},

          icon: SvgPicture.asset(
            nome,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.25,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      );
    }

    return Card(
      color: const Color(0xFF6D3F8C),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: [
            botaoIcone(caminho),
            botaoIcone(caminho2),
            botaoIcone(caminho3),
          ],
        ),
      ),
    );
  }
}
