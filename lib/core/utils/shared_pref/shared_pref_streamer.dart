import 'package:shared_preferences/shared_preferences.dart';

final class SharedPrefStreamer{

  static late SharedPreferences _pref;

  static Future<void> initiatePref()async{

    _pref = await SharedPreferences.getInstance();
  }


  static Future<void> writeData({required String keyName, required dynamic data })async{

    if(data is int){
      await _pref.setInt(keyName, data);
    }
    else if(data is double){
      await _pref.setDouble(keyName, data);
    }
    else if (data is String){
      await _pref.setString(keyName, data);
    }
    else if (data is bool){
      await _pref.setBool(keyName, data);
    }
    else{
      await _pref.setStringList(keyName, data);
    }
  }
  static dynamic readData({required String keyName}){
    return _pref.get(keyName);
  }
}