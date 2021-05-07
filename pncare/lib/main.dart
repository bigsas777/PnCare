import 'package:flutter/material.dart';
import 'package:pncare/wrapper.dart';

void main() => runApp(PnCare());

class PnCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
