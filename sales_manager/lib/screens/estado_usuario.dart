import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_manager/screens/login.dart';
import 'package:sales_manager/screens/principal.dart';

class EstadoUsuario extends StatefulWidget {
  const EstadoUsuario({Key? key}) : super(key: key);

  @override
  State<EstadoUsuario> createState() => _EstadoUsuarioState();
}

class _EstadoUsuarioState extends State<EstadoUsuario> {

  late StreamSubscription streamSubscription;

  @override
  void initState() {
    _verifica();    
    super.initState();
  }

  @override
  void dispose(){
    streamSubscription.cancel();
    super.dispose();
  }

  _verifica() async{
    streamSubscription = FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Principal()), (route) => false);
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
