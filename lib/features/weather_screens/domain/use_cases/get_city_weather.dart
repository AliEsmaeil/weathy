
import '../../data/models/WeatherModel.dart';
import '../repositories/current_weather.dart';

final class CityWeatherGetter{
  BaseCurrentWeatherCityRepository repo ;

  CityWeatherGetter(this.repo);

  Future<CurrentWeather> getCityWeather({required String cityName})async{

    return await repo.getTodayWeatherByCityName(cityName: cityName);
  }
}