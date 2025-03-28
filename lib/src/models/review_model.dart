// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';



List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(json.decode(str).map((x) => ReviewModel.fromJson(x)));

String reviewModelToJson(List<ReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel {
  String id;
  String author;
  String email;
  String content;
  String rating;
  String avatar;
  DateTime  date;

  ReviewModel({
    this.id,
    this.author,
    this.email,
    this.content,
    this.rating,
    this.avatar,
    this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    author: json["author"],
    email: json["email"],
    content: json["content"],
    rating: (json["rating"] == null || json["rating"] == '') ? '0' : json["rating"],
    avatar: json["avatar"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "email": email,
    "content": content,
    "avatar": avatar,
  };
}