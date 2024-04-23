import '/models/player.dart';

import '../exports/exports.dart';
import '../services/player_service.dart';

class PlayerController with ChangeNotifier {
  List<Message> _players = [];
  List<Message> _topScorers = [];
  List<Message> _topAssists = [];
  List<Message> _topCleanSheets = [];
  List<Message> get players => _players;
  List<Message> get topScorers => _topScorers;
  List<Message> get topAssists => _topAssists;
  List<Message> get topCleanSheets => _topCleanSheets;
  void fetchPlayers(String teamId) {
    PlayerService().getPlayers(teamId).then((value) {
      _players = value;
      notifyListeners();
    });
  }

  // function to fetch top scorers
  void fetchScorers(String teamId) {
    PlayerService.getTopScorers(teamId).then((value) {
      _topScorers = value;
      notifyListeners();

    });
  }
  // function to fetch top assists
  void fetchAssists(String teamId) {
    PlayerService.getTopAssists(teamId).then((value) {
      _topAssists = value;
      notifyListeners();
    });
  }
  // function to fetch clean sheets
  void fetchCleanSheets(String teamId) {
    PlayerService.getTopCleanSheets(teamId).then((value) {
      _topCleanSheets = value;
      notifyListeners();
    });
  }
}
