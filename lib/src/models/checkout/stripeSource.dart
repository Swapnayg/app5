// To parse this JSON data, do
//
//     final stripeSourceModel = stripeSourceModelFromJson(jsonString);

import 'dart:convert';

StripeSourceModel stripeSourceModelFromJson(String str) => StripeSourceModel.fromJson(json.decode(str));

String stripeSourceModelToJson(StripeSourceModel data) => json.encode(data.toJson());

class StripeSourceModel {
  String id;
  String object;
  dynamic amount;
  Card card;
  String clientSecret;
  int created;
  dynamic currency;
  String flow;
  bool livemode;
  Metadata metadata;
  Owner owner;
  dynamic statementDescriptor;
  String status;
  String type;
  String usage;

  StripeSourceModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.card,
    required this.clientSecret,
    required this.created,
    required this.currency,
    required this.flow,
    required this.livemode,
    required this.metadata,
    required this.owner,
    this.statementDescriptor,
    required this.status,
    required this.type,
    required this.usage,
  });

  factory StripeSourceModel.fromJson(Map<String, dynamic> json) => StripeSourceModel(
    id: json["id"],
    object: json["object"],
    amount: json["amount"],
    card: json["card"] == null
        ? Card(
            expMonth: 0,
            expYear: 0,
            last4: '',
            country: '',
            brand: '',
            addressLine1Check: '',
            addressZipCheck: '',
            cvcCheck: '',
            funding: '',
            threeDSecure: '',
          )
        : Card.fromJson(json["card"]),
    clientSecret: json["client_secret"],
    created: json["created"],
    currency: json["currency"],
    flow: json["flow"],
    livemode: json["livemode"],
    metadata: json["metadata"] == null ? Metadata() : Metadata.fromJson(json["metadata"]),
    owner: json["owner"] == null
        ? Owner(
            address: Address(
              city: '',
              country: '',
              line1: '',
              line2: '',
              postalCode: '',
              state: '',
            ),
            name: '',
          )
        : Owner.fromJson(json["owner"]),
    statementDescriptor: json["statement_descriptor"],
    status: json["status"],
    type: json["type"],
    usage: json["usage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "amount": amount,
    "card": card.toJson(),
    "client_secret": clientSecret,
    "created": created,
    "currency": currency,
    "flow": flow,
    "livemode": livemode,
    "metadata": metadata.toJson(),
    "owner": owner.toJson(),
    "statement_descriptor": statementDescriptor,
    "status": status,
    "type": type,
    "usage": usage,
  };
}

class Card {
  int expMonth;
  int expYear;
  String last4;
  String country;
  String brand;
  String addressLine1Check;
  String addressZipCheck;
  String cvcCheck;
  String funding;
  String threeDSecure;
  dynamic name;
  dynamic tokenizationMethod;
  dynamic dynamicLast4;

  Card({
    required this.expMonth,
    required this.expYear,
    required this.last4,
    required this.country,
    required this.brand,
    required this.addressLine1Check,
    required this.addressZipCheck,
    required this.cvcCheck,
    required this.funding,
    required this.threeDSecure,
    this.name,
    this.tokenizationMethod,
    this.dynamicLast4,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    last4: json["last4"],
    country: json["country"],
    brand: json["brand"],
    addressLine1Check: json["address_line1_check"],
    addressZipCheck: json["address_zip_check"],
    cvcCheck: json["cvc_check"],
    funding: json["funding"],
    threeDSecure: json["three_d_secure"],
    name: json["name"],
    tokenizationMethod: json["tokenization_method"],
    dynamicLast4: json["dynamic_last4"],
  );

  Map<String, dynamic> toJson() => {
    "exp_month": expMonth,
    "exp_year": expYear,
    "last4": last4,
    "country": country,
    "brand": brand,
    "address_line1_check": addressLine1Check,
    "address_zip_check": addressZipCheck,
    "cvc_check": cvcCheck,
    "funding": funding,
    "three_d_secure": threeDSecure,
    "name": name,
    "tokenization_method": tokenizationMethod,
    "dynamic_last4": dynamicLast4,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Owner {
  Address address;
  dynamic email;
  String name;
  dynamic phone;
  dynamic verifiedAddress;
  dynamic verifiedEmail;
  dynamic verifiedName;
  dynamic verifiedPhone;

  Owner({
    required this.address,
    this.email,
    required this.name,
    this.phone,
    this.verifiedAddress,
    this.verifiedEmail,
    this.verifiedName,
    this.verifiedPhone,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    address:  json["address"] == null
        ? Address(
            city: '',
            country: '',
            line1: '',
            line2: '',
            postalCode: '',
            state: '',
          )
        : Address.fromJson(json["address"]),
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
    verifiedAddress: json["verified_address"],
    verifiedEmail: json["verified_email"],
    verifiedName: json["verified_name"],
    verifiedPhone: json["verified_phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address.toJson(),
    "email": email,
    "name": name,
    "phone": phone,
    "verified_address": verifiedAddress,
    "verified_email": verifiedEmail,
    "verified_name": verifiedName,
    "verified_phone": verifiedPhone,
  };
}

class Address {
  String city;
  String country;
  String line1;
  String line2;
  String postalCode;
  String state;

  Address({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    country: json["country"],
    line1: json["line1"],
    line2: json["line2"],
    postalCode: json["postal_code"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "line1": line1,
    "line2": line2,
    "postal_code": postalCode,
    "state": state,
  };
}
