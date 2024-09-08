import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weathy/features/weather_screens/data/models/WeatherModel.dart';

part 'DayForecast.g.dart';


// DayForecast: is an accumulative model for the lower models

@HiveType(typeId: 10)
@JsonSerializable()
class DayForecast extends HiveObject{

  @HiveField(0)
  String date;

  @HiveField(1)
  Day day;

  @HiveField(2)
  @JsonKey(name: 'astro')
  Astronomy astronomy;

  @HiveField(3)
  @JsonKey(name: 'hour')
  List<Hour> hoursOverDay;

  DayForecast(this.day, this.astronomy, this.hoursOverDay, this.date);

  factory DayForecast.fromJson(Map<String,dynamic> json)=>_$DayForecastFromJson(json);
  Map<String,dynamic> toJson()=>_$DayForecastToJson(this);

}

// day model : contains basic weather info about the day

@HiveType(typeId: 9)
@JsonSerializable()
class Day{

  @HiveField(0)
  @JsonKey(name: 'maxtemp_c')
  num maxTemp;

  @HiveField(1)
  @JsonKey(name: 'mintemp_c')
  num minTemp;

  @HiveField(2)
  @JsonKey(name: 'daily_chance_of_rain')
  num? rainChance;

  @HiveField(3)
  @JsonKey(name: 'daily_chance_of_snow')
  num? snowChance;

  @HiveField(4)
  Condition condition;

  Day(this.maxTemp, this.minTemp, this.rainChance, this.snowChance, this.condition);

  factory Day.fromJson(Map<String,dynamic> json)=>_$DayFromJson(json);
  Map<String,dynamic> toJson()=>_$DayToJson(this);

}


// astronomy model : contains astronomy info about time of sun set and rise as well as the moon's time.

@HiveType(typeId : 8)
@JsonSerializable()
class Astronomy{

  @HiveField(0)
  @JsonKey(name: 'sunrise')
  String sunRise;

  @HiveField(1)
  @JsonKey(name: 'sunset')
  String sunSet;

  @HiveField(2)
  @JsonKey(name: 'moonrise')
  String moonRise;

  @HiveField(3)
  @JsonKey(name: 'moonset')
  String moonSet;

  Astronomy(this.sunRise, this.sunSet, this.moonRise, this.moonSet);

  factory Astronomy.fromJson(Map<String,dynamic> json)=>_$AstronomyFromJson(json);
  Map<String,dynamic> toJson()=>_$AstronomyToJson(this);
}

// hour model: contains weather status of every hour in the day

@HiveType(typeId: 7)
@JsonSerializable()
class Hour{

  @HiveField(0)
  Condition condition;
  
  @HiveField(1)
  String time;

  @HiveField(2)
  @JsonKey(name: 'temp_c')
  num temp;

  @HiveField(3)
  @JsonKey(name: 'wind_kph')
  num windSpeed;

  @HiveField(4)
  @JsonKey(name: 'pressure_in')
  num pressure;

  @HiveField(5)
  num humidity;

  @HiveField(6)
  @JsonKey(name: 'cloud')

  @HiveField(7)
  num clouds;

  @HiveField(8)
  @JsonKey(name: 'feelslike_c')
  num feelsLike;

  @HiveField(9)
  @JsonKey(name: 'chance_of_rain')
  num rainChance;

  @HiveField(10)
  @JsonKey(name: 'chance_of_snow')
  num snowChance;

  @HiveField(11)
  @JsonKey(name: 'vis_km')
  num visionPerKiloMeter;

  Hour(
      this.time,
      this.temp,
      this.windSpeed,
      this.pressure,
      this.humidity,
      this.clouds,
      this.feelsLike,
      this.rainChance,
      this.snowChance,
      this.visionPerKiloMeter,
      this.condition,
      );


  factory Hour.fromJson(Map<String,dynamic> json)=>_$HourFromJson(json);
  Map<String,dynamic> toJson()=>_$HourToJson(this);

}

