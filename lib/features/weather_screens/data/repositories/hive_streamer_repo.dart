import 'package:weathy/features/weather_screens/data/data_source/hive_streamer_data_source.dart';
import 'package:weathy/features/weather_screens/domain/repositories/hive_streamer.dart';

final class HiveStreamerRepo extends HiveStreamer{

  BaseHiveStreamerDataSource dataSource;

  HiveStreamerRepo({required this.dataSource});

  @override
  void writeModel<T extends Object>({required String key , required T model}) {
    dataSource.write(key: key, model: model);
  }

  @override
  Future<T?> getModel<T extends Object?>({required String key})async{
    return await dataSource.read(key: key);
  }

  @override
  void addSearchedCity({required String newSearchedCity}){
     dataSource.addSearchedCity(newSearchedCity: newSearchedCity);
  }

  @override
  Future<String> get lastLocation async =>await dataSource.lastLocation;

  @override
  void updateLocation({required String newLocation}) {
    dataSource.updateLocation(newLocation: newLocation);
  }
  Future<List<String>> getSearchedCities()async{
    return await dataSource.getSearchedCities();
  }
  @override
  void clearModelsBox()async {
    dataSource.clearModelsBox();
  }
@override
  void clearSearchedCitiesBox() async{
    dataSource.clearSearchedCitiesBox();
  }

}