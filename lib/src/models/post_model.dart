// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int id;
  DateTime date;
  DateTime dateGmt;
  Guid guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int author;
  int featuredMedia;
  String commentStatus;
  String pingStatus;
  bool sticky;
  String template;
  String format;
  Meta meta;
  List<int> categories;
  List<dynamic> tags;
  String featuredUrl;
  AuthorDetails authorDetails;
  FeaturedDetails featuredDetails;
  String excerptData;
  String commentCount;
  Links links;

  Post({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.commentStatus,
    required this.pingStatus,
    required this.sticky,
    required this.template,
    required this.format,
    required this.meta,
    required this.categories,
    required this.tags,
    required this.featuredUrl,
    required this.authorDetails,
    required this.featuredDetails,
    required this.excerptData,
    required this.commentCount,
    required this.links,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
    dateGmt: json["dateGmt"] == null ? DateTime.now() : DateTime.parse(json["dateGmt"]),
    guid: json["guid"] == null ? Guid('', rendered: '') : Guid.fromJson(json["guid"]),
    modified: json["modified"] == null ? DateTime.now() : DateTime.parse(json["modified"]),
    modifiedGmt: json["modifiedGmt"] == null ? DateTime.now() : DateTime.parse(json["modifiedGmt"]),
    slug: json["slug"],
    status: json["status"],
    type: json["type"],
    link: json["link"],
    title: json["title"] == null ? Guid('', rendered: '') : Guid.fromJson(json["title"]),
    content:  json["content"] == null ? Content('', rendered: '', protected: false): Content.fromJson(json["content"]),
    excerpt: json["excerpt"] == null ? Content('', rendered: '', protected: false): Content.fromJson(json["excerpt"]),
    author: json["author"],
    featuredMedia: json["featured_media"],
    commentStatus: json["comment_status"],
    pingStatus: json["ping_status"],
    sticky: json["sticky"],
    template: json["template"],
    format: json["format"],
    meta: json["meta"] == null ? Meta(likes: 0) : Meta.fromJson(json["meta"]),
    categories: json["categories"] == null ? [] : List<int>.from(json["categories"].map((x) => x)),
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"].map((x) => x)),
    featuredUrl: json["featuredUrl"],
    authorDetails: json["authorDetails"] == null ? AuthorDetails(name: '', avatar: '', avatarUrl: '', id: 0) : AuthorDetails.fromJson(json["authorDetails"]),
    featuredDetails: json["featuredDetails"] == null ? FeaturedDetails(width: 0, height: 0, file: '', imageMeta: ImageMeta(aperture: '', credit: '', camera: '', caption: '', createdTimestamp: '', copyright: '', focalLength: '', iso: '', shutterSpeed: '', title: '', orientation: '', keywords: [])) : FeaturedDetails.fromJson(json["featuredDetails"]),
    excerptData: json["excerptData"],
    commentCount: json["commentCount"],
    links: json["_links"] == null
        ? Links(
            self: [],
            collection: [],
            about: [],
            author: [],
            replies: [],
            versionHistory: [],
            predecessorVersion: [],
            wpFeaturedmedia: [],
            wpAttachment: [],
            wpTerm: [],
            curies: [],
          )
        : Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date.toIso8601String(),
    "date_gmt": dateGmt.toIso8601String(),
    "guid": guid.toJson(),
    "modified": modified.toIso8601String(),
    "modified_gmt": modifiedGmt.toIso8601String(),
    "slug": slug,
    "status": status,
    "type": type,
    "link": link,
    "title": title.toJson(),
    "content": content.toJson(),
    "excerpt": excerpt.toJson(),
    "author": author,
    "featured_media": featuredMedia,
    "comment_status": commentStatus,
    "ping_status": pingStatus,
    "sticky": sticky,
    "template": template,
    "format": format,
    "meta": meta.toJson(),
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x)),
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    "featuredUrl": featuredUrl,
    "authorDetails": authorDetails.toJson(),
    "featuredDetails": featuredDetails.toJson(),
    "excerptData": excerptData,
    "commentCount": commentCount,
    "_links": links.toJson(),
  };
}

class AuthorDetails {
  String name;
  String avatar;

  AuthorDetails({
    required this.name,
    required this.avatar, required String avatarUrl, required int id,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
    name: json["name"],
    avatar: json["avatar"], avatarUrl: '', id: 0,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
  };
}

class Content {
  String rendered;
  bool protected;

  Content(String s, {
    required this.rendered,
    required this.protected,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    '', // Add the missing positional argument
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}

class FeaturedDetails {
  int width;
  int height;
  String file;
  ImageMeta imageMeta;

  FeaturedDetails({
    required this.width,
    required this.height,
    required this.file,
    required this.imageMeta,
  });

  factory FeaturedDetails.fromJson(Map<String, dynamic> json) => FeaturedDetails(
    width: json["width"],
    height: json["height"],
    file: json["file"],
    imageMeta: json["image_meta"] == null
        ? ImageMeta(
            aperture: '',
            credit: '',
            camera: '',
            caption: '',
            createdTimestamp: '',
            copyright: '',
            focalLength: '',
            iso: '',
            shutterSpeed: '',
            title: '',
            orientation: '',
            keywords: [],
          )
        : ImageMeta.fromJson(json["image_meta"]),
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "file": file,
    "image_meta": imageMeta.toJson(),
  };
}

class ImageMeta {
  String aperture;
  String credit;
  String camera;
  String caption;
  String createdTimestamp;
  String copyright;
  String focalLength;
  String iso;
  String shutterSpeed;
  String title;
  String orientation;
  List<String> keywords;

  ImageMeta({
    required this.aperture,
    required this.credit,
    required this.camera,
    required this.caption,
    required this.createdTimestamp,
    required this.copyright,
    required this.focalLength,
    required this.iso,
    required this.shutterSpeed,
    required this.title,
    required this.orientation,
    required this.keywords,
  });

  factory ImageMeta.fromJson(Map<String, dynamic> json) => ImageMeta(
    aperture: json["aperture"],
    credit: json["credit"],
    camera: json["camera"],
    caption: json["caption"],
    createdTimestamp: json["created_timestamp"],
    copyright: json["copyright"],
    focalLength: json["focal_length"],
    iso: json["iso"],
    shutterSpeed: json["shutter_speed"],
    title: json["title"],
    orientation: json["orientation"],
    keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "aperture": aperture,
    "credit": credit,
    "camera": camera,
    "caption": caption,
    "created_timestamp": createdTimestamp,
    "copyright": copyright,
    "focal_length": focalLength,
    "iso": iso,
    "shutter_speed": shutterSpeed,
    "title": title,
    "orientation": orientation,
    "keywords": keywords == null ? null : List<dynamic>.from(keywords.map((x) => x)),
  };
}

class Guid {
  String rendered;

  Guid(String s, {
    required this.rendered,
  });

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
    '', rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class Links {
  List<About> self;
  List<About> collection;
  List<About> about;
  List<Author> author;
  List<Author> replies;
  List<VersionHistory> versionHistory;
  List<PredecessorVersion> predecessorVersion;
  List<Author> wpFeaturedmedia;
  List<About> wpAttachment;
  List<WpTerm> wpTerm;
  List<Cury> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
    required this.versionHistory,
    required this.predecessorVersion,
    required this.wpFeaturedmedia,
    required this.wpAttachment,
    required this.wpTerm,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self:  json["self"] == null ? [] : List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: json["collection"] == null ? [] : List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about:  json["about"] == null ? [] : List<About>.from(json["about"].map((x) => About.fromJson(x))),
    author:json["author"] == null ? [] : List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
    replies: json["replies"] == null ? [] : List<Author>.from(json["replies"].map((x) => Author.fromJson(x))), 
    versionHistory:  json["version-history"] == null ? [] : List<VersionHistory>.from(json["version-history"].map((x) => VersionHistory.fromJson(x))),
    predecessorVersion: json["predecessor-version"] == null ? [] : List<PredecessorVersion>.from(json["predecessor-version"].map((x) => PredecessorVersion.fromJson(x))),
    wpFeaturedmedia:json["wp:featuredmedia"] == null ? [] : List<Author>.from(json["wp:featuredmedia"].map((x) => Author.fromJson(x))),
    wpAttachment: json["wp:attachment"] == null ? [] : List<About>.from(json["wp:attachment"].map((x) => About.fromJson(x))),
    wpTerm:  json["wp:term"] == null ? [] : List<WpTerm>.from(json["wp:term"].map((x) => WpTerm.fromJson(x))),
    curies: json["curies"] == null ? [] : List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": collection == null ? null : List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": about == null ? null : List<dynamic>.from(about.map((x) => x.toJson())),
    "author": author == null ? null : List<dynamic>.from(author.map((x) => x.toJson())),
    "replies": replies == null ? null : List<dynamic>.from(replies.map((x) => x.toJson())),
    "version-history": versionHistory == null ? null : List<dynamic>.from(versionHistory.map((x) => x.toJson())),
    "predecessor-version": predecessorVersion == null ? null : List<dynamic>.from(predecessorVersion.map((x) => x.toJson())),
    "wp:featuredmedia": wpFeaturedmedia == null ? null : List<dynamic>.from(wpFeaturedmedia.map((x) => x.toJson())),
    "wp:attachment": wpAttachment == null ? null : List<dynamic>.from(wpAttachment.map((x) => x.toJson())),
    "wp:term": wpTerm == null ? null : List<dynamic>.from(wpTerm.map((x) => x.toJson())),
    "curies": curies == null ? null : List<dynamic>.from(curies.map((x) => x.toJson())),
  };
}

class About {
  String href;

  About({
    required this.href,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Author {
  bool embeddable;
  String href;

  Author({
    required this.embeddable,
    required this.href,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "embeddable": embeddable,
    "href": href,
  };
}

class Cury {
  String name;
  String href;
  bool templated;

  Cury({
    required this.name,
    required this.href,
    required this.templated,
  });

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
    name: json["name"],
    href: json["href"],
    templated: json["templated"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "href": href,
    "templated": templated,
  };
}

class PredecessorVersion {
  int id;
  String href;

  PredecessorVersion({
    required this.id,
    required this.href,
  });

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) => PredecessorVersion(
    id: json["id"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "href": href,
  };
}

class VersionHistory {
  int count;
  String href;

  VersionHistory({
    required this.count,
    required this.href,
  });

  factory VersionHistory.fromJson(Map<String, dynamic> json) => VersionHistory(
    count: json["count"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "href": href,
  };
}

class WpTerm {
  String taxonomy;
  bool embeddable;
  String href;

  WpTerm({
    required this.taxonomy,
    required this.embeddable,
    required this.href,
  });

  factory WpTerm.fromJson(Map<String, dynamic> json) => WpTerm(
    taxonomy: json["taxonomy"],
    embeddable: json["embeddable"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "taxonomy": taxonomy,
    "embeddable": embeddable,
    "href": href,
  };
}

class Meta {
  int likes;

  Meta({
    required this.likes,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    likes: json["likes"],
  );

  Map<String, dynamic> toJson() => {
    "likes": likes,
  };
}
