import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardInferior extends StatelessWidget {
  
  final bool ativo;
  final bool ativo2;
  final bool ativo3;

  const CardInferior(
      {Key? key,
      this.ativo = false,
      this.ativo2 = false,
      this.ativo3 = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String caminho = 'assets/icons/home.svg';
    const String caminho2 = 'assets/icons/dados.svg';
    const String caminho3 = 'assets/icons/configurações.svg';
    const String proximo = '/principal';
    const String proximo2 = '/dados';
    const String proximo3 = '/configuracao';

    // Função que retorna o widget de botão
    Widget botaoIcone(String nome, String proxTela, bool corPreta) {
      
      return Ink(
        width: MediaQuery.of(context).size.width * 0.11,
        child: IconButton(
          onPressed: () => {Navigator.pushNamed(context, proxTela)},
          icon: SvgPicture.asset(
            nome,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.25,
            allowDrawingOutsideViewBox: true,
            color: corPreta ? Colors.white : Colors.black,
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
            botaoIcone(caminho, proximo, ativo),
            botaoIcone(caminho2, proximo2, ativo2),
            botaoIcone(caminho3, proximo3, ativo3),
          ],
        ),
      ),
    );
  }
}
