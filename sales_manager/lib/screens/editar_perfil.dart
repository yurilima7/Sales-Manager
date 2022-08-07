import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/editar_dados.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({Key? key}) : super(key: key);

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {

  final _perfil = TextEditingController();

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
                    EditarDados(nome: "Bob", texto: _perfil),
      
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    const Botao(titulo: "Salvar", proxima: '/principal', desempilha: true)
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