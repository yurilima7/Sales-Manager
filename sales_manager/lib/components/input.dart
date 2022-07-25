import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String label;
  final bool senha;
  final bool usuario;

  const Input({required this.label, this.usuario = false, this.senha = false, Key? key})
      : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool verSenha = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, // elevando o input
      borderRadius: BorderRadius.circular(30.0),

      child: TextFormField(
        obscureText: widget.senha
            ? verSenha
            : false, // caso senha seja true ativa/desativa a ocultação da senha digitada
            
        keyboardType: widget.usuario
          ? TextInputType.text 
          : widget.senha
                ? TextInputType.text
                : TextInputType
                    .emailAddress, // definindo o tipo de teclado com base no tipo de entrada

        style: const TextStyle(
            color: Color(0xFF734D8C)), // coloração do texto digitado

        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFFFFFF), // cor de fundo do input
          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
          
          floatingLabelBehavior:
              FloatingLabelBehavior.never, // desativa a subida da label
          prefixIcon: widget.usuario
            ? const Icon(Icons.person, color: Color(0xFF734D8C)) 
            : widget.senha
                ? const Icon(Icons.login, color: Color(0xFF734D8C))
                : const Icon(Icons.email, color: Color(0xFF734D8C)),

          border: OutlineInputBorder(
            // definindo o tamanho das bordas
            borderRadius: BorderRadius.circular(30.0),
          ),

          labelText: widget.label, // texto a ser exibido na label
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color(
                    0xFFFFFFFF),), // define a cor da borda quando não selecionado o input
            borderRadius: BorderRadius.circular(
                30.0,), // define as bordas, para manter o padrão
          ),

          labelStyle: const TextStyle(
              color: Color(0xFF734D8C),), // define a coloração do texto da label

          suffixIcon: widget.senha
              ? IconButton(
                  // verifica se é input de senha
                  icon: Icon(
                    (!verSenha
                        ? Icons.visibility
                        : Icons
                            .visibility_off), // verifica se exibirá o icone do olho como aberto ou fechado
                  ),

                  onPressed: () {
                    // função que atualiza a exibição da senha pós precionar o botão do olho
                    widget.senha
                        ? setState(() {
                            verSenha = !verSenha;
                          })
                        : verSenha = false;
                  },

                  color: const Color(0xFF734D8C), // define a coloração do icon
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
