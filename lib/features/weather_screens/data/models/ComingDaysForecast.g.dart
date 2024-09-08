// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ComingDaysForecast.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComingDaysForecastAdapter extends TypeAdapter<ComingDaysForecast> {
  @override
  final int typeId = 11;

  @override
  ComingDaysForecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComingDaysForecast(
      (fields[0] as List).cast<DayForecast>(),
    );
  }

  @override
  void write(BinaryWriter writer, ComingDaysForecast obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.comingDaysForecast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComingDaysForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComingDaysForecast _$ComingDaysForecastFromJson(Map<String, dynamic> json) =>
    ComingDaysForecast(
      (json['forecastday'] as List<dynamic>)
          .map((e) => DayForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComingDaysForecastToJson(ComingDaysForecast instance) =>
    <String, dynamic>{
      'forecastday': instance.comingDaysForecast,
    };
