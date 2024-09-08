
import '../../data/models/FootballMatches.dart';

abstract class FootballMatchesBaseRepo{

  Future<FootballMatches> getFootballMatches({required String cityName});

}