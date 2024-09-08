
import '../../domain/repositories/coming_days_forecast.dart';
import '../data_source/coming_days_forecast_data_source.dart';
import '../models/ComingDaysForecast.dart';

class ComingDaysForecastRepo extends ComingDaysForecastBaseRepo{

  BaseComingDyasForecastDataSource  dataSource;

  ComingDaysForecastRepo(this.dataSource);

  @override
  Future<ComingDaysForecast> getDaysForecasts({required String cityName}) async{
    return await dataSource.comingDaysForecast(cityName: cityName);
  }

}