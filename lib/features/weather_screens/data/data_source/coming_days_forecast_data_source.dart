import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/inner_models/dio_singleton.dart';
import '../models/ComingDaysForecast.dart';

abstract class BaseComingDyasForecastDataSource {

  final Dio _dio = DioSingleton.getDioInstance();
  Future<ComingDaysForecast> comingDaysForecast({required String cityName});
}

class ComingDaysDataSource extends BaseComingDyasForecastDataSource{
  
  Future<ComingDaysForecast> comingDaysForecast({required String cityName})async{
    var response;
    try{
      String url = '${AppConstants.baseUrl}${AppConstants.forecastEndPoint}key=${AppConstants.apiKey}&q=$cityName&days=10&aqi=no&alerts=no';

      response = await _dio.get(url);
    }
    catch(e,s){

      print('Exception occurred while getting forecasts : $e , $s');

    }
    
    return ComingDaysForecast.fromJson(response.data['forecast']);
  }
}