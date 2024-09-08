import 'package:weathy/features/weather_screens/domain/repositories/hive_streamer.dart';

class HiveStreamerUseCase {

  HiveStreamer hiveStreamer;

  HiveStreamerUseCase({required this.hiveStreamer});

  void writeModel<T extends Object>({required String key, required T model}){
    hiveStreamer.writeModel(key: key, model: model);
  }

  Future<T?> readModel<T extends Object?>({required String key})async{
   return await hiveStreamer.getModel(key: key);
  }


  void addSearchedCity({required String newSearchedCity}){
    hiveStreamer.addSearchedCity(newSearchedCity: newSearchedCity);
  }

  Future<String> get lastLocation async => await hiveStreamer.lastLocation;

  void updateLocation({required String newLocation}) {
    hiveStreamer.updateLocation(newLocation: newLocation);
  }

  Future<List<String>> getSearchedCities()async{
    return await hiveStreamer.getSearchedCities();
  }

  void clearModelsBox()async {
    hiveStreamer.clearModelsBox();
  }

  void clearSearchedCitiesBox() async{
    hiveStreamer.clearSearchedCitiesBox();
  }


}