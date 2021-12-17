import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:google_fonts/google_fonts.dart';

class SegnalazioniPage extends StatefulWidget {
  @override
  _SegnalazioniPage createState() => _SegnalazioniPage();
}

// TODO: Image picker e salvataggio immagini nel database
// https://educity.app/flutter/how-to-pick-an-image-from-gallery-and-display-it-in-flutter --> ImagePicker

class _SegnalazioniPage extends State<SegnalazioniPage> {
  String titolo = '', descrizione = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE3131E),
        elevation: 0.0,
        title: Text(
          'Indietro',
          style: GoogleFonts.poppins(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      labelText: "Titolo segnalazione*",
                      labelStyle: GoogleFonts.poppins(
                          color: Color(0xffE3131E),
                          fontSize: 20
                      )),
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
                      labelText: "Descrizione segnalazione*",
                      labelStyle: GoogleFonts.poppins(
                          color: Color(0xffE3131E),
                          fontSize: 20
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 25),
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Color(0xffE3131E),
                    ),
                    label: Text(
                      'Inserisci una fotografia',
                      style: GoogleFonts.poppins(
                        color: Color(0xffE3131E),
                      ),
                    ),
                    onPressed: () {
                      selezioneImg();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: Color(0xffE3131E))
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                inviaSegnalazione();
              },
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
                    "Invia segnalazione",
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
          Text(
            'Campi obbligatori*',
            style: GoogleFonts.poppins(
              color: Color(0xffE3131E),
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }

  selezioneImg() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Seleziona immagine da:'),
            content: SingleChildScrollView(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: Color(0xffE3131E),
                          ),
                          iconSize: 60,
                        ),
                        Text(
                            'Fotocamera',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            )
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.image_outlined,
                          color: Color(0xffE3131E),
                        ),
                        iconSize: 60,
                      ),
                      Text(
                        'Galleria',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'ANNULLA',
                  style: GoogleFonts.poppins(
                    color: Color(0xffE3131E)
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Color(0x8AD28588)),
                ),
              ),
            ],
          );
        }
    );
  }

  imgDaGalleria() async {
    XFile fileScelto = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (fileScelto != null) {
      File immagine = File(fileScelto.path);
    }
  }

  void inviaSegnalazione() async {
    if (titolo.trim().isEmpty || descrizione.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Dati inseriti non validi!",
          style: GoogleFonts.poppins(
              color: Colors.white
          ),
        ),
        backgroundColor: Color(0xff174c4f),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    else // Una volta tutto quello che era dentro al blocco
        {  // else era fuori e senza else quindi se in futuro non andrà sappiamo perchè
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Segnalazione inviata con successo!",
            style: GoogleFonts.poppins(
                color: Colors.white
            )
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
  }

  Future<void> salvaSegnalazione() async {
    final nuovaSegnalazione = ParseObject('Segnalazioni')
      ..set('Titolo', titolo)
      ..set('Descrizione', descrizione)
      ..set('Risolta', false);
    await nuovaSegnalazione.save();
  }
}
