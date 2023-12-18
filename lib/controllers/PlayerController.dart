import 'package:samba_client/models/player.dart';

import '../exports/exports.dart';
import '../services/player_service.dart';

class PlayerController with ChangeNotifier {
  List<Message> _players = [];
  List<Message> get players => _players;
  void fetchPlayers(String teamId) {
    PlayerService().getPlayers(teamId).then((value) {
      _players = value;
      notifyListeners();
    });
  }
}
