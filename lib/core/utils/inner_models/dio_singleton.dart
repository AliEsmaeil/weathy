import 'package:dio/dio.dart';
import 'package:weathy/core/constants/app_constants.dart';

final class DioSingleton{

  static Dio? _dio; // lazy initialization instance

  DioSingleton._internal();

  // global access point
  static Dio getDioInstance(){
    if(_dio == null){
    _dio = Dio(
      BaseOptions(
        // no time out limit
        connectTimeout: Duration.zero,
        receiveTimeout: Duration.zero,
        followRedirects: false,
      )
    );
     _dio?.interceptors.add(InterceptorsWrapper(
       onResponse: (response , handler){
         print('********************************************************');
         print('Response from : ${response.realUri.toString()} ');
         print('Response from : ${response.requestOptions.uri.toString()} ');
         print('Response from : ${response.statusMessage} ');
         print('********************************************************');
         return handler.next(response);
       },
       onRequest: (request, handler){
         print('********************************************************');
         print('Request to : ${request.uri.toString()} ');
         print('********************************************************');
         return handler.next(request);
       },
       onError: (error, handler){

         print('********************************************************');
         print('Error in : ${error.requestOptions.uri.toString()} ');
         print('Error  : ${error.error} ');
         print('Error message : ${error.message} ');
         print('Error s t  : ${error.stackTrace} ');
         print('********************************************************');
         return handler.next(error);
       }
     ),
     );
    }
     return _dio!;
  }
}