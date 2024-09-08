import 'package:google_maps_flutter/google_maps_flutter.dart';

extension FromLatLonToString on LatLng{
  String get stringRepresentation{
    return '$latitude,$longitude';
  }
}