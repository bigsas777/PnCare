import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var meteoAttuale, temperatura, iconaMeteo, pm2_5, pm10, o3, no2, so2;
  // ll sta per limite di legge per ogni parametro
  // pm sono insiemi di polveri inquinanti, il numero sta per il diametro delle polveri
  final llpm2_5 = 25, // microgrammi per metro cubo
      llpm10 = 50,
      llo3 = 180,
      llno2 = 200,
      llso2 = 350;
  
  Future richiestaMeteo() async {
    final response = await http.get(Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=3cd479d446704f4ba47143505210205&q=Pordenone&aqi=yes&lang=it"));
    var result = jsonDecode(response.body);

    setState(() {
      // Meteo
      this.temperatura = result['current']['temp_c'];
      this.meteoAttuale = result['current']['condition']['text'];
      this.iconaMeteo = result['current']['condition']['icon'];

      // Qualità dell'aria
      this.pm2_5 = result['current']['air_quality']['pm2_5'];
      this.pm10 = result['current']['air_quality']['pm10'];
      this.no2 = result['current']['air_quality']['no2'];
      this.o3 = result['current']['air_quality']['o3'];
      this.so2 = result['current']['air_quality']['so2'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.richiestaMeteo();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 25, 10, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('PnBacheca',
                        style: TextStyle(
                            fontFamily: 'Cocogoose Pro',
                            // fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xffE3131E))),
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Color(0xff5e5e5e),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 5,
                      // color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Image(
                              image: NetworkImage(FormatoIconaMeteo()),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              meteoAttuale != null
                                  ? meteoAttuale.toString()
                                  : '--',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 5,
                        // color: Colors.amber,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              Align(
                                child: Text(
                                  temperatura != null
                                      ? temperatura.toString() + " \u2103"
                                      : "--" + "\u2103",
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                                alignment: Alignment.topCenter,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Align(
                                  child: Text(
                                    "Qualità dell'aria:",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Align(
                                  child: Text(
                                    EsitoQA().toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
                Divider(
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Color(0xff5e5e5e),
                ),
                /*
                TextButton(onPressed: () {
                  testData();
                },
                  child: Text('Cliccami!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xffE3131E))
                  ),
                ) */
              ],
            ))
          ];
        },
        body: Container());
  }

  String FormatoIconaMeteo() {
    String urlFinale;
    urlFinale = 'https:' + iconaMeteo.toString();

    return urlFinale;
  }

  double calcoloIQA(var parametro, final llParametro) {
    return (parametro / llParametro) * 100;
  }

  double QualitaAria() {
    var IQApm2_5 = calcoloIQA(pm2_5, llpm2_5);
    var IQApm10 = calcoloIQA(pm10, llpm10);
    var IQAo3 = calcoloIQA(o3, llo3);
    var IQAno2 = calcoloIQA(no2, llno2);
    var IQAso2 = calcoloIQA(so2, llso2);

    var listaIQA = new List(5);
    listaIQA[0] = IQApm2_5;
    listaIQA[1] = IQApm10;
    listaIQA[2] = IQAo3;
    listaIQA[3] = IQAno2;
    listaIQA[4] = IQAso2;

    listaIQA.sort();

    return listaIQA[4];
  }

  String EsitoQA() {
    var IQA = QualitaAria();

    if (IQA < 30) {
      return 'Ottima';
    } else if (IQA >= 34 && IQA <= 66) {
      return 'Buona';
    } else if (IQA >= 67 && IQA <= 99) {
      return 'Discreta';
    } else if (IQA >= 99 && IQA <= 150) {
      return 'Scadente';
    } else if (IQA > 150) {
      return 'Pessima';
    }
  }

  void testData() async {
    await testDatabase();
  }

  Future<void> testDatabase() async {
    final todo = ParseObject('Test')..set('message', "sas")..set('data', DateTime.now());
    await todo.save();
  }
}
