
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'DayForecast.dart';

part'ComingDaysForecast.g.dart';

// coming days forecast: is just a list of day forecast model (collection of coming days)

@HiveType(typeId: 11)
@JsonSerializable()
class ComingDaysForecast extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'forecastday')
  List<DayForecast>  comingDaysForecast;

  ComingDaysForecast(this.comingDaysForecast);

  factory ComingDaysForecast.fromJson(Map<String,dynamic> json)=>_$ComingDaysForecastFromJson(json);

}