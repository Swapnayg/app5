// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

List<AttributesModel> filterModelFromJson(String str) => List<AttributesModel>.from(json.decode(str).map((x) => AttributesModel.fromJson(x)));

String filterModelToJson(List<AttributesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttributesModel {
  String id;
  String name;
  List<Term> terms;

  AttributesModel({
    required this.id,
    required this.name,
    required this.terms,
  });

  factory AttributesModel.fromJson(Map<String, dynamic> json) => AttributesModel(
    id: json["id"],
    name: json["name"],
    terms: json["terms"] == null ? [] : List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "terms": terms == null ? null : List<dynamic>.from(terms.map((x) => x.toJson())),
  };
}

class Term {
  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  String taxonomy;
  String description;
  int parent;
  int count;
  String filter;
  bool selected;

  Term({
    required this.termId,
    required this.name,
    required this.slug,
    required this.termGroup,
    required this.termTaxonomyId,
    required this.taxonomy,
    required this.description,
    required this.parent,
    required this.count,
    required this.filter,
    required this.selected,
  });

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    termId: json["term_id"],
    name: json["name"],
    slug: json["slug"],
    termGroup: json["term_group"],
    termTaxonomyId: json["term_taxonomy_id"],
    taxonomy: json["taxonomy"],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    filter: json["filter"],
    selected: false,
  );

  Map<String, dynamic> toJson() => {
    "term_id": termId,
    "name": name,
    "slug": slug,
    "term_group": termGroup,
    "term_taxonomy_id": termTaxonomyId,
    "taxonomy": taxonomy,
    "description": description,
    "parent": parent,
    "count": count,
    "filter": filter,
  };
}
