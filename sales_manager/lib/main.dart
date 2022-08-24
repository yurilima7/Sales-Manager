import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sales_manager/screens/estado_usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(SalesManager());
}

class SalesManager extends StatelessWidget {
  SalesManager({Key? key}) : super(key: key);

  final ThemeData tema = ThemeData(); // adicionando o tema da aplicação

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(

        colorScheme: tema.colorScheme.copyWith(
          primary: const Color(0xFF6D3F8C),
          secondary: const Color(0xFFE7DCF2),
        ),
        scaffoldBackgroundColor: const Color(0xFFE7DCF2),
      ),
      initialRoute: '/estadoDoUsuario',
      routes: { 
        '/estadoDoUsuario':(context) => const EstadoUsuario(),
      },
    );
  }
}
