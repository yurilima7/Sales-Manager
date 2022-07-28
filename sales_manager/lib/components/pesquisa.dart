import 'package:flutter/material.dart';

class Pesquisa extends StatefulWidget {
  final String label;
  const Pesquisa({Key? key, required this.label}) : super(key: key);

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(30),

      child: TextFormField(

        style: const TextStyle(
            color: Color(0xFF734D8C)), // coloração do texto digitado

        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF), // cor de fundo do input
          contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.width * 0.075),

          floatingLabelBehavior:
              FloatingLabelBehavior.never, // desativa a subida da label
         

          border: OutlineInputBorder(
            // definindo o tamanho das bordas
            borderRadius: BorderRadius.circular(30.0),
          ),

          labelText: widget.label, // texto a ser exibido na label
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

          suffixIcon: IconButton(
            onPressed: () => {}, 
            icon: const Icon(Icons.search),
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.075),
            color: const Color(0xFF734D8C), // define a coloração do icon
          ),
              
        ),
      ),
    );
  }
}
