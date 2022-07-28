import 'package:flutter/material.dart';
import 'package:sales_manager/components/botao.dart';
import 'package:sales_manager/components/input_formulario.dart';

class Pagamento extends StatelessWidget {
  const Pagamento({Key? key}) : super(key: key);

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
                  const Text("Pagamento", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
          
              Expanded(
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const InputFormulario(label: "Digite o valor", acaoTeclado: false),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    const Botao(titulo: "Pagar", proxima: "/principal", desempilha: true)
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