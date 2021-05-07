import 'package:flutter/material.dart';
import 'package:pncare/autenticazione/sign_in.dart';

class Autenticazione extends StatefulWidget {
  @override
  _AutenticazioneState createState() => _AutenticazioneState();
}

class _AutenticazioneState extends State<Autenticazione> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}
