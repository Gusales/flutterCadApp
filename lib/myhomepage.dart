// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var userTFF = TextEditingController();
var emailTFF = TextEditingController();
var telTFF = TextEditingController();
var cepTFF = TextEditingController();
var txtU = TextEditingController();
var txtE = TextEditingController();
var txtT = TextEditingController();

var txtC = TextEditingController();
var txtB = TextEditingController();
var txtCi = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  void async;
  void getCEP() {
    setState(() async {
      var url = Uri.https(
          'viacep.com.br', 'ws/${cepTFF.text}/json/', {'q': '{http}'});
      var response = await http.get(url);

      print('Status Code response: ${response.statusCode}');

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        var cep = jsonResponse['localidade'];
        var log = jsonResponse['logradouro'];
        var comp = jsonResponse['bairro'];
        var city = jsonResponse['uf'];
        // ignore: prefer_interpolation_to_compose_strings
        print(
            // ignore: prefer_interpolation_to_compose_strings
            '${'MEU CEP: ' + cepTFF.text + ' E meu endereço é: ' + cep}-' +
                city);
        var endereco = cep + '-' + city;
        print('Rua ${log}, Bairro ${comp}, ${cep}-${city}');

        txtU.text = userTFF.text;
        txtE.text = emailTFF.text;
        txtT.text = telTFF.text;
        txtC.text = log;
        txtB.text = 'Bairro: ${comp}';
        txtCi.text = endereco;

        userTFF.text = "";
        emailTFF.text = "";
        telTFF.text = "";
        cepTFF.text = "";
      } else {
        print(
            'Não é possivel fazer a requisição para o servidor! Error:${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          SizedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 50, top: 50),
              width: 300,
              child: TextField(
                controller: userTFF,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insira um nome de usuário',
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 50, top: 5),
              width: 300,
              child: TextField(
                controller: emailTFF,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insira um email',
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 50, top: 5),
              width: 300,
              child: TextField(
                controller: telTFF,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insira um número de Telefone',
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: const EdgeInsets.only(left: 50, top: 5),
              width: 300,
              child: TextField(
                controller: cepTFF,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insira um CEP',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCEP,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
