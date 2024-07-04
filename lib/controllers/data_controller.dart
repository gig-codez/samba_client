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
  }

  // fixtures
  List<Datum> _fixtures = [];
  List<Datum> get fixtures => _fixtures;
  // function to fetch all fxitures
  void fetchFixtures() {
    FixtureService.getFixtures(leagueId).then((fixtures) {
      _fixtures = fixtures;
      notifyListeners();
    });
  }

  void setLeagueId(String id) {
    fetchMatchDates(id);
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
  void fetchMatchDates(String leagueId) {
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
      debugPrint(_.message);
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
    fetchFixtures();
    fetchLeagueData();
    // fetch blogs
    _fetchBlogs();
    // fetch fixtures
    fetchFixtures();
  }
}
