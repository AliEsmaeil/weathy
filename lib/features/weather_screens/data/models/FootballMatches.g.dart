// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FootballMatches.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FootballMatchesAdapter extends TypeAdapter<FootballMatches> {
  @override
  final int typeId = 6;

  @override
  FootballMatches read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FootballMatches(
      (fields[0] as List).cast<Match>(),
    );
  }

  @override
  void write(BinaryWriter writer, FootballMatches obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.matches);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FootballMatchesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MatchAdapter extends TypeAdapter<Match> {
  @override
  final int typeId = 5;

  @override
  Match read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Match(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Match obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.stadium)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.tournament)
      ..writeByte(3)
      ..write(obj.start)
      ..writeByte(4)
      ..write(obj.match);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FootballMatches _$FootballMatchesFromJson(Map<String, dynamic> json) =>
    FootballMatches(
      (json['football'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FootballMatchesToJson(FootballMatches instance) =>
    <String, dynamic>{
      'football': instance.matches,
    };

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
      json['stadium'] as String,
      json['country'] as String,
      json['tournament'] as String,
      json['start'] as String,
      json['match'] as String,
    );

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
      'stadium': instance.stadium,
      'country': instance.country,
      'tournament': instance.tournament,
      'start': instance.start,
      'match': instance.match,
    };
