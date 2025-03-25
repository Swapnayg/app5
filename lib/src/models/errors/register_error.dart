// To parse this JSON data, do
//
//     final registerError = registerErrorFromJson(jsonString);

import 'dart:convert';

RegisterError registerErrorFromJson(String str) => RegisterError.fromJson(json.decode(str));

String registerErrorToJson(RegisterError data) => json.encode(data.toJson());

class RegisterError {
  bool success;
  List<Datum> data;

  RegisterError({
    this.success,
    this.data,
  });

  factory RegisterError.fromJson(Map<String, dynamic> json) => RegisterError(
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
    this.code,
    this.message,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
