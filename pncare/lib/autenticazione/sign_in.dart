import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF5E9BE),
      child: Column(
        children: <Widget>[
          Image.asset('assets/immagini/logo_trasparente.png'),
          // Aggiungere TextField
          RaisedButton(
            child: Text('Sign In'),
            onPressed: () async => {},
          )
        ],
      ),
    );
  }
}
