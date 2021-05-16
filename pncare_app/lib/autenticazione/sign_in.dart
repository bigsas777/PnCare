import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Variabili
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5E9BE),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Image.asset('assets/immagini/logo_trasparente_main.png'),
              // Campo email
              TextFormField(
                autocorrect: false,
                onChanged: (val) {
                  setState(() => email = val);
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.email_outlined),
                  labelText: 'Email',
                ),
                validator: (email) {
                  return (email == null && !email.contains('@'))
                      ? 'Email non valida'
                      : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              // Campo password
              TextFormField(
                autocorrect: false,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                color: Color(0xffE3131E),
                child: Text(
                  'LOG IN',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  /*
                  print('Email: ' + email);
                  print('Password: ' + password);
                  */
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
                      .then((user) => {
                        Navigator.of(context).pushReplacementNamed('/homepage')
                  })
                      .catchError((e) {
                        print(e);
                  });
                },
              ),
              TextButton(onPressed: () {
                Navigator.of(context).pushNamed('/registrazione');
              },
                  child: Text('Non hai un account?\nRegistrati qui!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xffE3131E))
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
