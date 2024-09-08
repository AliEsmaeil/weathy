
import '../../domain/repositories/future_weather.dart';
import '../data_source/future_weather.dart';
import '../models/DayForecast.dart';

class FutureWeatherRepo extends FutureWeather{
  BaseFutureWeatherDataSource dataSource;

  FutureWeatherRepo(this.dataSource);

  @override
  Future<DayForecast> getFutureDayWeather({required String cityName, required String date})async {
   return await dataSource.getFutureDay(cityName: cityName, date: date);
  }

}