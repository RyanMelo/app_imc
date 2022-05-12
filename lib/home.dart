import 'package:app_imc/models/dados.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _altura = 0;
  double _peso = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
                RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  text: 'O ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: "índice de massa corporal",
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: " (",
                    ),
                    TextSpan(
                      text: "IMC",
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: ") é uma medida internacional usada para calcular se uma pessoa está no peso ideal.",
                    ),
                  ]
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso:',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  )
                ),
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                onChanged: (texto) {
                  try {
                      _peso = double.parse(texto);
                    } catch (e) {
                      _peso = 0;
                    }
                },
              ),
              const SizedBox(height: 30),
             TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura em m:',
                  labelStyle: TextStyle(color: Colors.green),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                onChanged: (texto) {
                  setState(() {
                    try {
                      _altura = double.parse(texto);
                    } catch (e) {
                      _altura = 0;
                    }
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: const EdgeInsets.only(left: 90, right: 90, top: 20, bottom: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/resultImc', arguments: Dados(_peso, _altura));
                }, 
                child: const Text(
                  "Calcular o IMC",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        )
      )
    );
  }
}