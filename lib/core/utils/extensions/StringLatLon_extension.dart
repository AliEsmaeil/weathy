import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import'dart:async';

extension FromStringToLatLon on String{

  // it returns LatLon or Future<LatLon>
  
  Future<LatLng> get latlonRepresentation async{
    if(!contains(',')) {

      List<Location> locations = await locationFromAddress(this);
      return LatLng(locations[0].latitude, locations[0].longitude);
    }

    List<String> list = split(',');
    return LatLng(double.parse(list[0].trim()), double.parse(list[1].trim()));

  }
}