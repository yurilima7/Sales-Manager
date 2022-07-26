import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/principal.dart';
import 'package:sales_manager/widgets/botao.dart';
import 'package:sales_manager/widgets/editar_dados.dart';
import 'package:sales_manager/util/mensagens.dart';

class EditarPerfil extends StatefulWidget {
  final String nome;
  
  const EditarPerfil({Key? key, required this.nome}) : super(key: key);

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {

  final _perfil = TextEditingController();
  final db = FirebaseFirestore.instance;
  final usuarioID =
      FirebaseAuth.instance.currentUser!.uid; // pegando id do usuário

  _proximaTela(){
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute<void>(builder: (BuildContext context) => const Principal()), 
      (route) => false);
  }

  _editaPerfil() async{

    if(_perfil.text == ""){
      Mensagens().mensagem("Campo vazio!", true, context);
      return ;
    }

    await db.collection("Usuários").doc(usuarioID).update({
        "Usuário": _perfil.text
    });

    _proximaTela();
  }

  @override
  void dispose(){
    _perfil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

        child: Padding(
          padding: const EdgeInsets.all(20),
      
          child: Column(
      
            children: [
      
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Text("Editar Perfil", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
      
              Expanded(
                 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EditarDados(nome: widget.nome, texto: _perfil
                      , acaoTeclado: false, salvandoDados: (_) => _editaPerfil()),
      
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Botao(titulo: "Salvar", funcaoGeral: _editaPerfil)
                  ],
                ),
              ),      
            ],
          ),
        ),
      ),
    );
  }
}