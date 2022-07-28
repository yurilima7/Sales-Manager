import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/botao_social.dart';
import 'package:sales_manager/components/botao_texto.dart';
import 'package:sales_manager/components/input.dart';

class CriarConta extends StatelessWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
      
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/sales manager.png',
                     width: MediaQuery.of(context).size.width * 0.3,
                  ),
      
                  const Text("SALES MANAGER", style: TextStyle(fontSize: 20, fontFamily: 'Audiowide-Regular', color: Color(0xFF6D3F8C))),
      
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  
                  const Text("Cadastre-se com", style: TextStyle(fontSize: 18, color: Color(0xFF734D8C))),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      BotaoSocial(
                          titulo: "Google", google: true, caminho: "assets/icons/google.svg"),
                      BotaoSocial(
                          titulo: "Facebook", google: false, caminho: "assets/icons/facebook.svg"),
                      
                    ],
                  ),
      
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            
                  const Input(label: "Usuário", usuario: true),
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                  const Input(label: "E-Mail"), // input de inserção do e-mail
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
                  const Input(
                      label: "Senha", senha: true), // input de inserção da senha
            
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            
                  const Botao(titulo: "Registrar", proxima: ''),
            
                  const BotaoTexto(
                      mensagem: "Possui uma conta? Faça login!", 
                      proxima: '/login',
                      tamanhoFonte: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}