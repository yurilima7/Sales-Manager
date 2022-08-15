import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Este e-mail já está cadastrado!"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
      else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Conta inválida!"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
        
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
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Este e-mail já está cadastrado!"),
              backgroundColor: Colors.redAccent,
            )
          );
        }
        else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Este e-mail já está cadastrado!"),
              backgroundColor: Colors.redAccent,
            )
          );
        }
        
      }

    return user;
  }
}