import 'package:flutter/material.dart';
import 'package:sales_manager/screens/criar_conta.dart';
import 'package:sales_manager/screens/login.dart';
import 'package:sales_manager/screens/principal.dart';

main() => runApp(SalesManager());

class SalesManager extends StatelessWidget {
  SalesManager({Key? key}) : super(key: key);

  final ThemeData tema = ThemeData(); // adicionando o tema da aplicação

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: const Color(0xFF6D3F8C),
          secondary: const Color(0xFFE7DCF2),
        ),
        scaffoldBackgroundColor: const Color(0xFFE7DCF2),
      ),
      initialRoute: '/login',
      routes: {
        '/login' : (context) => const Login(),
        '/criarConta' : (context) => const CriarConta(),
        '/principal' : (context) => const Principal()
      },
    );
  }
}