import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotaoAcesso extends StatelessWidget {
  final String caminho;
  final String titulo;
  final String proximo;

  const BotaoAcesso({required this.caminho, required this.titulo, Key? key, required this.proximo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      
        Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5
              )
            ]
          ),

          width: MediaQuery.of(context).size.width * 0.11,

          child:  IconButton(
            onPressed: () => {
              Navigator.pushNamed(context, proximo)
            },

            icon: SvgPicture.asset(
              caminho,
              height:MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
              allowDrawingOutsideViewBox: true,
            ),
            
          ),
        ),
       
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),

        Text(titulo,
            style: const TextStyle(color: Color(0xFF734D8C), fontSize: 12)),
      ],
    );
  }
}
