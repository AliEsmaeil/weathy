
import '../../data/models/ComingDaysForecast.dart';

abstract class ComingDaysForecastBaseRepo{

  Future<ComingDaysForecast> getDaysForecasts({required String cityName});

}