import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weathy/core/constants/app_constants.dart';
import 'package:weathy/core/utils/components/animated_loading_container.dart';
import 'package:weathy/features/maps_screen/cubit/cubit.dart';
import 'package:weathy/features/weather_screens/data/data_source/hive_config.dart';
import 'package:weathy/features/weather_screens/presentation/controllers/current_weather_cubit/cubit.dart';
import 'package:weathy/features/weather_screens/presentation/controllers/current_weather_cubit/states.dart';

import 'core/constants/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/shared_pref/shared_pref_streamer.dart';
import 'core/utils/start_config.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfigurator.initiateHive();
  await SharedPrefStreamer.initiatePref();
  StartConfigurator.initiateCriticalVars();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
  ));
/*
  if(Hive.lazyBox(AppConstants.modelsBox).isNotEmpty){
    print('yeah , there\'s data in the box');

    for(var key in Hive.lazyBox(AppConstants.modelsBox).keys){
      print('*********************************DataModel*********************');
      print('$key : ${await Hive.lazyBox(AppConstants.modelsBox).get(key)}');
      print('*************************************************************');
    }
  }*/
  Bloc.observer = MyBlocObserver();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('Is that build called twice ?');
    return  BlocProvider(
      create: (context)=>HomeScreenCubit(),
      child: BlocConsumer<HomeScreenCubit,HomeScreenStates>(
        listener: (context,state){},
        builder:(context,state){
          return MaterialApp(
            routes: routes,
            initialRoute: StartConfigurator.screenRoute,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: StartConfigurator.isLight ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),

    );
  }
}

