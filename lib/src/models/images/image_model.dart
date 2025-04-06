// To parse this JSON data, do
//
//     final picture = pictureFromJson(jsonString);

import 'dart:convert';

Picture pictureFromJson(String str) => Picture.fromJson(json.decode(str));

String pictureToJson(Picture data) => json.encode(data.toJson());

class Picture {
  int id;
  String src;
  String name;
  String alt;
  int position;

  Picture({
    required this.id,
    required this.src,
    required this.name,
    required this.alt,
    required this.position,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    id: json["id"],
    src: (json["src"] == null || json["src"] == false) ? null : json["src"],
    name: json["name"],
    alt: json["alt"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "src": src,
    "name": name,
    "alt": alt,
    "position": position,
  };
}
