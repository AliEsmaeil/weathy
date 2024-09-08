
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FootballMatches.g.dart';

// football matches model : just contains list of matchs

@HiveType(typeId: 6)
@JsonSerializable()
class FootballMatches extends HiveObject{

  @HiveField(0)
  @JsonKey(name: 'football')
  List<Match> matches;

  FootballMatches(this.matches);

  factory FootballMatches.fromJson(Map<String,dynamic> json)=>_$FootballMatchesFromJson(json);

}

//match model : contain some info about the match the country, stadium, teams ..etc.
@HiveType(typeId: 5 )
@JsonSerializable()
class Match{
  @HiveField(0)
  String stadium;

  @HiveField(1)
  String country;

  @HiveField(2)
  String tournament;

  @HiveField(3)
  String start;

  @HiveField(4)
  String match;

  Match(this.stadium, this.country, this.tournament, this.start, this.match);

  factory Match.fromJson(Map<String,dynamic> json)=> _$MatchFromJson(json);
}