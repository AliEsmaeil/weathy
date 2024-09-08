import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/inner_models/dio_singleton.dart';
import '../models/DayForecast.dart';

abstract class BaseTodayForecast{

  final Dio _dio = DioSingleton.getDioInstance();
  Future<DayForecast> getForecast({required String cityName, required int noDays});
  
}

class ForecastDataSource extends BaseTodayForecast{
  @override
  Future<DayForecast> getForecast({required String cityName, required int noDays}) async{
    
    var response;
    
    try{
      String url;

      switch(noDays){
        case 0 :
          url = '${AppConstants.baseUrl}${AppConstants.forecastEndPoint}key=${AppConstants.apiKey}&q=$cityName&days=1&aqi=no&alerts=no';
          break;
        case 1:
          url = '${AppConstants.baseUrl}${AppConstants.forecastEndPoint}key=${AppConstants.apiKey}&q=$cityName&days=2&aqi=no&alerts=no';
          break;
        default:
          url = '${AppConstants.baseUrl}${AppConstants.forecastEndPoint}key=${AppConstants.apiKey}&q=$cityName&days=$noDays&aqi=no&alerts=no';

      }

      response = await _dio.get(url);
    }
    catch(e,s){

      print('Exception occurred while getting forecasts : $e , $s');

    }

    return switch(noDays){
      0 => DayForecast.fromJson(response.data['forecast']['forecastday'][0]),
      1 => DayForecast.fromJson(response.data['forecast']['forecastday'][1]),
      _ => DayForecast.fromJson(response.data['forecast']['forecastday'][0]),
    };
  }
  
}