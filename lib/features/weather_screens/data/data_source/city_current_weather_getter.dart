import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weathy/core/utils/inner_models/dio_singleton.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/WeatherModel.dart';

abstract base class BaseCurrentCityWeatherGetter{
  final Dio _dio = DioSingleton.getDioInstance();
  Future<CurrentWeather> getCurrentWeather({required String cityName});
}

final class CurrentCityWeatherGetter extends BaseCurrentCityWeatherGetter{
  @override
  Future<CurrentWeather> getCurrentWeather({required String cityName}) async{
    var response ;
    try{
      
      response = await  _dio.get('${AppConstants.baseUrl}${AppConstants.currentEndPoint}key=${AppConstants.apiKey}&q=$cityName&aqi=no');


    }

    on DioException catch(e,s){
      print('Dio Exception : $e , $s');
    }
    on Error catch(e,s){
      print('Error : $e , $s');

    }
    on Exception catch(e,s){
      print('Exception : $e , $s');
    }
    catch(e,s){
      print('Unknown object is thrown : $e , $s');
    }

    CurrentWeather weatherModel =  CurrentWeather.fromJson(response.data);

    if(cityName.contains(',')){
// search via lat lon (through map or location detection service)
    weatherModel.constructedViaCitName = false;
      var record = await getExactCityName(weatherModel.location.latitude.toDouble(), weatherModel.location.longitude.toDouble());
      weatherModel.location.administrativeArea = record.$1;
      weatherModel.location.subAdministrativeArea = record.$2;
      weatherModel.location.locality = record.$3;
    }
    else{
      weatherModel.constructedViaCitName = true;
    }

    return weatherModel;
  }

  Future<(String? administrative,String? subAdministrative,String?locality)> getExactCityName(double lat, double lon)async{

    setLocaleIdentifier('en_US');

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon,);

    return (placemarks[0].administrativeArea, placemarks[0].subAdministrativeArea,placemarks[0].locality);

  }

}