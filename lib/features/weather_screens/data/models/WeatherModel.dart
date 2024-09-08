import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part'WeatherModel.g.dart';

// current weather model: is an accumulative model of the lower models which contains location info and weather status

@HiveType(typeId: 4)
@JsonSerializable()
class CurrentWeather extends HiveObject {

  @HiveField(0)
  Location location;

  @HiveField(1)
  Current current;

  @HiveField(2)
  bool? constructedViaCitName;

  CurrentWeather({required this.current, required this.location});

  @override
  get hashCode =>current.hashCode;

  @override
  bool operator ==(Object other){
    if(other is CurrentWeather){
      // compare any common attributes
      return ((location.latitude == other.location.latitude) && (current.feelsLike == other.current.feelsLike));
    }
    else{
      return false;
    }

  }

  factory CurrentWeather.fromJson(Map<String,dynamic> json)=>_$CurrentWeatherFromJson(json);
  Map<String,dynamic> toJson()=>_$CurrentWeatherToJson(this);
}


// location model: just holds info about the location which the user gets its weather

@HiveType(typeId: 3)
@JsonSerializable()
class Location {
  @HiveField(0)
  @JsonKey(name: 'name')
  String cityName;

  @HiveField(1)
  String country;

  @HiveField(2)
  @JsonKey(name: 'lat')
  num latitude;

  @HiveField(3)
  @JsonKey(name: 'lon')
  num longitude;

  @HiveField(4)
  @JsonKey(name: 'localtime')
  String localTime;

  @HiveField(5)  // like london, cairo, paris, boston
  String? administrativeArea;

  @HiveField(6) // like acton city within london,
  String? subAdministrativeArea;

  @HiveField(7) // refers to specific small area within subAdministrative area like village
  String? locality;

  Location(
      {required this.cityName,
        required this.country,
        required this.latitude,
        required this.longitude,
        required this.localTime});

  factory Location.fromJson(Map<String,dynamic> json)=>_$LocationFromJson(json);
  Map<String,dynamic> toJson()=>_$LocationToJson(this);
}




// current model  : current is a description model of weather status that holds some numerical properties



@HiveType(typeId: 2)
@JsonSerializable()
class Current {
  @HiveField(0)
  Condition condition;

  @HiveField(1)
  @JsonKey(name: 'temp_c')
  num temperature;

  @HiveField(2)
  @JsonKey(name: 'vis_km')
  num visionPerKiloMeter;

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
  num clouds;

  @HiveField(7)
  @JsonKey(name: 'feelslike_c')
  num feelsLike;

  Current({
    required this.temperature,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.feelsLike,
    required this.visionPerKiloMeter,
    required this.condition,
  });

  factory Current.fromJson(Map<String,dynamic> json)=>_$CurrentFromJson(json);
  Map<String,dynamic> toJson()=>_$CurrentToJson(this);
}


// condition model : condition refers to weather condition by just a description text and an icon
@HiveType(typeId: 1)
@JsonSerializable()
class Condition {
  @HiveField(0)
  @JsonKey(name: 'text')
  String weatherDescription;
  @HiveField(1)
  @JsonKey(name: 'icon')
  String weatherIcon;

  Condition({required this.weatherDescription, required this.weatherIcon});

  factory Condition.fromJson(Map<String,dynamic> json)=>_$ConditionFromJson(json);
  Map<String,dynamic> toJson()=>_$ConditionToJson(this);
}

