abstract class HiveStreamer{

   void writeModel<T extends Object> ({required String key ,required T model});
   Future<T?> getModel<T extends Object?> ({required String key});
   void addSearchedCity({required String newSearchedCity});
   Future<String> get lastLocation ;
   void updateLocation({required String newLocation});
   Future<List<String>> getSearchedCities();
   void clearModelsBox();
   void clearSearchedCitiesBox();
}

