import 'dart:convert';

import '/extensions/datetime_extension.dart';

List<BlogsModel> blogsModelFromJson(String str) =>
    List<BlogsModel>.from(json.decode(str).map((x) => BlogsModel.fromJson(x)));

String blogsModelToJson(List<BlogsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogsModel {
  final String id;
  final String league;
  final String title;
  final String content;
  final String summary;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int v;

  BlogsModel({
    required this.id,
    required this.league,
    required this.title,
    required this.content,
    required this.summary,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        id: json["_id"],
        league: json["league"],
        title: json["title"],
        content: json["content"],
        summary: json["summary"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]).timeAgo,
        updatedAt: DateTime.parse(json["updatedAt"]).timeAgo,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "league": league,
        "title": title,
        "content": content,
        "summary": summary,
        "image": image,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
