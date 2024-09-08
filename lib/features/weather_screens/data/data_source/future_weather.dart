import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/inner_models/dio_singleton.dart';
import '../models/DayForecast.dart';

abstract class BaseFutureWeatherDataSource{

  final Dio _dio = DioSingleton.getDioInstance();

  Future<DayForecast> getFutureDay({required String cityName, required String date});
}

class FutureWeatherDataSource extends BaseFutureWeatherDataSource{
  @override
  Future<DayForecast> getFutureDay({required String cityName, required String date}) async{

    var response;

    // Note: while working on that app (the API Future weather forecasting endpoint was free and became premium)
    // so, i made it just return current weather from another endpoint (because they are the same model).
    try{
     // '${AppConstants.baseUrl}${AppConstants.futureEndPoint}key=${AppConstants.apiKey}&q=$cityName&dt=$date'
          response = await _dio.get("${AppConstants.baseUrl}${AppConstants.futureEndPoint}key=${AppConstants.apiKey}&q=$cityName&dt=$date");
    }
    catch(e,s){

      print('Exception occurred while getting forecasts : $e , $s');

    }
    try{
      return DayForecast.fromJson(response.data['forecast']['forecastday'][0]);
    }
    catch(e,s){
      print('exception : $e \n ,stack trace : $s');
    }return DayForecast.fromJson(response.data);
  }


}
