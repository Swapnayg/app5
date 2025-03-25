
import 'dart:convert';

OrderResult OrderResultFromJson(String str) => OrderResult.fromJson(json.decode(str));

class OrderResult {
  String result;
  String messages;
  String redirect;

  OrderResult({
    this.result,
    this.messages,
    this.redirect,
  });

  factory OrderResult.fromJson(Map<String, dynamic> json) => OrderResult(
    result: json["result"],
    messages: json["messages"],
    redirect: json["redirect"],
  );

}