import 'package:flutter/material.dart';
import 'package:sales_manager/screens/ficha_cliente.dart';

class CardCliente extends StatelessWidget {

  final String nome;
  final String telefone;
  final String bairro;
  final String rua;
  final double divida;
  final String id;
  const CardCliente({Key? key, required this.nome, required this.telefone, required this.bairro
    , required this.rua, required this.divida, required this.id}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF6D3F8C),
      elevation: 3,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      
      child: ElevatedButton(

        onPressed: () { 
          Navigator.push(
            context, 
            MaterialPageRoute<void>(builder: (BuildContext context) => FichaCliente(idCliente: id, nome: nome, saldoDevedor: divida)),
          );
        },

        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 3,
        ),

        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          
          child: Column(
            
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Text(nome, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          
                  IconButton(
                    onPressed: () => {}, 
                    
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
          
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(telefone, style: const TextStyle(color: Colors.white, fontSize: 12, )),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(rua, style: const TextStyle(color: Colors.white, fontSize: 12)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(bairro, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ],
              ),
          
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                children: [
                  const Text("Saldo Devedor", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("R\$ $divida", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}