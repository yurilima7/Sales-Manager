import 'package:flutter/material.dart';
import 'package:sales_manager/mascaras/mascara_preco.dart';
import 'package:sales_manager/mascaras/mascara_telefone.dart';

class InputFormulario extends StatefulWidget {
  final String label, hint;
  final bool acaoTeclado, mascara, maskPreco;
  final TextEditingController controller;
  final TextInputType tipo;
  final Function(String) onChanged;
 
  const InputFormulario({
    Key? key,
    required this.label,
    this.acaoTeclado = true, this.mascara = false, this.maskPreco = false,
    this.tipo = TextInputType.text, 
    required this.controller, 
    required this.hint, required this.onChanged,
  }) : super(key: key);

  @override
  State<InputFormulario> createState() => _InputFormularioState();
}

class _InputFormularioState extends State<InputFormulario> {
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 3, // elevando o input
        borderRadius: BorderRadius.circular(30.0),

        child: TextFormField(

          controller: widget.controller,
          keyboardType: widget.tipo,
          onChanged: widget.onChanged,
          inputFormatters: widget.mascara 
            ? [widget.maskPreco? MaskPreco() : MaskTelefone()] 
            : [],

          style: const TextStyle(
              color: Color(0xFF734D8C)), // coloração do texto digitado

          textInputAction:
              widget.acaoTeclado ? TextInputAction.next : TextInputAction.go,

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

            labelText: widget.label, // texto a ser exibido na label
            hintText: widget.hint,

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
        ));
  }
}
