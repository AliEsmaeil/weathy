import 'package:geolocator/geolocator.dart';

class GeoLocatorStreamer{

  static Future<LocationStatus> _determinePrivileges() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();


    if(serviceEnabled && (permission == LocationPermission.denied)){
      print('LocationEnabledPermissionDenied');

      return LocationStatus.locationEnabledPermissionDenied;
    }

    else if(serviceEnabled && (permission == LocationPermission.deniedForever)){
      print('LocationEnabledPermissionDeniedForever');
      return LocationStatus.locationEnabledPermissionDeniedForever;

    }

    else if(serviceEnabled && (permission == LocationPermission.whileInUse || permission == LocationPermission.always)){
     // it's the only valid state to get the location
      print('LocationEnabledPermissionGranted');
      return LocationStatus.locationEnabledPermissionGranted;
    }

    else if(!serviceEnabled && (permission == LocationPermission.denied)){
      print('LocationDisabledPermissionDenied');
      return LocationStatus.locationDisabledPermissionDenied;
    }

    else if(!serviceEnabled && (permission == LocationPermission.deniedForever)){
      print('LocationDisabledPermissionDeniedForever');
      return LocationStatus.locationDisabledPermissionDeniedForever;
    }

    else{
      print('LocationDisabledPermissionGranted');
      return LocationStatus.locationDisabledPermissionGranted;
    }

  }

  static Future<String?> getPosition()async{

    LocationStatus locationStatus = await _determinePrivileges();

    switch(locationStatus){
      case LocationStatus.locationEnabledPermissionGranted:
      {
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        return '${position.latitude},${position.longitude}';
      }
      case LocationStatus.locationEnabledPermissionDenied:
      {
        Geolocator.requestPermission().then((value) async{
          if(value == LocationPermission.always || value == LocationPermission.whileInUse){
            await getPosition();
          }

          else if (value == LocationPermission.denied || value == LocationPermission.deniedForever){
            await Geolocator.requestPermission().then((v)async{
              if(v == LocationPermission.always || v == LocationPermission.whileInUse){
                await getPosition();
              }
              else if(v == LocationPermission.denied || v == LocationPermission.deniedForever){
                await Geolocator.openAppSettings();
              }
            });
          }
        });
      }
      break;
      case LocationStatus.locationEnabledPermissionDeniedForever || LocationStatus.locationDisabledPermissionDeniedForever:
      {
         await Geolocator.openAppSettings();

      }
      break;
      case LocationStatus.locationDisabledPermissionDenied || LocationStatus.locationDisabledPermissionGranted:
      {
        await Geolocator.openLocationSettings();
      }

    }
    return null;
  }

}

enum LocationStatus{

  // if location detection service is disabled
  // (you are supposed to direct user to enable it then keep track permission until being granted)

  locationDisabledPermissionDenied,
  locationDisabledPermissionDeniedForever,
  locationDisabledPermissionGranted,

  // best scenario, if occurred get location
  locationEnabledPermissionGranted,

  // if permission is not granted, direct the user to gain it
  // if denied ---> request permission again
  //id denied for ever, requesting it again will not help, so direct him to app permissions settings
  locationEnabledPermissionDenied,
  locationEnabledPermissionDeniedForever,

}