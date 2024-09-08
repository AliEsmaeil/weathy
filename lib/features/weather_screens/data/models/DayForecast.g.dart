// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DayForecast.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayForecastAdapter extends TypeAdapter<DayForecast> {
  @override
  final int typeId = 10;

  @override
  DayForecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayForecast(
      fields[1] as Day,
      fields[2] as Astronomy,
      (fields[3] as List).cast<Hour>(),
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DayForecast obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.astronomy)
      ..writeByte(3)
      ..write(obj.hoursOverDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 9;

  @override
  Day read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Day(
      fields[0] as num,
      fields[1] as num,
      fields[2] as num?,
      fields[3] as num?,
      fields[4] as Condition,
    );
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.maxTemp)
      ..writeByte(1)
      ..write(obj.minTemp)
      ..writeByte(2)
      ..write(obj.rainChance)
      ..writeByte(3)
      ..write(obj.snowChance)
      ..writeByte(4)
      ..write(obj.condition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AstronomyAdapter extends TypeAdapter<Astronomy> {
  @override
  final int typeId = 8;

  @override
  Astronomy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Astronomy(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Astronomy obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sunRise)
      ..writeByte(1)
      ..write(obj.sunSet)
      ..writeByte(2)
      ..write(obj.moonRise)
      ..writeByte(3)
      ..write(obj.moonSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AstronomyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HourAdapter extends TypeAdapter<Hour> {
  @override
  final int typeId = 7;

  @override
  Hour read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hour(
      fields[1] as String,
      fields[2] as num,
      fields[3] as num,
      fields[4] as num,
      fields[5] as num,
      fields[6] as num,
      fields[8] as num,
      fields[9] as num,
      fields[10] as num,
      fields[11] as num,
      fields[0] as Condition,
    );
  }

  @override
  void write(BinaryWriter writer, Hour obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.condition)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.temp)
      ..writeByte(3)
      ..write(obj.windSpeed)
      ..writeByte(4)
      ..write(obj.pressure)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.clouds)
      ..writeByte(8)
      ..write(obj.feelsLike)
      ..writeByte(9)
      ..write(obj.rainChance)
      ..writeByte(10)
      ..write(obj.snowChance)
      ..writeByte(11)
      ..write(obj.visionPerKiloMeter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayForecast _$DayForecastFromJson(Map<String, dynamic> json) => DayForecast(
      Day.fromJson(json['day'] as Map<String, dynamic>),
      Astronomy.fromJson(json['astro'] as Map<String, dynamic>),
      (json['hour'] as List<dynamic>)
          .map((e) => Hour.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['date'] as String,
    );

Map<String, dynamic> _$DayForecastToJson(DayForecast instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day': instance.day,
      'astro': instance.astronomy,
      'hour': instance.hoursOverDay,
    };

Day _$DayFromJson(Map<String, dynamic> json) => Day(
      json['maxtemp_c'] as num,
      json['mintemp_c'] as num,
      json['daily_chance_of_rain'] as num?,
      json['daily_chance_of_snow'] as num?,
      Condition.fromJson(json['condition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'maxtemp_c': instance.maxTemp,
      'mintemp_c': instance.minTemp,
      'daily_chance_of_rain': instance.rainChance,
      'daily_chance_of_snow': instance.snowChance,
      'condition': instance.condition,
    };

Astronomy _$AstronomyFromJson(Map<String, dynamic> json) => Astronomy(
      json['sunrise'] as String,
      json['sunset'] as String,
      json['moonrise'] as String,
      json['moonset'] as String,
    );

Map<String, dynamic> _$AstronomyToJson(Astronomy instance) => <String, dynamic>{
      'sunrise': instance.sunRise,
      'sunset': instance.sunSet,
      'moonrise': instance.moonRise,
      'moonset': instance.moonSet,
    };

Hour _$HourFromJson(Map<String, dynamic> json) => Hour(
      json['time'] as String,
      json['temp_c'] as num,
      json['wind_kph'] as num,
      json['pressure_in'] as num,
      json['humidity'] as num,
      json['cloud'] as num,
      json['feelslike_c'] as num,
      json['chance_of_rain'] as num,
      json['chance_of_snow'] as num,
      json['vis_km'] as num,
      Condition.fromJson(json['condition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HourToJson(Hour instance) => <String, dynamic>{
      'condition': instance.condition,
      'time': instance.time,
      'temp_c': instance.temp,
      'wind_kph': instance.windSpeed,
      'pressure_in': instance.pressure,
      'humidity': instance.humidity,
      'cloud': instance.clouds,
      'feelslike_c': instance.feelsLike,
      'chance_of_rain': instance.rainChance,
      'chance_of_snow': instance.snowChance,
      'vis_km': instance.visionPerKiloMeter,
    };
