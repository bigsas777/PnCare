import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class GestioneUtenti {
  static void storeNuovoUtente(user, context) {
    FirebaseFirestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
    }).catchError((e) {
      print(e);
    });
  }
}