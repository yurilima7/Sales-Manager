import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_manager/screens/configuracao.dart';
import 'package:sales_manager/screens/dados.dart';
import 'package:sales_manager/screens/principal.dart';
import 'package:flutter/material.dart';

class PercorreTelas extends StatefulWidget {
  const PercorreTelas({Key? key}) : super(key: key);

  @override
  State<PercorreTelas> createState() => _PercorreTelasState();
}

class _PercorreTelasState extends State<PercorreTelas> {

  int _telaAtual = 0;
  
  final List<Widget> _telas = [
    const Principal(),
    const Dados(),
    const Configuracao(),
  ];

  final List<Color> _cores = [
    Colors.black,
    Colors.black,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {

    setState(() {
      for(var i = 0; i < 3; i++){
        if(i == _telaAtual){
          _cores[i] = Colors.white;
        }
        else{
          _cores[i] = Colors.black;
        }
      }
    });

    void _clique(int index){
      setState(() {
        _telaAtual = index;
      });
    }

    return Scaffold(

      body: _telas[_telaAtual],

      bottomNavigationBar: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
        ),
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.085,

            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
                  
              child: BottomNavigationBar(
                elevation: 3,          
                currentIndex: _telaAtual,
                backgroundColor: const Color(0xFF6D3F8C),
                fixedColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: _clique,
          
                items: [
                
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        height: MediaQuery.of(context).size.height * 0.034,
                        allowDrawingOutsideViewBox: true,
                        color: _cores[0],
                      ),
                    
                    label: "Home",
                  ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/dados.svg',
                        height: MediaQuery.of(context).size.height * 0.034,
                        allowDrawingOutsideViewBox: true,
                        color: _cores[1],
                      ),
                    
                    label: "Dados",
                  ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/configurações.svg',
                        height: MediaQuery.of(context).size.height * 0.034,
                        allowDrawingOutsideViewBox: true,
                        color: _cores[2],
                      ),
                    
                    label: "Configurações",
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
