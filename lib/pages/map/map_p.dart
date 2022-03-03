import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapP extends StatefulWidget {
  const MapP({Key? key}) : super(key: key);

  @override
  _MapPState createState() => _MapPState();
}

class _MapPState extends State<MapP> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(0, 0)));
  }
}
