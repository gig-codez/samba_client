import '../models/handball_model.dart';
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

  // function to work on transfers
  List<dynamic> _transfers = [];
  List<dynamic> get transfers {
    _fetchTransfers();
    return _transfers;
  }

  void _fetchTransfers() {
    PlayerService.getTransferredPlayers(leagueId).then((data) {
      _transfers = data;
      notifyListeners();
    });
  }

  // handball stats
  /**
   * "TO": 0,
        "GLS": 0,
        "AST": 0,
        "MX": 0,
        "BLK": 0,
        "STE": 0,
        "KS": 0,
        "TWO_MIN": 0,
        "RC": 0,
   */
  List<HandBallPlayerModel> _topTO = [];
  List<HandBallPlayerModel> get topTO => _topTO;
  void fetchTO() {
    PlayerService.getTopTO().then((value) {
      _topTO = value;
      notifyListeners();
    });
  }

  // fetch gls
  List<HandBallPlayerModel> _topGLS = [];
  List<HandBallPlayerModel> get topGLS => _topGLS;
  void fetchGLS() {
    PlayerService.getTopGLS().then((value) {
      _topGLS = value;
      notifyListeners();
    });
  }

  // fetch ast
  List<HandBallPlayerModel> _topAST = [];
  List<HandBallPlayerModel> get topAST => _topAST;
  void fetchAST() {
    PlayerService.getTopAST().then((value) {
      _topAST = value;
      notifyListeners();
    });
  }

  // fetch mx
  List<HandBallPlayerModel> _topMX = [];
  List<HandBallPlayerModel> get topMX => _topMX;
  void fetchMX() {
    PlayerService.getTopMX().then((value) {
      _topMX = value;
      notifyListeners();
    });
  }

  // fetch blk
  List<HandBallPlayerModel> _topBLK = [];
  List<HandBallPlayerModel> get topBLK => _topBLK;
  void fetchBLK() {
    PlayerService.getTopBLK().then((value) {
      _topBLK = value;
      notifyListeners();
    });
  }

  // fetch ste
  List<HandBallPlayerModel> _topSTE = [];
  List<HandBallPlayerModel> get topSTE => _topSTE;
  void fetchSTE() {
    PlayerService.getTopSTE().then((value) {
      _topSTE = value;
      notifyListeners();
    });
  }

  // fetch ks
  List<HandBallPlayerModel> _topKS = [];
  List<HandBallPlayerModel> get topKS => _topKS;
  void fetchKS() {
    PlayerService.getTopKS().then((value) {
      _topKS = value;
      notifyListeners();
    });
  }

  // fetch two min
  List<HandBallPlayerModel> _topTwoMin = [];
  List<HandBallPlayerModel> get topTwoMin => _topTwoMin;
  void fetchTwoMin() {
    PlayerService.getTopTWO_MIN().then((value) {
      _topTwoMin = value;
      notifyListeners();
    });
  }

  // fetch rc
  List<HandBallPlayerModel> _topRC = [];
  List<HandBallPlayerModel> get topRC => _topRC;
  void fetchRC() {
    PlayerService.getTopRC().then((value) {
      _topRC = value;
      notifyListeners();
    });
  }
}
