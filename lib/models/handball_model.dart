import 'dart:convert';

List<HandBallPlayerModel> handBallPlayerModelFromJson(String str) =>
    List<HandBallPlayerModel>.from(
        json.decode(str).map((x) => HandBallPlayerModel.fromJson(x)));

String handBallPlayerModelToJson(List<HandBallPlayerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HandBallPlayerModel {
  final String id;
  final String league;
  final Player player;
  final String shirtNo;
  final int to;
  final int gls;
  final int ast;
  final int mx;
  final int blk;
  final int ste;
  final int ks;
  final int twoMin;
  final int rc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  HandBallPlayerModel({
    required this.id,
    required this.league,
    required this.player,
    required this.shirtNo,
    required this.to,
    required this.gls,
    required this.ast,
    required this.mx,
    required this.blk,
    required this.ste,
    required this.ks,
    required this.twoMin,
    required this.rc,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory HandBallPlayerModel.fromJson(Map<String, dynamic> json) =>
      HandBallPlayerModel(
        id: json["_id"],
        league: json["league"],
        player: Player.fromJson(json["player"]),
        shirtNo: json["shirtNo"],
        to: json["TO"],
        gls: json["GLS"],
        ast: json["AST"],
        mx: json["MX"],
        blk: json["BLK"],
        ste: json["STE"],
        ks: json["KS"],
        twoMin: json["TWO_MIN"],
        rc: json["RC"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league,
        "player": player.toJson(),
        "shirtNo": shirtNo,
        "TO": to,
        "GLS": gls,
        "AST": ast,
        "MX": mx,
        "BLK": blk,
        "STE": ste,
        "KS": ks,
        "TWO_MIN": twoMin,
        "RC": rc,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Player {
  final String id;
  final String name;
  final String team;
  final bool transferred;
  final String soldOut;
  final String position;
  final int goal;
  final int assist;
  final int cleanSheet;
  final int yellow;
  final int red;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Player({
    required this.id,
    required this.name,
    required this.team,
    required this.transferred,
    required this.soldOut,
    required this.position,
    required this.goal,
    required this.assist,
    required this.cleanSheet,
    required this.yellow,
    required this.red,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["_id"],
        name: json["name"],
        team: json["team"],
        transferred: json["transferred"],
        soldOut: json["sold_out"],
        position: json["position"],
        goal: json["goal"],
        assist: json["assist"],
        cleanSheet: json["clean_sheet"],
        yellow: json["yellow"],
        red: json["red"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "team": team,
        "transferred": transferred,
        "sold_out": soldOut,
        "position": position,
        "goal": goal,
        "assist": assist,
        "clean_sheet": cleanSheet,
        "yellow": yellow,
        "red": red,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
