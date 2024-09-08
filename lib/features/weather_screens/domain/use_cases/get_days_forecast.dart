
import '../../data/models/ComingDaysForecast.dart';
import '../repositories/coming_days_forecast.dart';

class DaysForecastGetter{

  ComingDaysForecastBaseRepo repo;

  DaysForecastGetter(this.repo);

  Future<ComingDaysForecast> getComingDaysForecast({required String cityName})async{

    return await repo.getDaysForecasts(cityName: cityName);
  }
}