import 'package:hive/hive.dart';
import 'package:weathy/core/constants/app_constants.dart';
import 'package:weathy/features/weather_screens/data/data_source/hive_config.dart';

abstract class BaseHiveStreamerDataSource{

  void write<T extends Object> ({required String key , required T model});
  Future<T?> read<T extends Object?> ({required String key});
  void addSearchedCity({required String newSearchedCity});
  Future<List<String>> getSearchedCities();
  Future<String> get lastLocation;
  void updateLocation({required String newLocation});
  void clearModelsBox();
  void clearSearchedCitiesBox();
}

class HiveStreamerDataSource extends BaseHiveStreamerDataSource{
  static int writeNo = 0;
  late LazyBox models =   HiveConfigurator.modelsBox;
  late LazyBox searchedCities = HiveConfigurator.searchCitiesBox ;

  HiveStreamerDataSource();

  @override
  Future<T?> read<T extends Object?>({required String key}) async=> await models.get(key);

  @override
  void write<T extends Object>({required String key,required T model})async{

    await models.put(key,model);
    writeNo++;
    print('I WROTE IN HIVE , number of write ops : ${writeNo}');
  }


  @override
  void addSearchedCity({required String newSearchedCity}) async{
    List<String>? citiesList = await searchedCities.get(AppConstants.searchCitiesKey);
    if(citiesList == null || citiesList.isEmpty ){
      citiesList = [newSearchedCity];
    }
    else{
      citiesList.add(newSearchedCity);
    }
    await searchedCities.put(AppConstants.searchCitiesKey, citiesList);
  }

  @override
  Future<List<String>> getSearchedCities()async{
    List<String>? citiesList = await searchedCities.get(AppConstants.searchCitiesKey);
    if(citiesList == null || citiesList.isEmpty ){
      return <String>[];
    }
    else{
      return citiesList;
    }
  }

  @override
  Future<String> get lastLocation async=> await searchedCities.get(AppConstants.lastLocationKey)?? '29.9792,31.1342';

  @override
  void updateLocation({required String newLocation})async {
    await searchedCities.put(AppConstants.lastLocationKey, newLocation);
  }

  @override
  void clearModelsBox()async {
    await models.clear();
  }
  @override
  void clearSearchedCitiesBox() async{
    searchedCities.clear();
  }

}