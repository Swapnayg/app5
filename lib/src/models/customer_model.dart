// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

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
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.ordersCount,
    this.totalSpent,
    this.avatarUrl,
    this.metaData,
    this.guest
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] ?? 0,
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
    username: json["username"],
    billing: json["billing"] == null ? null : Address.fromJson(json["billing"]),
    shipping: json["shipping"] == null ? null : Address.fromJson(json["shipping"]),
    isPayingCustomer: json["is_paying_customer"],
    ordersCount: json["orders_count"],
    totalSpent: json["total_spent"],
    avatarUrl: json["avatar_url"],
    metaData: json["meta_data"] == null ? null : List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    guest: json["guest"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
    "username": username,
    "billing": billing?.toJson(),
    "shipping": shipping?.toJson(),
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
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
    this.email,
    this.phone,
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
}

class MetaDatum {
  int id;
  String key;
  dynamic value;

  MetaDatum({
    this.id,
    this.key,
    this.value,
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
