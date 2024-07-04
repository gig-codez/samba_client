import 'dart:convert';

import '../exports/exports.dart';
import '../models/fixture.dart';

class FixtureService {
  static Future<List<Datum>> getFixtures() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchFixtures + leagueId),
      );
      if (response.statusCode == 200) {
        Client().close();
        return fixtureModelFromJson(response.body).data;
      } else {
        Client().close();
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (e) {
      return Future.error(e.message);
    }
  }

  static Future<List<Datum>> getRunningFixtures(String matchId) async {
    try {
      Response response = await Client().get(
        Uri.parse("${Apis.runningFixture}$leagueId/$matchId"),
      );
      // print("${Apis.runningFixture}$leagueId/$matchId");
      if (response.statusCode == 200) {
        Client().close();
        return fixtureModelFromJson(response.body).data;
      } else {
        Client().close();
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      return Future.error(e.message);
    } on FormatException catch (e) {
      debugPrint(e.message);
      return Future.error(e.message);
    }
  }
}
