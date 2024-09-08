import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathy/core/utils/components/snack_bar.dart';
import 'package:weathy/core/utils/extensions/LatLonString_extension.dart';
import 'package:weathy/core/utils/inner_models/internet_connection_state.dart';
import 'package:weathy/features/maps_screen/cubit/cubit.dart';
import 'package:weathy/features/maps_screen/cubit/states.dart';

import '../../../../core/utils/components/location_service_dialog.dart';
import '../controllers/current_weather_cubit/cubit.dart';
import '../controllers/current_weather_cubit/states.dart';
import '../tabs/current_weather_tab.dart';
import '../tabs/forecast_tab.dart';
import '../tabs/future_tab.dart';
import '../tabs/sports_tab.dart';

class HomeScreen extends StatelessWidget {
  static const route = 'weatherScreen';

  final body = [
    CurrentWeatherTab(),
    PredictionTab(),
    SportsTab(),
    FutureWeatherForecast()
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (context, state) {
      if (state is HomeInCorrectCitySearchState) {
        showAlertDialog(
          context: context,
          message:
              'Incorrect city name, please be more general. If you are entering a city name enter the country name instead.',
          title: 'Wrong City',
        );
      }
      if (state is HomeNoInternetConnectionState) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
            message: 'You are offline, old data is viewed.',
            connectionState: InternetConnectionState.offline));
      }
      if (state is HomeInternetConnectionState) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
            message: 'You are online, weather status will be refreshed.',
            connectionState: InternetConnectionState.online));
      }
    }, builder: (context, state) {
      var cubit = HomeScreenCubit.getCubit(context);

      return DefaultTabController(
        length: 4,
        child: PopScope(
          canPop: Navigator.of(context).canPop(),
          onPopInvoked: (canPop)async{
            if(!canPop){
              await cubit.updateDataModels();
            }
          },
          child: Scaffold(
              body: SafeArea(
                child: TabBarView(
                  children: body,
                ),
              ),
              bottomNavigationBar: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.batch_prediction),
                  ),
                  Tab(
                    icon: Icon(Icons.sports_volleyball),
                  ),
                  Tab(
                    icon: Icon(Icons.data_exploration),
                  ),
                ],
              )),
        ),
      );
    });
  }
}
