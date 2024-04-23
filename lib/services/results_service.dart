import 'dart:convert';

import '/exports/exports.dart';
import '/models/result.dart';

class ResultService {
  static Future<List<Datum>> getResult() async {
  
    try {
      Response response = await Client().get(
        Uri.parse(Apis.fetchResults),
      );
      if (response.statusCode == 200) {
      
       return artworkModelFromJson(response.body).data;
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
      return Future.error(e.message);
    }

  }

  static void updateResult(String leagueId, String teamId) async {
    try {
      Response response = await Client().put(
        Uri.parse(Apis.fetchResults),
      );
      if (response.statusCode == 200) {
        showMessage(msg: "Fixture updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Failed to update fixture.", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }
}
