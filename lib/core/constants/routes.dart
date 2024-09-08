
import 'package:flutter/material.dart';

import '../../features/maps_screen/maps_screen.dart';
import '../../features/on_boarding/presentation/screens/on_Boarding_screen.dart';
import '../../features/weather_screens/presentation/screens/home_screen.dart';

Map<String,WidgetBuilder> routes = {

  OnBoardingScreen.route : (context)=>OnBoardingScreen(),
  HomeScreen.route : (context)=>HomeScreen(),
  MapsScreen.route : (context)=>MapsScreen(),

};