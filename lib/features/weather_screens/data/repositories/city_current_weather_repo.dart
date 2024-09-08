
import '../../domain/repositories/current_weather.dart';
import '../data_source/city_current_weather_getter.dart';
import '../models/WeatherModel.dart';

class CurrentCityWeatherRepository implements BaseCurrentWeatherCityRepository{

  BaseCurrentCityWeatherGetter repository;

  CurrentCityWeatherRepository(this.repository);

  @override
  Future<CurrentWeather> getTodayWeatherByCityName({required String cityName})async {

    return await repository.getCurrentWeather(cityName: cityName);
  }

}

