import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PnAccessibile extends StatefulWidget {
  @override
  _PnAccessibileState createState() => _PnAccessibileState();
}

class _PnAccessibileState extends State<PnAccessibile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(45.96238674087282, 12.656807793104441),
            zoom: 14.5,
        ),
        zoomControlsEnabled: false,
      ),
    );
  }
}
