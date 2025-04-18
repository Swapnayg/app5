// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  String label;
  String value;
  List<Region> regions;

  CountryModel({
    required this.label,
    required this.value,
    required this.regions,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    label: json["label"],
    value: json["value"],
    regions: json["regions"] == null ? [] : List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "regions": regions == null ? null : List<dynamic>.from(regions.map((x) => x.toJson())),
  };
}

class Region {
  String label;
  String value;

  Region({
    required this.label,
    required this.value,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
