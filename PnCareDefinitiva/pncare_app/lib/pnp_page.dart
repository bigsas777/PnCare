import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pncare_app/segnalazioni_page.dart';
import 'package:pncare_app/pensieri_page.dart';

class PnPPage extends StatefulWidget {
  @override
  _PnPPage createState() => _PnPPage();
}

class _PnPPage extends State<PnPPage> {
  String testo = "In questa sezione dell'app potrai segnalare, al "
      "comune di Pordenone, problemi riscontrati sul territorio"
      " oppure inviare i tuoi pensieri o consigli riguardo l'operato del comune.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 10, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                  'PnRiscontri',
                  style: GoogleFonts.poppins(
                      fontSize: 35,
                      color: Color(0xffE3131E),
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              testo,
              style: GoogleFonts.poppins(
                color: Color(0xff174c4f),
                fontSize: 19,
                fontWeight: FontWeight.w600,

              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 50.0,
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                color: Color(0xffE3131E),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SegnalazioniPage()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                // Questo pezzo di codice permette di colorare il bottone con un gradiente
                /* child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffE3131E), Color(0xffE3131E)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)), */
                child: Container(
                  constraints:
                  BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Invia segnalazione",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  ),
                ), /*
                ), */
              ),
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              color: Color(0xffE3131E),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PensieriPage()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              /* child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffE3131E), Color(0xffE3131E)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)), */
              child: Container(
                constraints:
                BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "Invia pensiero",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
