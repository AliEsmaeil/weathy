
import '../../data/models/WeatherModel.dart';

abstract class BaseCurrentWeatherCityRepository{

  Future<CurrentWeather> getTodayWeatherByCityName({required String cityName});

}
