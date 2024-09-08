
import '../../domain/repositories/football_matches.dart';
import '../data_source/football_matches_data_source.dart';
import '../models/FootballMatches.dart';

class FootballMatchesRepo extends FootballMatchesBaseRepo{

  FootballMatchesBaseDataSource dataSource;

  FootballMatchesRepo(this.dataSource);

  @override
  Future<FootballMatches> getFootballMatches({required String cityName})async {

    return await dataSource.getComingMatches(cityName: cityName);
  }

}