// To parse this JSON data, do
//
//     final addToCartErrorModel = addToCartErrorModelFromJson(jsonString);

import 'dart:convert';

AddToCartErrorModel addToCartErrorModelFromJson(String str) => AddToCartErrorModel.fromJson(json.decode(str));

String addToCartErrorModelToJson(AddToCartErrorModel data) => json.encode(data.toJson());

class AddToCartErrorModel {
  bool success;
  AddToCartErrorData? data;

  AddToCartErrorModel({
    required this.success,
    required this.data,
  });

  factory AddToCartErrorModel.fromJson(Map<String, dynamic> json) => AddToCartErrorModel(
    success: json["success"],
    data: json["data"] == null ? null : AddToCartErrorData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class AddToCartErrorData {
  bool error;
  String productUrl;
  String notice;

  AddToCartErrorData({
    required this.error,
    required this.productUrl,
    required this.notice,
  });

  factory AddToCartErrorData.fromJson(Map<String, dynamic> json) => AddToCartErrorData(
    error: json["error"],
    //productUrl: json["product_url"] == null ? null : json["product_url"],
    notice: json["notice"], productUrl: '',
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "product_url": productUrl,
    "notice": notice,
  };
}
