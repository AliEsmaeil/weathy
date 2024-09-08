
import '../../data/models/DayForecast.dart';
import '../repositories/future_weather.dart';

class FutureWeatherGetter{

  FutureWeather repo;

  FutureWeatherGetter(this.repo);

  Future<DayForecast> getFutureDayWeather({required String cityName, required String date})async{
   return await repo.getFutureDayWeather(cityName: cityName, date: date) ;
  }
}