
import '../../domain/repositories/forecast.dart';
import '../data_source/forecast_getter.dart';
import '../models/DayForecast.dart';

class ForecastRepository extends ForecastGetter{

  BaseTodayForecast dataSource;

  ForecastRepository(this.dataSource);

  @override
  Future<DayForecast> getForecast({required String cityName, required int noDays})async {

    return await dataSource.getForecast(cityName: cityName, noDays: noDays);
  }

}