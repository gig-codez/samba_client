import '../exports/exports.dart';
import '../models/fixture.dart';
import '../models/league.dart';
import '../models/match_date.dart';
import '../services/fixture_service.dart';
import '../services/league_service.dart';
import '../services/match_date_service.dart';

class DataController with ChangeNotifier {
  // match id
  String _matchId = "";
  String get matchId => _matchId;
  set matchId(String id) {
    _matchId = id;
    _fixtureData =
        fixtures.where((element) => element.fixtureDate == id).toList();
    // notifyListeners();
  }

// fetch fixtures
  List<Datum> _fixtures = [];
  List<Datum> get fixtures => _fixtures;
  void fetchFixtures() {
    FixtureService.getFixtures().then((value) {
      _fixtures = value;
      notifyListeners();
    });
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

  void fetchFixtureData() {
    _fixtureData =
        fixtures.where((element) => element.fixtureDate == matchId).toList();
  }

  void fetchLeagueData() {
    try {
      LeagueService.getLeague().then((value) {
        _leagueData = value.where((element) => element.id == leagueId).first;
        notifyListeners();
      });
    } on FormatException catch (_, e) {
      e.toString();
    }
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

  // constructor invocation
  DataController() {
    // fetch match dates
    fetchMatchDates();
    // fetch league data
    fetchLeagueData();
    // fetch blogs
    _fetchBlogs();
    // fetch fixture data
    fetchFixtureData();
    // fetch fixtures
    fetchFixtures();
  }
}
