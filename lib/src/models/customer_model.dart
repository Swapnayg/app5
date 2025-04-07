// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  int id;
  String email;
  String firstName;
  String lastName;
  String role;
  String username;
  Address billing;
  Address shipping;
  bool isPayingCustomer;
  int ordersCount;
  String totalSpent;
  String avatarUrl;
  List<MetaDatum> metaData;
  String guest;

  Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.username,
    required this.billing,
    required this.shipping,
    required this.isPayingCustomer,
    required this.ordersCount,
    required this.totalSpent,
    required this.avatarUrl,
    required this.metaData,
    required this.guest
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] ?? 0,
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
    username: json["username"],
    billing: json["billing"] == null ? Address.empty() : Address.fromJson(json["billing"]),
    shipping: json["shipping"] == null ? Address.empty() : Address.fromJson(json["shipping"]),
    isPayingCustomer: json["is_paying_customer"],
    ordersCount: json["orders_count"],
    totalSpent: json["total_spent"],
    avatarUrl: json["avatar_url"],
    metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    guest: json["guest"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
    "username": username,
    "billing": billing.toJson(),
    "shipping": shipping.toJson(),
    "is_paying_customer": isPayingCustomer,
    "orders_count": ordersCount,
    "total_spent": totalSpent,
    "avatar_url": avatarUrl,
    "meta_data": metaData == null ? null : List<dynamic>.from(metaData.map((x) => x.toJson())),
  };
}

class Address {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  Address({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    required this.email,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    firstName: json["first_name"] ?? '',
    lastName: json["last_name"] ?? '',
    company: json["company"] ?? '',
    address1: json["address_1"] ?? '',
    address2: json["address_2"] ?? '',
    city: json["city"] ?? '',
    postcode: json["postcode"] ?? '',
    country: json["country"] ?? '',
    state: json["state"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "postcode": postcode,
    "country": country,
    "state": state,
    "email": email,
    "phone": phone,
  };
  
  static empty() {}
}

class MetaDatum {
  int id;
  String key;
  dynamic value;

  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
  };
}
