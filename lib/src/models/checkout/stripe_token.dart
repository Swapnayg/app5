// To parse this JSON data, do
//
//     final stripeTokenModel = stripeTokenModelFromJson(jsonString);

import 'dart:convert';

StripeTokenModel stripeTokenModelFromJson(String str) => StripeTokenModel.fromJson(json.decode(str));

String stripeTokenModelToJson(StripeTokenModel data) => json.encode(data.toJson());

class StripeTokenModel {
  String id;
  String object;
  Card? card;
  String clientIp;
  int created;
  bool livemode;
  String type;
  bool used;

  StripeTokenModel({
    required this.id,
    required this.object,
    required this.card,
    required this.clientIp,
    required this.created,
    required this.livemode,
    required this.type,
    required this.used,
  });

  factory StripeTokenModel.fromJson(Map<String, dynamic> json) => StripeTokenModel(
    id: json["id"],
    object: json["object"],
    card: json["card"] == null ? null : Card.fromJson(json["card"]), 
    clientIp: json["client_ip"],
    created: json["created"],
    livemode: json["livemode"],
    type: json["type"],
    used: json["used"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "card": card?.toJson(),
    "client_ip": clientIp,
    "created": created,
    "livemode": livemode,
    "type": type,
    "used": used,
  };
}

class Card {
  String id;
  String object;
  String addressCity;
  String addressCountry;
  String addressLine1;
  String addressLine1Check;
  String addressLine2;
  String addressState;
  String addressZip;
  String addressZipCheck;
  String brand;
  String country;
  String cvcCheck;
  dynamic dynamicLast4;
  int expMonth;
  int expYear;
  String funding;
  String last4;
  Metadata? metadata;
  String name;
  dynamic tokenizationMethod;

  Card({
    required this.id,
    required this.object,
    required this.addressCity,
    required this.addressCountry,
    required this.addressLine1,
    required this.addressLine1Check,
    required this.addressLine2,
    required this.addressState,
    required this.addressZip,
    required this.addressZipCheck,
    required this.brand,
    required this.country,
    required this.cvcCheck,
    this.dynamicLast4,
    required this.expMonth,
    required this.expYear,
    required this.funding,
    required this.last4,
    required this.metadata,
    required this.name,
    this.tokenizationMethod,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    id: json["id"],
    object: json["object"],
    addressCity: json["address_city"],
    addressCountry: json["address_country"],
    addressLine1: json["address_line1"],
    addressLine1Check: json["address_line1_check"],
    addressLine2: json["address_line2"],
    addressState: json["address_state"],
    addressZip: json["address_zip"],
    addressZipCheck: json["address_zip_check"],
    brand: json["brand"],
    country: json["country"],
    cvcCheck: json["cvc_check"],
    dynamicLast4: json["dynamic_last4"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    funding: json["funding"],
    last4: json["last4"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    name: json["name"],
    tokenizationMethod: json["tokenization_method"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "address_city": addressCity,
    "address_country": addressCountry,
    "address_line1": addressLine1,
    "address_line1_check": addressLine1Check,
    "address_line2": addressLine2,
    "address_state": addressState,
    "address_zip": addressZip,
    "address_zip_check": addressZipCheck,
    "brand": brand,
    "country": country,
    "cvc_check": cvcCheck,
    "dynamic_last4": dynamicLast4,
    "exp_month": expMonth,
    "exp_year": expYear,
    "funding": funding,
    "last4": last4,
    "metadata": metadata?.toJson(),
    "name": name,
    "tokenization_method": tokenizationMethod,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}
