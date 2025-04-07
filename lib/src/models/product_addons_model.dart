// To parse this JSON data, do
//
//     final productAddons = productAddonsFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

List<ProductAddonsModel> productAddonsFromJson(String str) => List<ProductAddonsModel>.from(json.decode(str).map((x) => ProductAddonsModel.fromJson(x)));

class ProductAddonsModel {
  ProductAddonsModel({
    required this.id,
    required this.name,
    required this.priority,
    required this.restrictToCategories,
    required this.fields,
  });

  int id;
  String name;
  int priority;
  Map<String, String> restrictToCategories;
  List<AddonField> fields;

  factory ProductAddonsModel.fromJson(Map<String, dynamic> json) {
    try{
      return ProductAddonsModel(
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        restrictToCategories: json["restrict_to_categories"] == null
            ? {}
            : (json["restrict_to_categories"] as Map).cast<String, String>(),
        fields: json["fields"] == null ? [] : List<AddonField>.from(json["fields"].map((x) => AddonField.fromJson(x))),
      );
    } catch (e) {
      return ProductAddonsModel(
        id: json["id"],
        name: json["name"],
        priority: json["priority"],
        restrictToCategories: {},
        fields: json["fields"] == null ? [] : List<AddonField>.from(
            json["fields"].map((x) => AddonField.fromJson(x))),
      );
    }
  }
}

class AddonField {
  AddonField({
    required this.name,
    required this.description,
    required this.type,
    required this.display,
    required this.position,
    required this.options,
    required this.required,
  });

  String name;
  String description;
  String type;
  String display;
  int position;
  List<AddonOption> options;
  int required;

  factory AddonField.fromJson(Map<String, dynamic> json) => AddonField(
    name: json["name"],
    description: json["description"],
    type: json["type"],
    display: json["display"] ?? 'radiobutton',
    position: json["position"],
    options: json["options"] == null ? [] : List<AddonOption>.from(
            json["options"].map((x) => AddonOption.fromJson(x))),
    required: json["required"],
  );

}

class AddonOption {
  AddonOption({
    required this.label,
    required this.price,
    required this.min,
    required this.max,
  });

  String label;
  String price;
  int min;
  int max;

  factory AddonOption.fromJson(Map<String, dynamic> json) => AddonOption(
    label: json["label"],
    price: json["price"],
    min: (json["min"] == null || json["min"] == '') ? 100 : int.parse(json["min"]),
    max: (json["max"] == null || json["max"] == '') ? 1000 : int.parse(json["max"]),
  );

}
