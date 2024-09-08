import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathy/core/utils/shared_pref/shared_pref_streamer.dart';

import '../../features/on_boarding/presentation/screens/on_Boarding_screen.dart';
import '../../features/weather_screens/presentation/screens/home_screen.dart';
import '../constants/app_constants.dart';

class StartConfigurator{

  static late String screenRoute;
  static late bool isLight;
  static bool firstRun = true;

  static void initiateCriticalVars(){
     initiateStartScreenRoute();
     initiateIsLightTheme();
  }
   static void initiateStartScreenRoute(){

     bool isNewUser = SharedPrefStreamer.readData(keyName: AppConstants.isNewUser) ?? true;
     print('is new user = $isNewUser');
     screenRoute =  (isNewUser)? OnBoardingScreen.route:HomeScreen.route;

  }

   static void initiateIsLightTheme(){
     isLight = SharedPrefStreamer.readData(keyName: AppConstants.isLightTheme) ?? true;
     print('is light = $isLight');
  }
}