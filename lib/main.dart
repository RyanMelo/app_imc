import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'resu_imc.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/resultImc': (context) => const ResultImc(),
      },
    );
  }
}