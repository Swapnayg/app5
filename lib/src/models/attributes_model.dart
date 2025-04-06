// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

List<AttributesModel> filterModelFromJson(String str) => List<AttributesModel>.from(json.decode(str).map((x) => AttributesModel.fromJson(x)));

String filterModelToJson(List<AttributesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttributesModel {
  String id;
  String name;
  List<Term> terms;

  AttributesModel({
    this.id,
    this.name,
    this.terms,
  });

  factory AttributesModel.fromJson(Map<String, dynamic> json) => AttributesModel(
    id: json["id"],
    name: json["name"],
    terms: json["terms"] == null ? null : List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
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
    this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.filter,
    this.selected,
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
