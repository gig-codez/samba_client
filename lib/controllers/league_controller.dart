import '/exports/exports.dart';

class LeagueController with ChangeNotifier {
  List<ILeagueController> leagues = [
    ILeagueController.ugandaHandballMen(),
    ILeagueController.ugandaHandballLadies(),
  ];
  // function to switch leagues
  void switchLeague(ILeagueController league) {
    leagueId = league.leagueId;
    // leagueLogo = league.leagueLogo;
    // appTitle = league.appTitle;
    notifyListeners();
  }
}

// leagues interface
class ILeagueController {
  final String leagueLogo;
  final String appTitle;
  final String leagueId;
  const ILeagueController({
    required this.leagueLogo,
    required this.appTitle,
    required this.leagueId,
  });
  // factory menthods
  factory ILeagueController.ugandaHandballMen() {
    return const ILeagueController(
      leagueLogo: "assets/leagues/uganda_handball.png",
      appTitle: "UGANDA HANDBALL SUPER LEAGUE",
      leagueId: "667a7d9769692a12fae2c16b",
    );
  }
  // factory method for ladies
  factory ILeagueController.ugandaHandballLadies() {
    return const ILeagueController(
      leagueLogo: "assets/leagues/uganda_handball.png",
      appTitle: "(W) UGANDA HANDBALL SUPER LEAGUE",
      leagueId: "667a7dfe69692a12fae2c2a9",
    );
  }
}
