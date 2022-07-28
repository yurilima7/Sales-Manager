import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/editar_dados.dart';

class EditarCompra extends StatelessWidget {
  const EditarCompra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

        child: Padding(
          padding: const EdgeInsets.all(20),
      
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              
              children: [
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                    const Text("Editar compra", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                Column(
                  
                  children: [
                    const EditarDados(nome: "Camisa"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const EditarDados(nome: "18/06/2022"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const EditarDados(nome: "50"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const EditarDados(nome: "1"),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
                const Botao(titulo: "Salvar", proxima: "/principal")
              ],
            ),
          ),
        ),
      ),
    );
  }
}