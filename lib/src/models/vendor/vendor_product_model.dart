import 'dart:convert';

class VendorProductsModel {
  final List<VendorProduct> products;

  VendorProductsModel({
    this.products,
  });

  factory VendorProductsModel.fromJson(List<dynamic> parsedJson) {

    List<VendorProduct> products = List<VendorProduct>();
    products = parsedJson.map((i)=>VendorProduct.fromJson(i)).toList();

    return VendorProductsModel(products : products);
  }

}
// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

List<VendorProduct> productFromJson(String str) => List<VendorProduct>.from(json.decode(str).map((x) => VendorProduct.fromJson(x)));

String productToJson(List<VendorProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VendorProduct {
  int id;
  String name;
  String slug;
  String permalink;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String type;
  String status;
  bool featured;
  String catalogVisibility;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  String priceHtml;
  bool onSale;
  bool purchasable;
  int totalSales;
  bool virtual;
  bool downloadable;
  List<dynamic> downloads;
  int downloadLimit;
  int downloadExpiry;
  String externalUrl;
  String buttonText;
  String taxStatus;
  String taxClass;
  bool manageStock;
  int stockQuantity;
  String stockStatus;
  String backOrders;
  bool backordersAllowed;
  bool backordered;
  bool soldIndividually;
  String weight;
  Dimensions dimensions;
  bool shippingRequired;
  bool shippingTaxable;
  String shippingClass;
  int shippingClassId;
  bool reviewsAllowed;
  String averageRating;
  int ratingCount;
  List<int> relatedIds;
  List<dynamic> upsellIds;
  List<dynamic> crossSellIds;
  int parentId;
  String purchaseNote;
  List<ProductCategory> categories;
  List<dynamic> tags;
  List<ProductImage> images;
  List<Attribute> attributes;
  List<DefaultAttribute> defaultAttributes;
  List<dynamic> variations;
  List<dynamic> groupedProducts;
  int menuOrder;
  List<dynamic> metaData;
  Links links;
  int decimals;
  String vendor;

  VendorProduct({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.priceHtml,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.backOrders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.metaData,
    this.links,
    this.decimals,
    this.vendor
  });

  factory VendorProduct.fromJson(Map<String, dynamic> json) => VendorProduct(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    permalink: json["permalink"],
    dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
    dateCreatedGmt: json["date_created_gmt"] == null ? null : DateTime.parse(json["date_created_gmt"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    dateModifiedGmt: json["date_modified_gmt"] == null ? null : DateTime.parse(json["date_modified_gmt"]),
    type: json["type"],
    status: json["status"],
    featured: json["featured"],
    catalogVisibility: json["catalog_visibility"],
    description: json["description"],
    shortDescription: json["short_description"],
    sku: json["sku"],
    price: (json["sale_price"] != null && json["sale_price"] != '') ? json["sale_price"] : json["price"] == null || json["price"] == '' ? '0' : json["price"],
    regularPrice: json["regular_price"] == null  || json["regular_price"] == '' ? '0' : json["regular_price"],
    salePrice: json["sale_price"] == null  || json["sale_price"] == '' ? '0' : json["sale_price"],
    dateOnSaleFrom: json["date_on_sale_from"],
    dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
    dateOnSaleTo: json["date_on_sale_to"],
    dateOnSaleToGmt: json["date_on_sale_to_gmt"],
    priceHtml: json["price_html"],
    onSale: json["on_sale"],
    purchasable: json["purchasable"],
    totalSales: json["total_sales"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
    downloads: json["downloads"] == null ? null : List<dynamic>.from(json["downloads"].map((x) => x)),
    downloadLimit: json["download_limit"],
    downloadExpiry: json["download_expiry"],
    externalUrl: json["external_url"],
    buttonText: json["button_text"],
    taxStatus: json["tax_status"],
    taxClass: json["tax_class"],
    manageStock: json["manage_stock"],
    stockQuantity: json["stock_quantity"],
    stockStatus: json["stock_status"],
    backOrders: json["backorders"],
    backordersAllowed: json["backorders_allowed"],
    backordered: json["backordered"],
    soldIndividually: json["sold_individually"],
    weight: json["weight"],
    dimensions: json["dimensions"] == null ? null : Dimensions.fromJson(json["dimensions"]),
    shippingRequired: json["shipping_required"],
    shippingTaxable: json["shipping_taxable"],
    shippingClass: json["shipping_class"],
    shippingClassId: json["shipping_class_id"],
    reviewsAllowed: json["reviews_allowed"],
    averageRating: json["average_rating"],
    ratingCount: json["rating_count"],
    relatedIds: json["related_ids"] == null ? null : List<int>.from(json["related_ids"].map((x) => x)),
    upsellIds: json["upsell_ids"] == null ? null : List<dynamic>.from(json["upsell_ids"].map((x) => x)),
    crossSellIds: json["cross_sell_ids"] == null ? null : List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
    parentId: json["parent_id"],
    purchaseNote: json["purchase_note"],
    categories: json["categories"] == null ? null : List<ProductCategory>.from(json["categories"].map((x) => ProductCategory.fromJson(x))),
    tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
    images: json["images"] == null ? null : List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
    attributes: json["attributes"] == null ? null : List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    defaultAttributes: json["default_attributes"] == null ? null : List<DefaultAttribute>.from(json["default_attributes"].map((x) => DefaultAttribute.fromJson(x))),
    variations: json["variations"] == null ? null : List<dynamic>.from(json["variations"].map((x) => x)),
    groupedProducts: json["grouped_products"] == null ? null : List<dynamic>.from(json["grouped_products"].map((x) => x)),
    menuOrder: json["menu_order"],
    metaData: json["meta_data"] == null ? null : List<dynamic>.from(json["meta_data"].map((x) => x)),
    links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
    decimals: json["decimals"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "permalink": permalink,
    "type": type,
    "status": status,
    "featured": featured,
    "catalog_visibility": catalogVisibility,
    "description": description,
    "short_description": shortDescription,
    "sku": sku,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "date_on_sale_from": dateOnSaleFrom,
    "date_on_sale_from_gmt": dateOnSaleFromGmt,
    "date_on_sale_to": dateOnSaleTo,
    "date_on_sale_to_gmt": dateOnSaleToGmt,
    "price_html": priceHtml,
    "on_sale": onSale,
    "purchasable": purchasable,
    "total_sales": totalSales,
    "virtual": virtual,
    "downloadable": downloadable,
    "downloads": downloads == null ? null : List<dynamic>.from(downloads.map((x) => x)),
    "download_limit": downloadLimit,
    "download_expiry": downloadExpiry,
    "external_url": externalUrl,
    "button_text": buttonText,
    "tax_status": taxStatus,
    "tax_class": taxClass,
    "manage_stock": manageStock,
    "stock_quantity": stockQuantity,
    "stock_status": stockStatus,
    "backorders": backOrders,
    "backorders_allowed": backordersAllowed,
    "backordered": backordered,
    "sold_individually": soldIndividually,
    "weight": weight,
    "dimensions": dimensions?.toJson(),
    "shipping_required": shippingRequired,
    "shipping_taxable": shippingTaxable,
    "shipping_class": shippingClass,
    "shipping_class_id": shippingClassId,
    "reviews_allowed": reviewsAllowed,
    "average_rating": averageRating,
    "rating_count": ratingCount,
    "related_ids": relatedIds == null ? null : List<dynamic>.from(relatedIds.map((x) => x)),
    "upsell_ids": upsellIds == null ? null : List<dynamic>.from(upsellIds.map((x) => x)),
    "cross_sell_ids": crossSellIds == null ? null : List<dynamic>.from(crossSellIds.map((x) => x)),
    "parent_id": parentId,
    "purchase_note": purchaseNote,
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
    "attributes": attributes == null ? null : List<dynamic>.from(attributes.map((x) => x.toJson())),
    "default_attributes": defaultAttributes == null ? null : List<dynamic>.from(defaultAttributes.map((x) => x.toJson())),
    "variations": variations == null ? null : List<dynamic>.from(variations.map((x) => x)),
    "grouped_products": groupedProducts == null ? null : List<dynamic>.from(groupedProducts.map((x) => x)),
    "menu_order": menuOrder,
    "meta_data": metaData == null ? null : List<dynamic>.from(metaData.map((x) => x)),
    "vendor": vendor,
    //"_links": links == null ? null : links.toJson(),
  };
}

class Attribute {
  int id;
  String name;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    visible: json["visible"],
    variation: json["variation"],
    options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "position": position,
    "visible": visible,
    "variation": variation,
    "options": options == null ? null : List<dynamic>.from(options.map((x) => x)),
  };
}

class ProductCategory {
  int id;
  String name;
  String slug;

  ProductCategory({
    this.id,
    this.name,
    this.slug,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class DefaultAttribute {
  int id;
  String name;
  String option;

  DefaultAttribute({
    this.id,
    this.name,
    this.option,
  });

  factory DefaultAttribute.fromJson(Map<String, dynamic> json) => DefaultAttribute(
    id: json["id"],
    name: json["name"],
    option: json["option"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "option": option,
  };
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
    length: json["length"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "length": length,
    "width": width,
    "height": height,
  };
}

class ProductImage {
  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  ProductImage({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
    dateCreatedGmt: json["date_created_gmt"] == null ? null : DateTime.parse(json["date_created_gmt"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    dateModifiedGmt: json["date_modified_gmt"] == null ? null : DateTime.parse(json["date_modified_gmt"]),
    src: json["src"],
    name: json["name"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    //"date_created": dateCreated == null ? null : dateCreated.toIso8601String(),
    //"date_created_gmt": dateCreatedGmt == null ? null : dateCreatedGmt.toIso8601String(),
    //"date_modified": dateModified == null ? null : dateModified.toIso8601String(),
    //"date_modified_gmt": dateModifiedGmt == null ? null : dateModifiedGmt.toIso8601String(),
    "src": src,
    "name": name,
    "alt": alt,
  };
}

class Links {
  List<Collection> self;
  List<Collection> collection;

  Links({
    this.self,
    this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"] == null ? null : List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: json["collection"] == null ? null : List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": collection == null ? null : List<dynamic>.from(collection.map((x) => x.toJson())),
  };
}

class Collection {
  String href;

  Collection({
    this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}
