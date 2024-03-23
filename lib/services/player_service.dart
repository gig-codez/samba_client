import 'dart:convert';
import 'dart:io';

import '../exports/exports.dart';
import '../models/player.dart';

class PlayerService {
//  get all players
  Future<List<Message>> getPlayers(String teamId) async {
    String res = "";
    try {
      final response = await Client().get(
        Uri.parse(Apis.fetchPlayers + teamId),
      );
      if (response.statusCode == 200) {
        res = response.body;
        return playersModelFromJson(res).message;
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (e) {
      return Future.error(e.message);
    } on SocketException catch (e) {
      return Future.error(e.message);
    } on HttpException catch (e) {
      return Future.error(e.message);
    }
  }

  static Future<List<Message>> getTransferredPlayers(String teamId) async {
    String res = "";
    try {
      final response = await Client().get(
        Uri.parse("${Apis.transferredPlayers}$teamId/transferred"),
      );
      if (response.statusCode == 200) {
        res = response.body;
        return playersModelFromJson(res).message;
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } on ClientException catch (e) {
      return Future.error(e.message);
    } on SocketException catch (e) {
      return Future.error(e.message);
    } on HttpException catch (e) {
      return Future.error(e.message);
    }
  }

// delete player
  static void deletePlayer(String playerId) async {
    try {
      Response response =
          await Client().delete(Uri.parse(Apis.deletePlayer + playerId));
      if (response.statusCode == 200) {
        Routes.popPage();
        showMessage(msg: "Player deleted successfully", color: Colors.green);
      } else {
        Routes.popPage();
        showMessage(
            msg: "Error deleting player => ${response.reasonPhrase}",
            color: Colors.red);
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // function to create a player
  static void createPlayer(Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().post(Uri.parse(Apis.createPlayer), body: data);

      if (response.statusCode == 200) {
        showMessage(msg: "Done..");
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  // edit players
  static void updatePlayer(String id, Map<String, dynamic> data) async {
    try {
      Response response =
          await Client().put(Uri.parse(Apis.updatePlayer + id), body: data);

      if (response.statusCode == 200) {
        showMessage(msg: "Player updated successfully", color: Colors.green);
        Routes.popPage();
      } else {
        showMessage(msg: "Player update failed", color: Colors.red);
        Routes.popPage();
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    }
  }

  static Future<List<Message>> getTopScorers(String teamId) async {
    try {
      print("teamId => $teamId");
      Response response = await Client().get(
        Uri.parse(Apis.scorers + teamId),
      );
      if (response.statusCode == 200) {
        print(response.body);
        return playersModelFromJson(response.body).message;
      } else {
         print("Error => ${response.body}");
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  static Future<List<Message>> getTopAssists(String teamId) async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topAssists + teamId),
      );
      if (response.statusCode == 200) {
        return playersModelFromJson(response.body).message;
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }
}
