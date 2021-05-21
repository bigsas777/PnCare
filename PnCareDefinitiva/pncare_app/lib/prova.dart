import 'dart:async';
import 'dart:html';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PnP',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PnP')),
      body: Center(
        child: RaisedButton(
          child: Text(
            'Inserisci una segnalazione',
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Segnalazione()),);
          },
        ),
        /*child: RaisedButton(
            child: Text(
              'Scrivi un feedback',
              style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Feedback()),);
          },*/
      ),
    );
  }
}

class Segnalazione extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuova segnalazione')),

      body: Center(
        child: ElevatedButton(
            child: Text(
              'Invia segnalazione',
              style: TextStyle(fontSize: 12.0),
            ),
            onPressed: () {}
        ),

      ),
    );
  }
}

class Feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuovo feedback')),

      body: Center(
        child: ElevatedButton(
            child: Text(
              'Pagina feedback',
              style: TextStyle(fontSize: 24.0),
            ),
            onPressed: () {}
        ),
      ),
    );
  }
}