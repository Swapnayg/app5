// To parse this JSON data, do
//
//     final productAttribute = productAttributeFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

List<ProductAttribute> productAttributeFromJson(String str) => List<ProductAttribute>.from(json.decode(str).map((x) => ProductAttribute.fromJson(x)));

String productAttributeToJson(List<ProductAttribute> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductAttribute {
  int id;
  String name;
  String slug;
  String type;
  String orderBy;
  bool hasArchives;
  Links links;

  ProductAttribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    required this.orderBy,
    required this.hasArchives,
    required this.links,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    type: json["type"],
    orderBy: json["order_by"],
    hasArchives: json["has_archives"],
    links: json["_links"] == null ? Links(self: [], collection: []) : Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "type": type,
    "order_by": orderBy,
    "has_archives": hasArchives,
    "_links": links.toJson(),
  };
}

class Links {
  List<Collection> self;
  List<Collection> collection;

  Links({
    required this.self,
    required this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"] == null ? [] : List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": collection == null ? null : List<dynamic>.from(collection.map((x) => x.toJson())),
  };
}

class Collection {
  String href;

  Collection({
    required this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}


List<AttributeTerms> attributeTermsFromJson(String str) => List<AttributeTerms>.from(json.decode(str).map((x) => AttributeTerms.fromJson(x)));

String attributeTermsToJson(List<AttributeTerms> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttributeTerms {
  int id;
  String name;
  String slug;
  String description;
  int menuOrder;
  int count;
  Links links;

  AttributeTerms({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.menuOrder,
    required this.count,
    required this.links,
  });

  factory AttributeTerms.fromJson(Map<String, dynamic> json) => AttributeTerms(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    menuOrder: json["menu_order"],
    count: json["count"],
    links:  json["_links"] == null ? Links(self: [], collection: []) : Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "menu_order": menuOrder,
    "count": count,
    "_links": links.toJson(),
  };
}
