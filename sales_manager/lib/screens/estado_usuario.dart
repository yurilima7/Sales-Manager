import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/login.dart';
import 'package:sales_manager/screens/tap_bar_telas.dart';

class EstadoUsuario extends StatefulWidget {
  const EstadoUsuario({Key? key}) : super(key: key);

  @override
  State<EstadoUsuario> createState() => _EstadoUsuarioState();
}

class _EstadoUsuarioState extends State<EstadoUsuario> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      if (user == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PercorreTelas()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
