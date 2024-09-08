
import '../../data/models/DayForecast.dart';

abstract class FutureWeather{

  Future<DayForecast> getFutureDayWeather({required String cityName ,required String date});

}