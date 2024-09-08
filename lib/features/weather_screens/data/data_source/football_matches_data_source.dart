import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/inner_models/dio_singleton.dart';
import '../models/FootballMatches.dart';

abstract class FootballMatchesBaseDataSource {

  final Dio _dio = DioSingleton.getDioInstance();

  Future<FootballMatches> getComingMatches({required String cityName});
}

class FootballMatchesDataSource extends FootballMatchesBaseDataSource{
  @override
  Future<FootballMatches> getComingMatches({required String cityName}) async{
    var response ;

    try{

      response = await  _dio.get('${AppConstants.baseUrl}${AppConstants.sportsEndPoint}key=${AppConstants.apiKey}&q=$cityName');

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

    return FootballMatches.fromJson(response.data);

  }

}