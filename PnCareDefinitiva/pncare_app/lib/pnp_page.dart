import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PnPPage extends StatefulWidget {
  @override
  _PnPPage createState() => _PnPPage();
}

class _PnPPage extends State<PnPPage> {
  String titolo = '', descrizione = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 10, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text('PnSegnalazioni',
                  style: TextStyle(
                      fontFamily: 'Cocogoose Pro',
                      fontSize: 35,
                      color: Color(0xffE3131E))),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                // Titolo problema
                TextField(
                  onChanged: (titoloProb) {
                    titolo = titoloProb;
                  },
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      labelText: "Titolo segnalazione",
                      labelStyle: TextStyle(color: Color(0xffE3131E))),
                ),
                // Descrizione problema
                TextField(
                  onChanged: (descrProb) {
                    descrizione = descrProb;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      labelText: "Descrizione segnalazione",
                      labelStyle: TextStyle(color: Color(0xffE3131E))),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: RaisedButton(
              color: Color(0xffE3131E),
              textColor: Colors.white,
              child: Text('Invia segnalazione'),
              onPressed: () {
                inviaSegnalazione();
              },
            ),
          )
        ],
      ),
    );
  }

  void inviaSegnalazione() async {
    if (titolo.trim().isEmpty || descrizione.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Dati inseriti non validi!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff174c4f),
        duration: Duration(seconds: 2),
      ));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Segnalazione inviata con successo!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color(0xff174c4f),
      duration: Duration(seconds: 2),
    ));

    await salvaSegnalazione();

    setState(() {
      titolo = '';
      descrizione = '';
    });
  }

  Future<void> salvaSegnalazione() async {
    final nuovaSegnalazione = ParseObject('Segnalazioni')
      ..set('Titolo', titolo)
      ..set('Descrizione', descrizione)
      ..set('Risolta', false);
    await nuovaSegnalazione.save();
  }
}
