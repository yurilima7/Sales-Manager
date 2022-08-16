import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sales_manager/util/mensagens.dart';

class Autenticacao {
  
  static Future<User?> registrarGoogle({required BuildContext context}) async{
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    User? user;

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount!.authentication;
      
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
        
      user = userCredential.user;

    } on FirebaseAuthException catch (e) {
      
      String retorno = "Falha na autenticação!";

      if (e.code == 'account-exists-with-different-credential') {
        retorno = "Este e-mail já está cadastrado!";
      }
      else if (e.code == 'invalid-credential') {
        retorno = "Conta inválida!";
      }

      Mensagens().mensagem(retorno, true, context);
        
    }

    return user;
  }

  static Future <User?> registrarFacebook({required BuildContext context}) async {
    final firebaseAuth = FirebaseAuth.instance;
    final facebookAuth = FacebookAuth.instance;
    User? user;

    try {
      
      final loginResult = await facebookAuth.login();

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider
                    .credential(loginResult.accessToken!.token);

      final UserCredential userCredential = await firebaseAuth
            .signInWithCredential(facebookAuthCredential);

      user = userCredential.user;

    } on FirebaseAuthException catch (e) {
        String retorno = "Falha na autenticação!";

        if (e.code == 'account-exists-with-different-credential') {
          retorno = "Este e-mail já está cadastrado!";
        }
        else if (e.code == 'invalid-credential') {
          retorno = "Conta inválida!";
        }

        Mensagens().mensagem(retorno, true, context);
        
      }

    return user;
  }

  static Future<User?> loginEmail({
    required BuildContext context, required String email, required String senha}) 
    async {

      User? user;

      try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      user = userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      String retorno = "Falha na autenticação";

      if (e.code == 'user-not-found') {
        retorno = "Este e-mail não está cadastrado!";
      } else if (e.code == 'wrong-password') {
        retorno = "Sua senha está incorreta, tente novamente!";
      }

      Mensagens().mensagem(retorno, true, context);
    }

    return user;
  }

  static Future<User?> criarConta({
    required BuildContext context, required String email, required String senha,
    required String usuario}) 
    async{

      final firebaseAuth = FirebaseAuth.instance;
      final db = FirebaseFirestore.instance;
      User? user;

      try {

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha); // cadastrando usuário

      userCredential.user!.updateDisplayName(usuario);

      db.collection("Usuários").doc(userCredential.user!.uid).set({ // adicionando informações do usuário no banco de dados
        "Usuário": usuario,
        "Lucro": 0.0,
        "A Receber": 0.0,
        "Vendido": 0.0,
        "Quantidade de Vendas": 0,
        "Valores Deletados": 0.0
      });

      user = userCredential.user;

    } on FirebaseAuthException catch (e) {
      String retorno = "Falha na autenticação!";

      if(e.code == 'weak-password'){
        retorno = "Senha não aceita, crie uma mais forte!";

      }else if(e.code == 'email-already-in-use'){
        retorno = "Este e-mail já está cadastrado!";

      }

      Mensagens().mensagem(retorno, true, context);
    } 

    return user;
  }

  static void signOut({required BuildContext context}) async{
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();
    final facebookAuth = FacebookAuth.instance;

    await googleSignIn.signOut();
    await facebookAuth.logOut();
    await firebaseAuth.signOut();
  }
}