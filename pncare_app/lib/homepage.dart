import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pncare_app/riciclo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:linkable/linkable.dart';

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
                InkWell(
                  child: Text('Visita il nostro sito!'),
                  onTap: () => launch(''),
                ),
                InkWell(
                  child: Text('Visita la nostra pagina Instagram!'),
                  onTap: () => launch('https://www.instagram.com/pncareofficial/'),
                ),
                InkWell(
                  child: Text('Visita la nostra pagina Facebook!'),
                  onTap: () => launch('https://www.facebook.com/PnCare-106426984956480'),
                ),
                InkWell(
                  child: Text('Visita il nostro canale YouTube!'),
                  onTap: () => launch('https://www.youtube.com/channel/UC0GJT-tDh69q8dxVuRyPktw'),
                ),
                */
                /*
                Center(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Visita la nostra pagina Instagram!',
                            recognizer: TapGestureRecognizer()..onTap = () {launch('https://www.instagram.com/pncareofficial/');},
                          ),
                          TextSpan(
                            text: 'Visita la nostra pagina Facebook!',
                            recognizer: TapGestureRecognizer()..onTap = () {launch('https://www.facebook.com/PnCare-106426984956480');},
                          ),
                          TextSpan(
                            text: 'Visita il nostro canale YouTube!',
                            recognizer: TapGestureRecognizer()..onTap = () {launch('https://www.youtube.com/channel/UC0GJT-tDh69q8dxVuRyPktw');},
                          ),
                        ]
                    ),
                  ),
                ) */
                /*
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xffE3131E),
                                ),
                              ),
                              Text(
                                ' ',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Image.asset('immagini/notiziaPn.jpeg'),
                        ],
                      ),
                    ),
                  ),
                )
                */
                /*
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              style: TextStyle(
                                color: Color(0xffE3131E),
                                fontSize: 15,
                              ),
                              text: "Visita la nostra pagina Facebook!\n",
                              recognizer: TapGestureRecognizer()..onTap =  () async{
                                var url = "https://www.facebook.com/PnCare-106426984956480";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                          ),
                          TextSpan(
                              style: TextStyle(
                                color: Color(0xffE3131E),
                                fontSize: 15,
                              ),
                              text: "Visita la nostra pagina Instagram!\n",
                              recognizer: TapGestureRecognizer()..onTap =  () async{
                                var url = "https://www.instagram.com/pncareofficial/";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                          ),
                          TextSpan(
                              style: TextStyle(
                                color: Color(0xffE3131E),
                                fontSize: 15,
                              ),
                              text: "Visita il nostro canale YouTube!",
                              recognizer: TapGestureRecognizer()..onTap =  () async{
                                var url = "https://www.youtube.com/channel/UC0GJT-tDh69q8dxVuRyPktw";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                          ),
                        ]
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.red
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: IconButton(
                      icon: ImageIcon(
                        AssetImage('assets/icons/iconaTastoIG.png')
                      ),
                    )
                  ),
                  onPressed: () {},
                )
                */
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
    } else if (IQA >= 31 && IQA <= 66) {
      return 'Buona';
    } else if (IQA >= 67 && IQA <= 99) {
      return 'Discreta';
    } else if (IQA >= 100 && IQA <= 150) {
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
