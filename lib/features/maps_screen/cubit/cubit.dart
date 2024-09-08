import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathy/core/utils/extensions/LatLonString_extension.dart';
import 'package:weathy/core/utils/extensions/StringLatLon_extension.dart';
import 'package:weathy/features/maps_screen/cubit/states.dart';
import 'package:weathy/features/weather_screens/presentation/controllers/current_weather_cubit/cubit.dart';
import 'package:weathy/features/weather_screens/presentation/screens/home_screen.dart';


class MapsScreenCubit extends Cubit<MapsScreenStates> {

  String? currentLocation;
  Set<Marker> myMarkers = {};
  var markerIcon;

  MapsScreenCubit() :super(MapsScreenInitialState(position : HomeScreenCubit.latLngLocation!)) {
    addMarker(HomeScreenCubit.latLngLocation!);
  }

  static MapsScreenCubit getCubit(BuildContext context)=> BlocProvider.of(context);

  void addMarker(LatLng position)async{

    currentLocation = '${position.latitude},${position.longitude}';

    markerIcon ??= await getImage();
    myMarkers.clear();
    myMarkers.add(
      Marker(
        markerId: MarkerId(position.hashCode.toString()),
        position: position,
        draggable: true,
        infoWindow: InfoWindow(
          snippet: 'Drag if you want',
          title: 'Your Location Marker',
        ),
        icon: markerIcon,
        onDragEnd: (position){
          emit(MapsScreenMarkerDraggedState(position: position));
          currentLocation = '${position.latitude},${position.longitude}';
        }
      )
    );
    emit(MapsScreenAddedMarkerState(position: position));
  }

  void submitFinalLocation()async{

    emit(MapsScreenFinalLocationState(position: await currentLocation!.latlonRepresentation));
  }

  Future<BitmapDescriptor> getImage()async{
    final asset = await rootBundle.load('lib/core/assets/marker.png');
    final icon = BitmapDescriptor.fromBytes(asset.buffer.asUint8List());
    return icon;
  }
}