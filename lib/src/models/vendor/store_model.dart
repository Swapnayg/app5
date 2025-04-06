// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) => List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

class StoreModel {
  int id;
  String name;
  String icon;
  String banner;
  Address address;
  String description;
  String latitude;
  String longitude;
  double averageRating;
  int ratingCount;
  int productsCount;

  StoreModel({
    this.id,
    this.name,
    this.icon,
    this.banner,
    this.address,
    this.description,
    this.latitude,
    this.longitude,
    this.averageRating,
    this.ratingCount,
    this.productsCount,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: json["id"],
    name: json["name"],
    icon: (json["icon"] == null || json["icon"] == false) ? '' : json["icon"],
    banner: (json["icon"] == null || json["icon"] == false) ? '' : json["banner"],
    //address: json["address"] == null ? null : Address.fromJson(json["address"]),
    description: json["description"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    averageRating: json["average_rating"]?.toDouble(),
    ratingCount: json["rating_count"],
    productsCount: json["products_count"],
  );

}

class Address {
  String street1;
  String street2;
  String city;
  String zip;
  String country;
  String state;

  Address({
    this.street1,
    this.street2,
    this.city,
    this.zip,
    this.country,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street1: json["street_1"],
    street2: json["street_2"],
    city: json["city"],
    zip: json["zip"],
    country: json["country"],
    state: json["state"],
  );

}
