import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotaoSocial extends StatelessWidget {
  final String titulo;
  final String caminho;
  final bool google;
  final Function() loginSocial;

  const BotaoSocial({required this.titulo, required this.google, 
    required this.caminho, Key? key, required this.loginSocial})
    : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Widget svg = SvgPicture.asset(
      caminho,
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.035,
    );

    final ButtonStyle botaoDeSelecao = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 3,
      primary: google? Colors.white : const Color(0xFF1778F2),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width *
          0.4, // definindo a largura do botão
      height: MediaQuery.of(context).size.height *
          0.07, // definindo a altuta do botão
      child: ElevatedButton(
        onPressed: () async => loginSocial(),
        style: botaoDeSelecao, 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            svg,
            Text(titulo, style: TextStyle(color: google? const Color(0xFF734D8C):Colors.white))
          ],
        ),   
      ),
    );
  }
}
