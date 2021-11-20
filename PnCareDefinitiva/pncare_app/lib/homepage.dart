import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pncare_app/class_notizia.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var meteoAttuale, temperatura, iconaMeteo, pm2_5, pm10, o3, no2, so2;
  // ll sta per limite di legge per ogni parametro
  // pm sono insiemi di polveri inquinanti, il numero sta per il diametro delle polveri

  final llpm2_5 = 25, // valore espresso in microgrammi per metro cubo
        llpm10 = 50,
        llo3 = 180,
        llno2 = 200,
        llso2 = 350;

  List<Notizia> notizie = [];
  Notizia notizia;

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


  Future _richiestaNotizie() async {
    final data = await http.get(Uri.parse("https://8b73-78-14-16-126.ngrok.io/"));

    var jsonData = json.decode(data.body);

    setState(() {
      for (var u in jsonData) {
        this.notizia = Notizia(u["Indice"], u["Titolo"], u["Descrizone"], u["Data"], u["Immagine"], u["Link"]);
        this.notizie.add(notizia);
      }
    });
  }



  @override
  void initState() {
    super.initState();
    this.richiestaMeteo();
    this._richiestaNotizie();
  }

  // Corpo principale della homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // --- SEZIONE TITOLO ---
            Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 10, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('PnBacheca',
                    style: TextStyle(
                        fontFamily: 'Cocogoose Pro',
                        fontSize: 35,
                        color: Color(0xffE3131E)
                    )
                ),
              ),
            ),

            // --- SEZIONE CONDIZIONI METEO ---
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Align(
                child: Text(
                    "MeteoPn",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE3131E),
                    )
                ),
                alignment: Alignment.centerLeft,
              )
            ),
            Container(
                /* child: Card(
                    margin: EdgeInsets.all(5),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ), */
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                FormatoIconaMeteo(),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                              Text(
                                meteoAttuale != null
                                    ? meteoAttuale.toString()
                                    : '--',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    temperatura != null ? temperatura.toString() + " \u2103" : "--" + " \u2103",
                                    style: GoogleFonts.poppins(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Qualità dell'aria:",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    EsitoQA().toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )
                // )
            ),

            // --- SEZIONE NOTIZIE ---
            Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Align(
                  child: Text(
                      "NotiziePn ",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffE3131E),
                      )
                  ),
                  alignment: Alignment.centerLeft,
                )
            ),
            Column(
              children: notizie.map((notizia){
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  elevation: 10.0,
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      notizia.titolo,
                      style: TextStyle(
                        color: Color(0xff174c4f),
                        fontSize: 21,
                      ),
                    ),
                    subtitle: Text(
                      notizia.data,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    trailing: Image.network(notizia.immagine),
                    onTap: () async {
                      print(notizia.link);
                      await launch(notizia.link, forceWebView: true);
                    },
                  ),
                  margin: EdgeInsets.all(5),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
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
    final todo = ParseObject('Test')
      ..set('message', "sas")
      ..set('data', DateTime.now());
    await todo.save();
  }
}
