

import '../../data/models/DayForecast.dart';

abstract class ForecastGetter{

  Future<DayForecast> getForecast({required String cityName, required int noDays});

}