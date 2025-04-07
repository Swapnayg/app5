// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

class Category {
  int id;
  String name;
  String description;
  int parent;
  int count;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.parent,
    required this.count,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    image: json["image"] == null || json["image"] == false ? '' : json["image"],
  );
}