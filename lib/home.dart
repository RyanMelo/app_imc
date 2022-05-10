import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _altura = 0;
  double _peso = 0;
  double _imc = 0;
  String _msgImc = "";

  void calculaImc() {
    setState(() {
      _imc = _peso / (_altura * _altura);
      _imc = double.parse(_imc.toStringAsPrecision(2));

      if(_imc < 18.5) {
        _msgImc = "Abaixo do peso";
      } else if(_imc >= 18.5 && _imc <= 24.9) {
        _msgImc = "Normal";
      } else if(_imc >= 25 && _imc <= 29.9) {
        _msgImc = "Sobrepeso, obesidade grau I";
      } else if(_imc >= 30 && _imc <= 39.9) {
        _msgImc = "Obeso, obesidade grau II";
      } else if(_imc >= 40) {
        _msgImc = "Obesidade grave, obesidade grau III";
      } 

    });
  }

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
                      text: ") é uma medida internacional usada para calcular se uma pessoa está no peso ideal. ",
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
                onPressed: calculaImc, 
                child: const Text(
                  "Calcular o IMC",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: _imc == 0 ? 0 : 300,
                height: _imc == 0 ? 0 : 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    text: _imc != 0 ? "$_imc\n" : "",
                    children: [
                      TextSpan(
                        text: _msgImc,
                        style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                    ),
                      ),
                    ]
                  )
                ),
              ),
            ],
          )
        )
      )
    );
  }
}