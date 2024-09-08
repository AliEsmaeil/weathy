
import '../../data/models/DayForecast.dart';
import '../repositories/forecast.dart';

class ForecastUseCase {

  ForecastGetter repo;

  ForecastUseCase(this.repo);

  /// noDays :
  /// 0 for today forecasts
  /// 1 for tomorrow forecasts
  /// and N for N coming days forecasts
  Future<DayForecast> getForecasts({required String cityName, required int noDays})async{

    return await repo.getForecast(cityName: cityName, noDays: noDays);
  }
}