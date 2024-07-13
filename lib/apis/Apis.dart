// import "package:http/retry.dart";
// import "package:http/http.dart" as http;

// ignore_for_file: non_constant_identifier_names, slash_for_doc_comments

class Apis {
  static String apiUrl = "http://45.10.160.145:3000/";
  // Socket.IO server url

  // players routes
  static String fetchPlayers = "${apiUrl}player/players/";
  static String createPlayer = "${apiUrl}player/addplayer";
  static String fetchSinglePlayer = "${apiUrl}player/players/";
  static String updatePlayer = "${apiUrl}player/update/";
  static String deletePlayer = "${apiUrl}player/delete/";
  static String transferredPlayers = "${apiUrl}player/";
  // league routes
  static String fetchLeagues = "${apiUrl}league/leagues";
  static String fetchSingleLeague = "${apiUrl}league/leagues/";
  static String createLeague = "${apiUrl}league/addleague";
  static String updateLeague = "${apiUrl}update/league/";
  // teams
  static String fetchTeams = "${apiUrl}team/teams/";
  static String createTeam = "${apiUrl}team/addteam";
  static String fetchSingleTeam = "${apiUrl}team/singleteam/";
  static String updateTeam = "${apiUrl}team/update/";
  static String deleteTeam = "${apiUrl}team/delete/";
  // fixtures
  static String fetchFixtures = "${apiUrl}fixture/";
  static String createFixture = "${apiUrl}fixture/addfixture";
  static String fetchSingleFixture = "${apiUrl}fixture/";
  static String updateFixture = "${apiUrl}fixture/fixture/";
  static String deleteFixture = "${apiUrl}fixture/delete/";
  static String runningFixture = "${apiUrl}fixture/";
  // reports
  static String addResult = "${apiUrl}result/addresult";
  static String fetchResults = "${apiUrl}result/results";
  static String fetchSingleResult = "${apiUrl}result/results/";
// deviceId
  static String saveDeviceId = "${apiUrl}notify/saveDeviceId";
  // match dates
  static String addMatchDates = "${apiUrl}match/add";
  static String getMatchDates = "${apiUrl}match/get/";
  static String deleteMatchDates = "${apiUrl}match/delete/";
  static String updateMatchDates = "${apiUrl}match/update/";

  // table routes
  static String getTableData = "${apiUrl}table/";
  static String updateTableData = "${apiUrl}table/update/";
  static String deleteTableData = "${apiUrl}table/delete/";
  static String addTableData = "${apiUrl}table/add";
  // stats
  static String scorers = "${apiUrl}player/topScorers/";
  static String topAssists = "${apiUrl}player/topAssists/";
  static String cleanSheets = "${apiUrl}player/cleanSheets/";

  // blogs
  static String blogs = "${apiUrl}blogs";
  // update
  static String update = "${apiUrl}update";
  // hand ball stats
  static String topTO = "${apiUrl}handBall/TO/";
  static String topGLS = "${apiUrl}handBall/GLS/";
  static String topAST = "${apiUrl}handBall/AST/";
  static String topMX = "${apiUrl}handBall/MX/";
  static String topBLK = "${apiUrl}handBall/BLK/";
  static String topSTE = "${apiUrl}handBall/STE/";
  static String topKS = "${apiUrl}handBall/KS/";
  static String topTWO_MIN = "${apiUrl}handBall/TWO_MIN/";
  static String topRC = "${apiUrl}handBall/RC/";
}
