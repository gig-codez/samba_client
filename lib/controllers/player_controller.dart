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
  void fetchScorers() {
    PlayerService.getTopScorers().then((value) {
      _topScorers = value;
      notifyListeners();

    });
  }
  // function to fetch top assists
  void fetchAssists() {
    PlayerService.getTopAssists().then((value) {
      _topAssists = value;
      notifyListeners();
    });
  }
  // function to fetch clean sheets
  void fetchCleanSheets() {
    PlayerService.getTopCleanSheets().then((value) {
      _topCleanSheets = value;
      notifyListeners();
    });
  }
}
