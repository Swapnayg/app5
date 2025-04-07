// To parse this JSON data, do
//
//     final vendorDetails = vendorDetailsFromJson(jsonString);

import 'dart:convert';

import '../blocks_model.dart';
import '../product_model.dart';

VendorDetailsModel vendorDetailsModelFromJson(String str) => VendorDetailsModel.fromJson(json.decode(str));

class VendorDetailsModel {
  Store store;
  List<Block> blocks;
  List<Product> recentProducts;



  VendorDetailsModel({
    required this.store,
    required this.blocks,
    required this.recentProducts,
  });

  factory VendorDetailsModel.fromJson(Map<String, dynamic> json) => VendorDetailsModel(
    store: json["store"] == null ? Store(id: 0, name: '', icon: '', banner: '', banners: [], video: '', address: [], social: [], email: '', phone: '', description: '', latitude: '0', longitude: '0', averageRating: 0.0, ratingCount: 0, productsCount: 0) : Store.fromJson(json["store"]),
    blocks: json["blocks"] == null ? [] : List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
    recentProducts: json["recentProducts"] == null ? [] : List<Product>.from(json["recentProducts"].map((x) => Product.fromJson(x))),
  );

}

class Store {
  int id;
  String name;
  String icon;
  String banner;
  List<Banner> banners;
  String video;
  List<Address> address;
  List<Social> social;
  String email;
  String phone;
  String description;
  String latitude;
  String longitude;
  double averageRating;
  int ratingCount;
  int productsCount;

  Store({
    required this.id,
    required this.name,
    required this.icon,
    required this.banner,
    required this.banners,
    required this.video,
    required this.address,
    required this.social,
    required this.email,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.averageRating,
    required this.ratingCount,
    required this.productsCount,
    required this.phone
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"] ?? '',
    icon: json["icon"],
    banner: json["banner"] == null || json["banner"] == false ? null : json["banner"],
    video: json["video"],
    address: json["address"] == null ? [] : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
    social: json["social"] == null ? [] : List<Social>.from(json["social"].map((x) => Social.fromJson(x))),
    email: json["email"],
    phone: json["phone"],
    description: json["description"],
    latitude: json["latitude"] ?? '0',
    longitude: json["longitude"] ?? '0',
    averageRating: json["average_rating"]?.toDouble(),
    ratingCount: json["rating_count"],
    productsCount: json["products_count"], banners: [],
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
    required this.street1,
    required this.street2,
    required this.city,
    required this.zip,
    required this.country,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street1: json["street_1"],
    street2: json["street_2"],
    city: json["city"],
    zip: json["zip"],
    country: json["country"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "street_1": street1,
    "street_2": street2,
    "city": city,
    "zip": zip,
    "country": country,
    "state": state,
  };
}

class Banner {
  String image;
  String link;

  Banner({
    required this.image,
    required this.link,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    image: json["image"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "link": link,
  };
}

class Social {
  String twitter;
  String fb;
  String instagram;
  String youtube;
  String linkedin;
  String gplus;
  String snapchat;
  String pinterest;
  String googleplus;
  String facebook;

  Social({
    required this.twitter,
    required this.fb,
    required this.instagram,
    required this.youtube,
    required this.linkedin,
    required this.gplus,
    required this.snapchat,
    required this.pinterest,
    required this.googleplus,
    required this.facebook,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    twitter: json["twitter"],
    fb: json["fb"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    linkedin: json["linkedin"],
    gplus: json["gplus"],
    snapchat: json["snapchat"],
    pinterest: json["pinterest"],
    googleplus: json["googleplus"],
    facebook: json["facebook"],
  );

  Map<String, dynamic> toJson() => {
    "twitter": twitter,
    "fb": fb,
    "instagram": instagram,
    "youtube": youtube,
    "linkedin": linkedin,
    "gplus": gplus,
    "snapchat": snapchat,
    "pinterest": pinterest,
    "googleplus": googleplus,
    "facebook": facebook,
  };
}

