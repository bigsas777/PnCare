import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:google_fonts/google_fonts.dart';

class PensieriPage extends StatefulWidget {
  @override
  _PensieriPage createState() => _PensieriPage();
}

class _PensieriPage extends State<PensieriPage> {
  String titolo = '', descrizione = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              color: Color(0xffE3131E),
              child: Row(
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Indietro',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: <Widget>[
                // Titolo problema
                TextField(
                  onChanged: (titoloPensiero) {
                    titolo = titoloPensiero;
                  },
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      labelText: "Titolo pensiero",
                      labelStyle: GoogleFonts.poppins(
                          color: Color(0xffE3131E),
                          fontSize: 20
                      )),
                ),
                // Descrizione problema
                TextField(
                  onChanged: (descrPensiero) {
                    descrizione = descrPensiero;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      labelText: "Descrivi il tuo pensiero",
                      labelStyle: GoogleFonts.poppins(
                          color: Color(0xffE3131E),
                          fontSize: 20
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              height: 50.0,
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffE3131E), Color(0xffE3131E)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                    BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Invia pensiero",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
