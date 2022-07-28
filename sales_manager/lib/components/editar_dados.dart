import 'package:flutter/material.dart';

class EditarDados extends StatefulWidget {
  final String nome;
  const EditarDados({Key? key, required this.nome}) : super(key: key);

  @override
  State<EditarDados> createState() => _EditarDadosState();
}

class _EditarDadosState extends State<EditarDados> {

  late String nomeAtual;
  final texto = TextEditingController();

  @override
  void initState(){
    nomeAtual = widget.nome;
    texto.text = nomeAtual;

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        elevation: 3, // elevando o input
        borderRadius: BorderRadius.circular(30.0),

        child: TextField(

          autofocus: false,
          controller: texto,

          onChanged: (String valor) => setState(() {
            nomeAtual = valor;
          }),

          style: const TextStyle(
              color: Color(0xFF734D8C)), // coloração do texto digitado

          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFFFFF), // cor de fundo do input
            
            contentPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.025,
                horizontal: MediaQuery.of(context).size.width * 0.075),

            floatingLabelBehavior:
                FloatingLabelBehavior.never, // desativa a subida da label

            border: OutlineInputBorder(
              // definindo o tamanho das bordas
              borderRadius: BorderRadius.circular(30.0),
            ),

            //labelText: widget.label, // texto a ser exibido na label
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFFFFFFF),
              ), // define a cor da borda quando não selecionado o input
              borderRadius: BorderRadius.circular(
                30.0,
              ), // define as bordas, para manter o padrão
            ),

            labelStyle: const TextStyle(
              color: Color(0xFF734D8C),
            ), // define a coloração do texto da label
          ),
        )
    );
  }
}
