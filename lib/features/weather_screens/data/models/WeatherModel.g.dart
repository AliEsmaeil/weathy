// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherAdapter extends TypeAdapter<CurrentWeather> {
  @override
  final int typeId = 4;

  @override
  CurrentWeather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeather(
      current: fields[1] as Current,
      location: fields[0] as Location,
    )..constructedViaCitName = fields[2] as bool?;
  }

  @override
  void write(BinaryWriter writer, CurrentWeather obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.current)
      ..writeByte(2)
      ..write(obj.constructedViaCitName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 3;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      cityName: fields[0] as String,
      country: fields[1] as String,
      latitude: fields[2] as num,
      longitude: fields[3] as num,
      localTime: fields[4] as String,
    )
      ..administrativeArea = fields[5] as String?
      ..subAdministrativeArea = fields[6] as String?
      ..locality = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.localTime)
      ..writeByte(5)
      ..write(obj.administrativeArea)
      ..writeByte(6)
      ..write(obj.subAdministrativeArea)
      ..writeByte(7)
      ..write(obj.locality);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurrentAdapter extends TypeAdapter<Current> {
  @override
  final int typeId = 2;

  @override
  Current read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Current(
      temperature: fields[1] as num,
      windSpeed: fields[3] as num,
      pressure: fields[4] as num,
      humidity: fields[5] as num,
      clouds: fields[6] as num,
      feelsLike: fields[7] as num,
      visionPerKiloMeter: fields[2] as num,
      condition: fields[0] as Condition,
    );
  }

  @override
  void write(BinaryWriter writer, Current obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.condition)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.visionPerKiloMeter)
      ..writeByte(3)
      ..write(obj.windSpeed)
      ..writeByte(4)
      ..write(obj.pressure)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.clouds)
      ..writeByte(7)
      ..write(obj.feelsLike);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConditionAdapter extends TypeAdapter<Condition> {
  @override
  final int typeId = 1;

  @override
  Condition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Condition(
      weatherDescription: fields[0] as String,
      weatherIcon: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Condition obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.weatherDescription)
      ..writeByte(1)
      ..write(obj.weatherIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) =>
    CurrentWeather(
      current: Current.fromJson(json['current'] as Map<String, dynamic>),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    )..constructedViaCitName = json['constructedViaCitName'] as bool?;

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
      'constructedViaCitName': instance.constructedViaCitName,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      cityName: json['name'] as String,
      country: json['country'] as String,
      latitude: json['lat'] as num,
      longitude: json['lon'] as num,
      localTime: json['localtime'] as String,
    )
      ..administrativeArea = json['administrativeArea'] as String?
      ..subAdministrativeArea = json['subAdministrativeArea'] as String?
      ..locality = json['locality'] as String?;

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.cityName,
      'country': instance.country,
      'lat': instance.latitude,
      'lon': instance.longitude,
      'localtime': instance.localTime,
      'administrativeArea': instance.administrativeArea,
      'subAdministrativeArea': instance.subAdministrativeArea,
      'locality': instance.locality,
    };

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      temperature: json['temp_c'] as num,
      windSpeed: json['wind_kph'] as num,
      pressure: json['pressure_in'] as num,
      humidity: json['humidity'] as num,
      clouds: json['cloud'] as num,
      feelsLike: json['feelslike_c'] as num,
      visionPerKiloMeter: json['vis_km'] as num,
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentToJson(Current instance) => <String, dynamic>{
      'condition': instance.condition,
      'temp_c': instance.temperature,
      'vis_km': instance.visionPerKiloMeter,
      'wind_kph': instance.windSpeed,
      'pressure_in': instance.pressure,
      'humidity': instance.humidity,
      'cloud': instance.clouds,
      'feelslike_c': instance.feelsLike,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
      weatherDescription: json['text'] as String,
      weatherIcon: json['icon'] as String,
    );

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'text': instance.weatherDescription,
      'icon': instance.weatherIcon,
    };
