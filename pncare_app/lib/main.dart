import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:pncare_app/autenticazione/sign_in.dart';
import 'package:pncare_app/autenticazione/registrazione.dart';
import 'package:pncare_app/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'DzkBAj3BmHsoDJkRzNJ9Mth0oDsAEyT7zbafjvbT';
  final keyClientKey = 'Uav6rUy0xI1w25JOcdU9qZV0yv7O0ZI1P4cFoWYY';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(PnCare());
}

class PnCare extends StatelessWidget {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      /*
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => PnCare(),
        '/registrazione': (BuildContext context) => Register(),
        '/homepage': (BuildContext context) => Home(),
      }, */
    );
  }
}

