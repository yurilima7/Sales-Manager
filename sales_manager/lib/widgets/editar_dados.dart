import 'package:flutter/material.dart';
import 'package:sales_manager/mascaras/mascara_preco.dart';
import 'package:sales_manager/mascaras/mascara_telefone.dart';

class EditarDados extends StatefulWidget {
  final String nome;
  final TextEditingController texto;
  final bool mascara, maskPreco, acaoTeclado;
  final TextInputType tipo;
  final Function(String)? salvandoDados;

  const EditarDados({Key? key, required this.nome, required this.texto
    , this.mascara = false, this.tipo = TextInputType.text
    , this.maskPreco = false, this.salvandoDados
    , this.acaoTeclado = true}) : super(key: key);

  @override
  State<EditarDados> createState() => _EditarDadosState();
}

class _EditarDadosState extends State<EditarDados> {

  late String nomeAtual;

  @override
  void initState(){
    nomeAtual = widget.nome;
    widget.texto.text = nomeAtual;

    return super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
        elevation: 3, // elevando o input
        borderRadius: BorderRadius.circular(30.0),

        child: TextFormField(

          keyboardType: widget.tipo,
          controller: widget.texto,
          inputFormatters: widget.mascara 
            ? [widget.maskPreco ? MaskPreco() : MaskTelefone()]
            : [],
          onFieldSubmitted: widget.salvandoDados,

          onChanged: (String valor) => setState(() {
            nomeAtual = valor;
          }),

          style: const TextStyle(
              color: Color(0xFF734D8C)), // coloração do texto digitado

          textInputAction:
              widget.acaoTeclado ? TextInputAction.next : TextInputAction.done,

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
