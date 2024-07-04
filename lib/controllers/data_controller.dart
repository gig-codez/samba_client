import 'dart:developer';

import '../exports/exports.dart';
import '../models/fixture.dart';
import '../models/league.dart';
import '../models/match_date.dart';
import '../services/fixture_service.dart';
import '../services/league_service.dart';
import '../services/match_date_service.dart';

class DataController with ChangeNotifier {
  // leagueId
  // String _leagueId = "";

  void setLeagueId(String id) {
    fetchMatchDates();
    // notifyListeners();
  }

  List<MatchDateModel> _matchDates = [];
  List<MatchDateModel> get matchDates => _matchDates;

  // fixture data
  List<Datum> _fixtureData = [];
  List<Datum> get fixtureData => _fixtureData;
// league data
  late Message _leagueData;
  Message get leagueData => _leagueData;
  void fetchMatchDates() {
    MatchDateService.getMatchDates(leagueId).then((value) {
      _matchDates = value;
      notifyListeners();
    });
  }

  List<Datum> _fixtures = [];
  List<Datum> get fixtures => _fixtures;

  String _matchId = "";
  String get matchId => _matchId;
  set matchId(String id) {
    _matchId = id;
    _fixtureData =
        fixtures.where((element) => element.fixtureDate == id).toList();
    fetchFixtureData();
    // notifyListeners();
  }

  // loading match data
  bool _loading = true;
  bool get loading => _loading;

  void fetchFixtureData() {
    _fixtureData =
        fixtures.where((element) => element.fixtureDate == matchId).toList();

    // _loading = true;
    // FixtureService.getRunningFixtures(leagueId, matchId).then((value) {
    //   _fixtureData = value;
    //   _loading = false;
    // notifyListeners();
    // });
  }

  void fetchLeagueData() {
    try {
      LeagueService.getLeague().then((value) {
        _leagueData = value.where((element) => element.id == leagueId).first;
        notifyListeners();
      });
    } on FormatException catch (_, e) {
      debugPrint(_.message);
    }
  }

  // function to load league fixtures
  void loadFixtures() {
    FixtureService.getFixtures().then((value) {
      _fixtures = value;
      log("League fixtures loaded");
      notifyListeners();
    });
  }

  DataController() {
    // fetch pre-data
    fetchLeagueData();
    // fetch match dates
    fetchMatchDates();
    // fetch fixtures
    loadFixtures();
  }

  // live fixture time
  Map<String, dynamic> _liveFixtureTime = {};
  Map<String, dynamic> get liveFixtureTime => _liveFixtureTime;
  set liveFixtureTime(Map<String, dynamic> time) {
    _liveFixtureTime = time;
    notifyListeners();
  }

  // blogs
  List<BlogsModel> _blogs = [];
  List<BlogsModel> get blogs {
    _fetchBlogs();
    return _blogs;
  }

  void _fetchBlogs() {
    BlogService.getBlogs(leagueId).then((value) {
      _blogs = value;
      notifyListeners();
    });
  }
}
