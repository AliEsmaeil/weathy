import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathy/core/utils/check_connectivity.dart';
import 'package:weathy/core/utils/extensions/LatLonString_extension.dart';
import 'package:weathy/core/utils/extensions/StringLatLon_extension.dart';
import 'package:weathy/core/utils/extensions/current_day_extension.dart';
import 'package:weathy/core/utils/start_config.dart';
import 'package:weathy/features/maps_screen/cubit/cubit.dart';
import 'package:weathy/features/weather_screens/data/data_source/hive_streamer_data_source.dart';
import 'package:weathy/features/weather_screens/data/repositories/hive_streamer_repo.dart';
import 'package:weathy/features/weather_screens/domain/use_cases/stream_with_hive.dart';
import 'package:weathy/features/weather_screens/presentation/controllers/current_weather_cubit/states.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/utils/geo_locator/geo_locator_streamer.dart';
import '../../../../../core/utils/shared_pref/shared_pref_streamer.dart';
import '../../../data/data_source/city_current_weather_getter.dart';
import '../../../data/data_source/coming_days_forecast_data_source.dart';
import '../../../data/data_source/football_matches_data_source.dart';
import '../../../data/data_source/forecast_getter.dart';
import '../../../data/data_source/future_weather.dart';
import '../../../data/models/ComingDaysForecast.dart';
import '../../../data/models/DayForecast.dart';
import '../../../data/models/FootballMatches.dart';
import '../../../data/models/WeatherModel.dart';
import '../../../data/repositories/city_current_weather_repo.dart';
import '../../../data/repositories/coming_days_forecast_repo.dart';
import '../../../data/repositories/football_matches_repo.dart';
import '../../../data/repositories/forecast_repo.dart';
import '../../../data/repositories/future_weather_repo.dart';
import '../../../domain/use_cases/football_matches.dart';
import '../../../domain/use_cases/forecast.dart';
import '../../../domain/use_cases/future_weather_getter.dart';
import '../../../domain/use_cases/get_city_weather.dart';
import '../../../domain/use_cases/get_days_forecast.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  // data streaming objects

  final CityWeatherGetter _weatherGetter = CityWeatherGetter(
      CurrentCityWeatherRepository(CurrentCityWeatherGetter()));

  final ForecastUseCase _forecastsGetter =
      ForecastUseCase(ForecastRepository(ForecastDataSource()));

  final DaysForecastGetter _comingDayForecastGetter =
      DaysForecastGetter(ComingDaysForecastRepo(ComingDaysDataSource()));

  final FootballMatchesUseCase _comingFootballMatchesGetter =
      FootballMatchesUseCase(FootballMatchesRepo(FootballMatchesDataSource()));

  final FutureWeatherGetter _futureWeatherGetter =
      FutureWeatherGetter(FutureWeatherRepo(FutureWeatherDataSource()));

  final HiveStreamerUseCase _hiveStreamer = HiveStreamerUseCase(
      hiveStreamer: HiveStreamerRepo(dataSource: HiveStreamerDataSource()));



  // data models that are represented in the GUI
  CurrentWeather? currentWeather;
  DayForecast? todayForecast;
  DayForecast? tomorrowForecast;
  ComingDaysForecast? comingDaysForecast;
  FootballMatches? footballMatches;
  DayForecast? futureDayWeather;

  String location = '29.9792,31.1342'; // as a start default location, it will be reassigned on start
  static LatLng? latLngLocation;

  bool forceGet = false;
  var isConnected;
  bool isLightTheme = StartConfigurator.isLight;

  //////////////////// initializer scope end

  HomeScreenCubit() : super(HomeScreenInitialState()) {
    // the status of the user must be handled here, because of location getting phase at the begin of app
    initializeData();

  }
  void initializeData()async{
    listenForInternetState();
    getLastLocation();
    handleNewUser();
    await getWholeData();
  }
  void listenForInternetState()async{
    Connectivity().onConnectivityChanged.listen((event)async{
/*      ConnectivityResult.
       = event.contains(ConnectivityResult.vpn) || event.contains(ConnectivityResult.other)
      || event.contains(ConnectivityResult.ethernet) || event.contains(ConnectivityResult.mobile)
      || event.contains(ConnectivityResult.wifi) &&*/

      isConnected =  await checkConnectivity();

      if(!isConnected){
        print('/////////////////NO INTERNET CONNECTION///////////////');
        emit(HomeNoInternetConnectionState());
      }
      else{
        print('/////////////////INTERNET CONNECTION///////////////');
        emit(HomeInternetConnectionState());
        if(!StartConfigurator.firstRun){
          print('/////////////////WILL REBUILD///////////////');
          await updateDataModels();
          StartConfigurator.firstRun = !StartConfigurator.firstRun;
        }
      }
    });

  }

  void getLastLocation()async{
    location = await _hiveStreamer.lastLocation;
    latLngLocation ??= await location.latlonRepresentation;
  }

  static HomeScreenCubit getCubit(BuildContext context)=>BlocProvider.of(context);

  Future<void> getWholeData()async{
    latLngLocation ??= await location.latlonRepresentation;
    emit(HomeScreenLoadingState());
    await getCurrentWeather();
    await getTodayWeatherForecasts();
    await getTomorrowWeatherForecasts();
    await getComingFootballMatches();
    await getComingDayForecasts();
    await getFutureDayWeather(date: DateTime.now().add(Duration(days: 30)).getDateInAPIFormat());
    emit(HomeScreenGotDataState());
    saveInHiveIfDifferent();
  }
  Future<CurrentWeather> getCurrentWeather() async {
    if (isConnected ??=  await checkConnectivity()) {
      if (forceGet) {
        return currentWeather = await _weatherGetter.getCityWeather(cityName: location);
      } else {
        return currentWeather ??= await _weatherGetter.getCityWeather(cityName: location);
      }
    } else {
      return currentWeather ??= (await _hiveStreamer.readModel(key: AppConstants.currentWeatherModel))!;
    }
  }

  Future<DayForecast> getTodayWeatherForecasts() async {

    if(isConnected ??=  await checkConnectivity()){
      if (forceGet) {
        return todayForecast =
        await _forecastsGetter.getForecasts(cityName: location, noDays: 0);
      } else {
        return todayForecast ??= await _forecastsGetter.getForecasts(cityName: location, noDays: 0);
      }
    }
    else{
      return todayForecast ??= (await _hiveStreamer.readModel(key: AppConstants.todayForecastModel))!;
    }
  }

  Future<DayForecast> getTomorrowWeatherForecasts() async {

    if(isConnected ??=  await checkConnectivity()){
      if (forceGet) {
        return tomorrowForecast = await _forecastsGetter.getForecasts(cityName: location, noDays: 1);
      } else {
        return tomorrowForecast ??= await _forecastsGetter.getForecasts(cityName: location, noDays: 1);
      }
    }
    else{
      return tomorrowForecast  ??= (await _hiveStreamer.readModel(key: AppConstants.tomorrowForecastModel))!;
    }
  }

  Future<ComingDaysForecast> getComingDayForecasts() async {

    if(isConnected ??=  await checkConnectivity()){
      if (forceGet) {
        return comingDaysForecast = await _comingDayForecastGetter.getComingDaysForecast(cityName: location);
      } else {
        return comingDaysForecast ??= await _comingDayForecastGetter.getComingDaysForecast(cityName: location);
      }
    }
    else{
      return comingDaysForecast ??= (await _hiveStreamer.readModel(key: AppConstants.comingDaysForecastModel))!;
    }
  }

  Future<FootballMatches> getComingFootballMatches() async {

    if(isConnected ??=  await checkConnectivity()){
      if (forceGet) {
        return footballMatches = await _comingFootballMatchesGetter.getMatches(cityName: location);
      } else {
        return footballMatches ??= await _comingFootballMatchesGetter.getMatches(cityName: location);
      }
    }
    else{
      return footballMatches ??= (await _hiveStreamer.readModel(key: AppConstants.footballMatchesModel))!;
    }
  }

  Future<DayForecast> getFutureDayWeather({required String date}) async {

    if(isConnected ??=  await checkConnectivity()){
      if (forceGet) {
        return futureDayWeather = await _futureWeatherGetter.getFutureDayWeather(cityName: location, date: date);
      } else {
        return futureDayWeather ??= await _futureWeatherGetter.getFutureDayWeather(cityName: location, date: date);
      }
    }
    else{
      return futureDayWeather??= (await _hiveStreamer.readModel(key: AppConstants.futureDayModel))!;
    }
  }

  void handleNewUser() async {
    if (SharedPrefStreamer.readData(keyName: AppConstants.isNewUser) == null) {
      await SharedPrefStreamer.writeData(
          keyName: AppConstants.isNewUser, data: false);
    }
  }

  void changeLocationByGeoLocator() async {
    var newLocation = await GeoLocatorStreamer.getPosition();
    if(newLocation != null) {
      location = newLocation;
      await updateDataModels();
      updateLastLocationInHive(location);
    }
  }

  void changeLocationByMap(String newLocation)async {
    print("current location : $location, new location $newLocation");
    location = newLocation;
    print("LOCATION CHANGED");
    await updateDataModels();
    print("Models updated");
    updateLastLocationInHive(location);
  }

  void changeLocationFromSearchBar()async{
    await updateDataModels();
    updateLastLocationInHive(location);
  }

  void updateLastLocationInHive(String newLocation){
    _hiveStreamer.updateLocation(newLocation: newLocation);
  }

  Future<void> updateDataModels()async{
    forceGet = true;
    await getWholeData();
    forceGet = false;
  }

  void saveInHiveIfDifferent()async{
    var  model = await _hiveStreamer.readModel(key: AppConstants.currentWeatherModel);

    if(model == null){ /// hive doesn't have data yet
      saveDataModelsInHive();
    }
    else{ /// it has a value, hive already store data
      // check if i have a new data
      if(!(currentWeather == model)){
        // different data, store it
        saveDataModelsInHive();
      }
    }

  }

  void saveDataModelsInHive()async {
      _hiveStreamer.clearModelsBox();
      _hiveStreamer.writeModel(
          key: AppConstants.currentWeatherModel, model: currentWeather!);
      _hiveStreamer.writeModel(
          key: AppConstants.futureDayModel, model: futureDayWeather!);
      _hiveStreamer.writeModel(
          key: AppConstants.footballMatchesModel, model: footballMatches!);
      _hiveStreamer.writeModel(
          key: AppConstants.comingDaysForecastModel, model: comingDaysForecast!);
      _hiveStreamer.writeModel(
          key: AppConstants.tomorrowForecastModel, model: tomorrowForecast!);
      _hiveStreamer.writeModel(
          key: AppConstants.todayForecastModel, model: todayForecast!);
  }

  // FutureOr is just a type union between (List<Widget> and Future<List<Widget>>)

  Future<List<String>> getSearchedCities()async{
    var list =  await _hiveStreamer.getSearchedCities();
    if(list.isEmpty)
      {
        return <String>['Egypt' , 'Italy' , 'England' , 'America' , 'Brazil' , 'Peru'];

      }
    return list.toSet().toList();
  }

  void checkIfApiKnowsCity({required String city})async{
    emit(HomeScreenLoadingState());
    var response = await http.get(Uri.parse('${AppConstants.baseUrl}${AppConstants.currentEndPoint}key=${AppConstants.apiKey}&q=$city&aqi=no'));
    bool isCorrect = (response.statusCode == 200 && response.body.isNotEmpty);
    if(isCorrect){
      location = city;
      changeLocationFromSearchBar();
      _hiveStreamer.addSearchedCity(newSearchedCity: city);
      emit(HomeCorrectCitySearchState());
    }
    else{
      emit(HomeInCorrectCitySearchState());
    }
  }


  // this function service the future day only, all coming update need not to be stored (user just see the future)
  void getFutureDay(String date)async{
    if(isConnected){
      emit(HomeScreenLoadingState());
      forceGet = true;
      await getFutureDayWeather(date: date).then((value) {
        forceGet = false;
        emit(HomeScreenGotDataState());
      });
    }
    else{
      emit(HomeNoInternetConnectionState());
    }

  }

  void changeThemeMode(){
    StartConfigurator.isLight = !StartConfigurator.isLight;
    SharedPrefStreamer.writeData(keyName: AppConstants.isLightTheme , data: StartConfigurator.isLight);
    emit(HomeScreenChangedThemeModeState());
  }

/*
  void changeThemeMode(){
    bool themeMode = SharedPrefReader.readData(keyName: AppConstants.isLightTheme) as bool ?? true;
    SharedPrefWriter.writeData(keyName: AppConstants.isLightTheme, data: !themeMode );

    emit(HomeScreenChangedThemeModeState());
  }*/
}
