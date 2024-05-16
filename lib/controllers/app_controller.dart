import '/exports/exports.dart';

class AppController with ChangeNotifier {
  // dark mode
  int _appTheme = 1;
  int get appTheme {
    _setAppTheme();
    return _appTheme;
    }
  void _setAppTheme() {
    StorageSerivce.retriveData("theme").then((theme) {
      _appTheme = theme ?? 1;
      notifyListeners();
    });
  }

  // heamTeam data
  Map<String, dynamic> _homeTeamData = {};
  Map<String, dynamic> get homeTeamData => _homeTeamData;
  set homeTeamData(Map<String, dynamic> data) {
    print("Home Data: $data");
    _homeTeamData = data;
    notifyListeners();
  }

  // awayTeam data
  Map<String, dynamic> _awayTeamData = {};
  Map<String, dynamic> get awayTeamData => _awayTeamData;
  set awayTeamData(Map<String, dynamic> data) {
    _awayTeamData = data;
    print("Away Data: $data");
    notifyListeners();
  }

// match date
  Map<String, dynamic> _matchDateId = {};
  Map<String, dynamic> get matchDateId => _matchDateId;
  set matchDateId(Map<String, dynamic> id) {
    _matchDateId = id;
    notifyListeners();
  }
}
