import 'package:app_imc/models/dados.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late BannerAd _bannerAd;
  bool _isAdLoad = false;

  double _altura = 0.0;
  double _peso = 0.0;
  
  final _formKey = GlobalKey<FormState>();
  final _alturaForm = TextEditingController();
  final _pesoForm = TextEditingController();

  void initAdBanner() {
    _bannerAd = BannerAd(
      size: AdSize.banner, 
      // adUnitId: BannerAd.testAdUnitId,
      adUnitId: Platform.isAndroid 
      ? 'ca-app-pub-8327657769248601/5078444315'
      : '',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoad = true;
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Erro ao carregar banner CODIGO DE ERRO: ${error.code} | MENSAGEM: ${error.message}');
          ad.dispose();
        }
      ), 
      request: AdRequest(),
    );

    _bannerAd.load();
  }

  @override
  void initState() {
    initAdBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _isAdLoad 
        ? Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ) 
        : const SizedBox(),
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
                RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  text: 'O ',
                  style: TextStyle(color: Colors.black, fontSize: 16),
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
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: _pesoForm,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Peso em Kg (Ex: 67.8)" 
                          ),
                          validator: (value) {
                            if(value!.contains(',')) {
                              return 'Utilize ponto ao invés de vígula';
                            } else if (value == null || value == '0') {
                              return 'Insira um valor valido';
                            } else if (value.isEmpty) {
                              return 'Preencha este campo';
                            }
              
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        child: TextFormField(
                          controller: _alturaForm,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Altura em metros (Ex: 1.67)" 
                          ),
                          validator: (value) {
                            if(value!.contains(',')) {
                              return 'Utilize ponto ao invés de vígula';
                            } else if (value == null || value == '0') {
                              return 'Insira um valor valido';
                            } else if (value.isEmpty) {
                              return 'Preencha este campo';
                            }
                    
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: const EdgeInsets.only(left: 70, right: 70, top: 20, bottom: 20),
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            _altura = double.parse(_alturaForm.text);
                            _peso = double.parse(_pesoForm.text);
                            Navigator.pushNamed(context, '/resultImc', arguments: Dados(_peso, _altura));
                            _pesoForm.clear();
                            _alturaForm.clear();
                          }
                        }, 
                        child: const Text(
                          "Calcular o IMC",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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