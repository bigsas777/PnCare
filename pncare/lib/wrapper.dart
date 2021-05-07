import 'package:flutter/material.dart';
import 'package:pncare/autenticazione/autenticazione.dart';
import 'package:pncare/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // In base a se l'utente è registrato o meno ritorna
    // la home o la schermata di autenticazione
    return Autenticazione();
  }
}
