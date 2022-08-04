import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Configuracao extends StatelessWidget {
  const Configuracao({Key? key}) : super(key: key);

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
                        onPressed: () => { Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false)}, 
                        
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