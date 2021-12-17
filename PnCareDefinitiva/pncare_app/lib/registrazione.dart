import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pncare_app/models/user_model.dart';

import 'home.dart';

class Registrazione extends StatefulWidget {
  const Registrazione({key}) : super(key: key);

  @override
  _RegistrazioneState createState() => _RegistrazioneState();
}

class _RegistrazioneState extends State<Registrazione> {

  final _auth = FirebaseAuth.instance;

  // Our form key
  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final nomeEditingController = new TextEditingController();
  final cognomeEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confermaPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    // Nome field
    final nomeField = TextFormField(
      autofocus: false,
      controller: nomeEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');

        if (value.isEmpty)
        {
          return ("Inserisci il tuo nome");
        }

        if (!regex.hasMatch(value))
        {
          return ("Inserire un nome valido(min. 3 caratteri)");
        }

        return null;
      },
      onSaved: (value) {
        nomeEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // Cognome field
    final cognomeField = TextFormField(
      autofocus: false,
      controller: cognomeEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value.isEmpty)
        {
          return ("Inserisci il tuo nome");
        }

        return null;
      },
      onSaved: (value) {
        cognomeEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Cognome",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]');

        if (value.isEmpty)
        {
          return ('Inserisci la tua email');
        }
        // Reg expression per la validità dell'email
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
        {
          return ("Inserire un indirizzo email valido");
        }

        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');

        if (value.isEmpty)
        {
          return ("Inserisci la tua password");
        }

        if (!regex.hasMatch(value))
        {
          return ("Inserire una password valida(min. 6 caratteri)");
        }

        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // Conferma password field
    final confermaPasswordField = TextFormField(
      autofocus: false,
      controller: confermaPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confermaPasswordEditingController.text != passwordEditingController.text)
          {
            return "Le password non corrispondono!";
          }

        return null;
      },
      onSaved: (value) {
        confermaPasswordEditingController.text = value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Conferma password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // Tasto registrazione
    final registrazioneButton = Container(
      height: 50.0,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        color: Color(0xffE3131E),
        onPressed: () {
          registrazione(emailEditingController.text, passwordEditingController.text);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Container(
          constraints:
          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            "Registrati",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 19,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xffE3131E),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/immagini/logo_trasparente.png', fit: BoxFit.contain),
                      nomeField,
                      SizedBox(height: 20,),
                      cognomeField,
                      SizedBox(height: 20,),
                      emailField,
                      SizedBox(height: 20,),
                      passwordField,
                      SizedBox(height: 20,),
                      confermaPasswordField,
                      SizedBox(height: 35,),
                      registrazioneButton,
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }

  void registrazione(String email, String password) async {
    if (_formKey.currentState.validate())
    {
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDetailsToFirestore(),
      }).catchError((e) {
        Fluttertoast.showToast(msg: "Errore nella registrazione. Riprova\n" + e.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // Chiamata a Firestore
    // Chiamata allo user model
    // Salvataggio dei valori

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser;

    UserModel userModel = UserModel();

    // Scrittura di tutti i valori
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.nome = nomeEditingController.text;
    userModel.cognome = cognomeEditingController.text;
    
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    
    Fluttertoast.showToast(msg: "Account creato con successo!");
    
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false);
  }

}

