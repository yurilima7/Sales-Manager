import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_manager/screens/estado_usuario.dart';

class Configuracao extends StatefulWidget {
  const Configuracao({Key? key}) : super(key: key);

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {

  void _proximaTela(String mensagem) async {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.greenAccent,
        duration: const Duration(seconds: 1),
      )
    );

    await Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const EstadoUsuario()),
        (route) => false,
      );
    }); 
  }

  _sair() async {
    await FirebaseAuth.instance.signOut();

    _proximaTela("Logout realizado com sucesso!");
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),

      child: Column(

        children: [

          Expanded(
            flex: 60,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
                Ink(
                          
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
            
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5
                      )
                    ]
                  ),
            
                  width: MediaQuery.of(context).size.width * 0.12,
            
                  child: IconButton(
                    onPressed: () => {}, 
                
                    icon: SvgPicture.asset(
                      'assets/icons/pessoa.svg',
                      height: MediaQuery.of(context).size.height * 0.025,
                      width: MediaQuery.of(context).size.width * 0.025,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
            
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Text("Bob", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            flex: 40,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
              children: [
                Column(
                
                  children: [
            
                    IconButton(
                      onPressed: () => {_sair()}, 
                      
                      icon: Icon(Icons.logout, color: const Color(0xFF6D3F8C), size: MediaQuery.of(context).size.height * 0.04),

                    ),
            
                    const Text("Sair ", style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
            
                Column(
                  
                  children: [
            
                    IconButton(
                      onPressed: () => { Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)}, 
                      
                      icon: Icon(Icons.delete, color: const Color(0xFF6D3F8C), size: MediaQuery.of(context).size.height * 0.04),
                      
                    ),
            
                      const Text("Deletar Conta", style: TextStyle(color: Color(0xFF6D3F8C), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}