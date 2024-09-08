import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathy/core/utils/extensions/LatLonString_extension.dart';
import 'package:weathy/core/utils/extensions/StringLatLon_extension.dart';
import 'package:weathy/features/weather_screens/presentation/controllers/current_weather_cubit/cubit.dart';

import '../weather_screens/presentation/screens/home_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MapsScreen extends StatelessWidget {
  static const route = 'mapsScreen';

  MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>MapsScreenCubit(),
      child: BlocConsumer<MapsScreenCubit, MapsScreenStates>(
        listener: (context, state) {
          if(state is MapsScreenFinalLocationState){
            BlocProvider.of<HomeScreenCubit>(context).changeLocationByMap(state.position.stringRepresentation);
            Navigator.of(context).pushNamedAndRemoveUntil( // navigate holding location
              HomeScreen.route,
              (Route r) => false,
            );
          }
        },
        builder: (context, state) {
          var cubit = MapsScreenCubit.getCubit(context);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Location Determining',
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            body: GoogleMap(
              buildingsEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              rotateGesturesEnabled: true,
              zoomGesturesEnabled: true,

              initialCameraPosition: CameraPosition(
                target: HomeScreenCubit.latLngLocation!,
                zoom: 2,),
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              markers: cubit.myMarkers,
              onTap: (LatLng position) {
               cubit.addMarker(position);
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              heroTag: 'anyTag',
              backgroundColor: Colors.grey,
              onPressed: () {
                cubit.submitFinalLocation();
              },
              icon: Icon(Icons.location_history),
              label: Text('Submit Location'),
            ),
          );
        },
      ),
    );
  }
}
