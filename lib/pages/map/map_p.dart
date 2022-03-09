import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../home/models/model.dart';

class MapP extends StatefulWidget {
  final List<User> usersMap;
  const MapP({Key? key, required this.usersMap}) : super(key: key);

  @override
  _MapPState createState() => _MapPState();
}

class _MapPState extends State<MapP> {
  Set<Marker> _markers = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      loadMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(49.984287323197506, 36.24593931982295),
      ),
      mapType: MapType.hybrid,
      markers: _markers,
    );
  }

  Future<void> loadMarkers() async {
    widget.usersMap.forEach((element) {
      _markers.add(Marker(
        markerId: MarkerId(element.name),
        position: LatLng(element.latitude, element.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
    });
  }
}
