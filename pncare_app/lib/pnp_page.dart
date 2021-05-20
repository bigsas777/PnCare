import 'package:pncare_app/pnp_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:image_picker/image_picker.dart';

class PnPPage extends StatefulWidget {
  @override
  _PnPPage createState() => _PnPPage();
}

class _PnPPage extends State<PnPPage> {
  String titolo = '', descrizione = '';
  bool valoreSwitch;
  @override
  Widget build(BuildContext context) => ListView
    (
    padding: EdgeInsets.all(32),
    children:
    [
      buildBackgroundCard(),
    ],
  );

  // si deve includere:
  // import 'package:image_picker/image_picker.dart';
  /*
  Future<File> imageFile () async
  _openGallery(BuildContext context)
  {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(()
      {
        imageFile = picture;
      });
      Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async
  {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(()
      {
        imageFile = picture;
      });
  }
   */

  Future <void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog
        (
          title: Text("Seleziona:"),
          content: SingleChildScrollView
            (
              child: ListBody
                (
                  children: <Widget>
                  [
                    GestureDetector
                      (
                      child: Text("Gallery"),
                      onTap: ()
                      {
                        //  _openGallery(context);

                      },
                    ),

                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector
                      (
                      child: Text("Camera"),
                      onTap: ()
                      {
                        //  _openCamera(context);

                      },
                    ),

                  ]
              )
          )
      );
    });
  }

  Widget buildBackgroundCard()
  {
    return Scaffold
      (
        body: Padding
          (
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView
              (
                children:<Widget>
                [
                  buttonSwitch(),
                  SizedBox(
                    height:20,
                  ),

                  titoloText(),
                  SizedBox(
                    height:20,
                  ),
                  descrizioneText(),
                  SizedBox(
                    height:20,
                  ),
                  RaisedButton(
                    color: Color(0xffE3131E),
                    textColor: Colors.white,
                    child: Text('Invia segnalazione'),
                    onPressed: () {
                      inviaSegnalazione();
                    },
                  ),
                  immagineAggiunta(),
                ]
            )
        )
    );
  }


  Widget buttonSwitch()
  {
    return Switch
      (
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
        value: false, onChanged: (value)
    {
      setState()
      {
        if(value == true)
        {
          //Feedback();
        }
      }
    }
    );
  }

  Widget titoloText()
  {
    return TextField
      (
      //crossAxisAlignment: CrossAxisAlignment.start,
      decoration: InputDecoration
        (
        border: OutlineInputBorder
          (
            borderSide: BorderSide(color: Color(0xffe3131e),)
        ),
        focusedBorder: OutlineInputBorder
          (
            borderSide: BorderSide(color: Color(0xffe3131e), width: 2,)
        ),
        //prefixIcon: Icon(Icons.announcement_rounded, color: Color(0xffe3131e))
        helperText: "Il campo non puo' essere lasciato vuoto",
        labelText: "Titolo...",
        labelStyle: TextStyle(color: Color(0xffe3131e)),
        //border: InputBorder.none,
      ),
    );
  }
  Widget descrizioneText()
  {
    return TextField
      (
      //crossAxisAlignment: CrossAxisAlignment.start,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration
        (
        border: OutlineInputBorder
          (
            borderSide: BorderSide(color: Color(0xffe3131e),)
        ),
        focusedBorder: OutlineInputBorder
          (
            borderSide: BorderSide(color: Color(0xffe3131e), width: 2,)
        ),
        prefixIcon: Icon(Icons.article_outlined, color: Color(0xffe3131e)),
        helperText: "Il campo non puo' essere lasciato vuoto",
        labelText: 'Descrizione...',
        labelStyle: TextStyle(color: Color(0xffe3131e)),
        //border: InputBorder.none,
      ),
    );
  }

// pubspec.yaml -> dependencies -> add -> image_picker: ^0.6.7+4
  Widget immagineAggiunta()
  {
    return Stack
      (
        children: <Widget>
        [
          RaisedButton(onPressed: ()
          {
            _showChoiceDialog(context);
          }
          ),
        ]
    );
  }

  void inviaSegnalazione() async {
    if (titolo.trim().isEmpty || descrizione.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Dati inseriti non validi", style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff174c4f),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await salvaSegnalazione();
    setState(() {
      titolo = '';
      descrizione = '';
    });
  }

  Future<void> salvaSegnalazione() async {
    final nuovaSegnalazione = ParseObject('Segnalazioni')..set('Titolo', titolo)..set('Descrizione', descrizione)..set('Risolta', false);
    await nuovaSegnalazione.save();
  }

  void sceltaSchermata (bool valore) {
    if (valore == false) {

    }
    else if (valore == true) {

    }
  }
}