import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weathy/core/constants/app_constants.dart';
import 'package:weathy/features/weather_screens/data/models/ComingDaysForecast.dart';
import 'package:weathy/features/weather_screens/data/models/DayForecast.dart';
import 'package:weathy/features/weather_screens/data/models/FootballMatches.dart';
import 'package:weathy/features/weather_screens/data/models/WeatherModel.dart';

final class HiveConfigurator{

  static Future<void> initiateHive()async{

    // the extension package (flutter_hive) encapsulates initFlutter() method that provide app
    // directory path to the hive db to store within.

    await Hive.initFlutter();

    // register all hive adapters
    // btw, an adapter: is an intermediary layer that convert the complex custom object to binary format
    // and vice versa.

    // note: hive impose rules before usage:
    //* all adapters must be registered before usage
    //* box must be opened before usage
    //*reopening an opened box will not change anything, it just ignore all params you pass to open method
    Hive.registerAdapter(ConditionAdapter());
    Hive.registerAdapter(CurrentAdapter());
    Hive.registerAdapter(LocationAdapter());
    Hive.registerAdapter(CurrentWeatherAdapter());
    Hive.registerAdapter(MatchAdapter());
    Hive.registerAdapter(FootballMatchesAdapter());
    Hive.registerAdapter(HourAdapter());
    Hive.registerAdapter(AstronomyAdapter());
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(DayForecastAdapter());
    Hive.registerAdapter(ComingDaysForecastAdapter());

    await Hive.openLazyBox(AppConstants.modelsBox);
    await Hive.openLazyBox(AppConstants.searchCitiesBox);

  }

  static Future<void> clearModelsBox()async{
    await Hive.lazyBox(AppConstants.modelsBox).clear();
  }
  static LazyBox get searchCitiesBox => Hive.lazyBox(AppConstants.searchCitiesBox);
  static LazyBox get modelsBox => Hive.lazyBox(AppConstants.modelsBox);

}