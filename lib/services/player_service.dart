import 'dart:convert';
import 'dart:io';

import '../exports/exports.dart';
import '../models/handball_model.dart';
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

  static Future<List<Message>> getTopScorers() async {
    try {
      // print("teamId => $teamId");
      Response response = await Client().get(
        Uri.parse(Apis.scorers + leagueId),
      );
      if (response.statusCode == 200) {
        // print(response.body);
        // return json.decode(response.body);
        return playersModelFromJson(response.body).message;
      } else {
        // print("Error => ${response.body}");
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  static Future<List<Message>> getTopCleanSheets() async {
    try {
      // print("teamId => $teamId");
      Response response = await Client().get(
        Uri.parse(Apis.cleanSheets + leagueId),
      );
      if (response.statusCode == 200) {
        // print(response.body);
        // return json.decode(response.body);
        return playersModelFromJson(response.body).message;
      } else {
        // print("Error => ${response.body}");
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  static Future<List<Message>> getTopAssists() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topAssists + leagueId),
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

// handball stats
  /**  "TO": 0,
    "GLS": 0,
    "AST": 0,
    "MX": 0,
    "BLK": 0,
    "STE": 0,
    "KS": 0,
    "TWO_MIN": 0,
    "RC": 0,
     */
  static Future<List<HandBallPlayerModel>> getTopTO() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topTO + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get gls
  static Future<List<HandBallPlayerModel>> getTopGLS() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topGLS + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get ast
  static Future<List<HandBallPlayerModel>> getTopAST() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topAST + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get mx
  static Future<List<HandBallPlayerModel>> getTopMX() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topMX + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get blk
  static Future<List<HandBallPlayerModel>> getTopBLK() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topBLK + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get ste
  static Future<List<HandBallPlayerModel>> getTopSTE() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topSTE + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get ks
  static Future<List<HandBallPlayerModel>> getTopKS() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topKS + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get two min
  static Future<List<Message>> getTopTWO_MIN() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topTWO_MIN + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }

  // get rc
  static Future<List<Message>> getTopRC() async {
    try {
      Response response = await Client().get(
        Uri.parse(Apis.topRC + leagueId),
      );
      if (response.statusCode == 200) {
        return handBallPlayerModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message']);
      }
    } on ClientException catch (_, e) {
      return Future.error("Error fetching data");
    }
  }
}
