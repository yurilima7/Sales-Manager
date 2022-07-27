import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/input_formulario.dart';

class AdicionarCliente extends StatelessWidget {
  const AdicionarCliente({Key? key}) : super(key: key);

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
                    const Text("Adicionar cliente", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                Column(
                  
                  children: [
                    const InputFormulario(label: "Nome do Cliente"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const InputFormulario(label: "Bairro"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const InputFormulario(label: "Rua e N°"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const InputFormulario(label: "Telefone"),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          
                const Botao(titulo: "Prosseguir", proxima: "/addProduto")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
