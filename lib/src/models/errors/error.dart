// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

WpErrors errorFromJson(String str) => WpErrors.fromJson(json.decode(str));

String errorToJson(WpErrors data) => json.encode(data.toJson());

class WpErrors {
  bool success;
  List<Datum> data;

  WpErrors({
    required this.success,
    required this.data,
  });

  factory WpErrors.fromJson(Map<String, dynamic> json) => WpErrors(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String code;
  String message;

  Datum({
    required this.code,
    required this.message,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    code: json["code"]!.toString(),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}


Notice noticeFromJson(String str) => Notice.fromJson(json.decode(str));

String noticeToJson(Notice data) => json.encode(data.toJson());

class Notice {
  Notice({
    required this.success,
    required this.data,
  });

  bool success;
  List<Messages> data;

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    success: json["success"],
    data: json["data"] == null ? [] : List<Messages>.from(json["data"].map((x) => Messages.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Messages {
  Messages({
    required this.notice,
    required this.data,
  });

  String notice;
  List<dynamic> data;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    notice: json["notice"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "notice": notice,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
  };
}
