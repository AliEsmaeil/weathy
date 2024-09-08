import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathy/core/env/config.dart';

class AppConstants{

  /// api constants
  static const baseUrl = 'https://api.weatherapi.com/v1/';
  static final apiKey = Config.apiKey;

  static const currentEndPoint = 'current.json?';
  static const forecastEndPoint = 'forecast.json?';
  static const historyEndPoint = 'history.json?';
  static const futureEndPoint = 'future.json?';
  static const sportsEndPoint = 'sports.json?';

  /// shared preferences constants
  static const isNewUser = 'isNewUser';
  static const isLightTheme = 'isLightTheme';

  /// google map initial location (pyramids)
  static const initialLocation = LatLng(29.976480, 31.131302);

  /// hive boxes , i will use only one box to store all model (generic box) no need to increase number of boxes
  static const modelsBox = 'MODELS_BOX';

  static const currentWeatherModel = 'CURRENT_WEATHER_MODEL';
  static const footballMatchesModel = 'FOOTBALL_MATCHES_MODEL';
  static const todayForecastModel = 'TODAY_FORECAST_MODEL';
  static const comingDaysForecastModel = 'COMING_DAYS_FORECAST_MODEL';
  static const tomorrowForecastModel = 'TOMORROW_FORECAST_MODEL';
  static const futureDayModel = 'FUTURE_DAY_MODEL';

  static const searchCitiesBox = 'SEARCH_CITIES_Box';
  static const searchCitiesKey = 'SEARCH_CITIES_KEY'; // to store list of searched cities in search bar
  static const String lastLocationKey = 'LAST_LOCATION_KEY';
////

}