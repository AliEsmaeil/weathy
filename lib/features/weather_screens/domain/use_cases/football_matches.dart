
import '../../data/models/FootballMatches.dart';
import '../repositories/football_matches.dart';

class FootballMatchesUseCase {
  FootballMatchesBaseRepo repo;

  FootballMatchesUseCase(this.repo);

  Future<FootballMatches> getMatches({required String cityName}) async =>
      await repo.getFootballMatches(cityName: cityName);
}
