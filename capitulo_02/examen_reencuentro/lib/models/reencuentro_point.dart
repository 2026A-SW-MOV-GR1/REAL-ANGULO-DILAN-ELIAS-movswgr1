import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReencuentroPoint {
  final String id;
  final String title;
  final String snippet;
  final LatLng position;
  final BitmapDescriptor icon;

  ReencuentroPoint({
    required this.id,
    required this.title,
    required this.snippet,
    required this.position,
    this.icon = BitmapDescriptor.defaultMarker,
  });
}
