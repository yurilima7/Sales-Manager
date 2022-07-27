import 'package:flutter/material.dart';
import '../components/botao.dart';
import '../components/input_formulario.dart';

class AdicionarProduto extends StatelessWidget {
  const AdicionarProduto({Key? key}) : super(key: key);

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
                    const Text("Adicionar produto", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
          
                SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          
                Column(
                 
                  children: [
                    const InputFormulario(label: "Produto"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const InputFormulario(label: "Data"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const InputFormulario(label: "Preço"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const InputFormulario(label: "Quantidade"),
                  ],
                ),
      
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Botao(titulo: "Salvar", proxima: "/principal", desempilha: true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}