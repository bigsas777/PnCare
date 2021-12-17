import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pncare_app/registrazione.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // Firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    // Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
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
        emailController.text = value;
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
      controller: passwordController,
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
        passwordController.text = value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    // Log In button
    final loginButton = Container(
      height: 50.0,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        color: Color(0xffE3131E),
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        child: Container(
          constraints:
          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 19,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    // Tasto di login alternativo
    final loginButton2 = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 19,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
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
                    emailField,
                    SizedBox(height: 20,),
                    passwordField,
                    SizedBox(height: 35,),
                    loginButton,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Non hai un account?   ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registrazione()
                                )
                            );
                          },
                          child: Text(
                              'Registrati',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE3131E),
                                fontSize: 17
                              ),
                          ),
                        )
                      ],
                    )
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

  // Funzione di login
  void signIn(String email, String password) async {
    if (_formKey.currentState.validate())
      {
        await _auth.signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
              Fluttertoast.showToast(msg: "Login effettuato con successo"),
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()))
        }).catchError((e) {
          Fluttertoast.showToast(msg: "Errore nel login. Riprova\n" + e.message);
        });
      }
  }

}
