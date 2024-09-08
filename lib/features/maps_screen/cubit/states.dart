import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class MapsScreenStates{

  MapsScreenStates();
}

final class MapsScreenInitialState extends MapsScreenStates{
  LatLng position;
  MapsScreenInitialState({required this.position});
}

final class MapsScreenAddedMarkerState extends MapsScreenStates{
  LatLng position;
  MapsScreenAddedMarkerState({required this.position});
}

final class MapsScreenMarkerDraggedState extends MapsScreenStates{
  LatLng position;
  MapsScreenMarkerDraggedState({required this.position});
}
final class MapsScreenFinalLocationState extends MapsScreenStates{
  LatLng position;
  MapsScreenFinalLocationState({required this.position});
}

