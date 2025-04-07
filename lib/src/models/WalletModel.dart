// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

List<WalletModel> walletModelFromJson(String str) => List<WalletModel>.from(json.decode(str).map((x) => WalletModel.fromJson(x)));

String walletModelToJson(List<WalletModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletModel {
  WalletModel({
    required this.transactionId,
    required this.blogId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.balance,
    required this.currency,
    required this.details,
    required this.deleted,
    required this.date,
  });

  String transactionId;
  String blogId;
  String userId;
  String type;
  String amount;
  String balance;
  String currency;
  String details;
  String deleted;
  DateTime date;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    transactionId: json["transaction_id"],
    blogId: json["blog_id"],
    userId: json["user_id"],
    type: json["type"],
    amount: json["amount"],
    balance: json["balance"],
    currency: json["currency"],
    details: json["details"],
    deleted: json["deleted"],
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "blog_id": blogId,
    "user_id": userId,
    "type": type,
    "amount": amount,
    "balance": balance,
    "currency": currency,
    "details": details,
    "deleted": deleted,
    "date": date.toIso8601String(),
  };
}
