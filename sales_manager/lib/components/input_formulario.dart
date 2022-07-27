import 'package:flutter/material.dart';

class InputFormulario extends StatelessWidget {
  final String label;
  const InputFormulario({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, // elevando o input
      borderRadius: BorderRadius.circular(30.0),

      child: TextFormField(
        
        style: const TextStyle(
            color: Color(0xFF734D8C)), // coloração do texto digitado
        
        textInputAction: TextInputAction.next,


        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF), // cor de fundo do input
          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025, horizontal: MediaQuery.of(context).size.width * 0.075),
          

          floatingLabelBehavior:
              FloatingLabelBehavior.never, // desativa a subida da label

          border: OutlineInputBorder(
            // definindo o tamanho das bordas
            borderRadius: BorderRadius.circular(30.0),
          ),

          labelText: label, // texto a ser exibido na label
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color(
                    0xFFFFFFFF),), // define a cor da borda quando não selecionado o input
            borderRadius: BorderRadius.circular(
                30.0,), // define as bordas, para manter o padrão
          ),

          labelStyle: const TextStyle(
              color: Color(0xFF734D8C),), // define a coloração do texto da label
        ),
      )
    );
  }
}