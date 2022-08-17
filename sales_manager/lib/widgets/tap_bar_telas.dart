import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_manager/screens/configuracao.dart';
import 'package:sales_manager/screens/dados.dart';
import 'package:sales_manager/screens/principal.dart';
import 'package:flutter/material.dart';

class TabBarInferior extends StatefulWidget {
  final int telaAtual;

  const TabBarInferior({Key? key, required this.telaAtual}) : super(key: key);

  @override
  State<TabBarInferior> createState() => _TabBarInferiorState();
}

class _TabBarInferiorState extends State<TabBarInferior> {

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
  initState(){
    _cores[widget.telaAtual] = Colors.white;
    super.initState();
  }

  _proximaTela(int tela){
    if (tela == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => _telas[tela]),
        (route) => false,
      );
    }
    else{
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => _telas[tela]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            
            child: BottomNavigationBar(
              elevation: 3,          
              currentIndex: widget.telaAtual,
              backgroundColor: const Color(0xFF6D3F8C),
              fixedColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: _proximaTela,

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
    );
  }
}
