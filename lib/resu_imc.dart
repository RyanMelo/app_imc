import 'package:flutter/material.dart';
import 'models/dados.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class ResultImc extends StatefulWidget {
  const ResultImc({ Key? key }) : super(key: key);

  @override
  State<ResultImc> createState() => _ResultImcState();
}

class _ResultImcState extends State<ResultImc> {

  late BannerAd _bannerAd;
  bool _isAdLoad = false;

   void initAdBanner() {
    _bannerAd = BannerAd(
      size: AdSize.banner, 
      // adUnitId: BannerAd.testAdUnitId,
      adUnitId: Platform.isAndroid 
      ? 'ca-app-pub-8327657769248601/6955165597'
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

    final dados = ModalRoute.of(context)!.settings.arguments as Dados;

    double _imc = 0;
    String _msgImc = "";

    void calculaImc() {
      setState(() {
        _imc = dados.peso / (dados.altura * dados.altura);
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

    calculaImc();

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
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: _imc == 0 ? 0 : 300,
                height: _imc == 0 ? 0 : 120,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
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
              const Expanded(
                child: Image(
                  image: AssetImage('assets/imgs/tabela_imc.png'),
                  width: 300,
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}