// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

List<Product> productModelFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
  int id;
  String name;
  String type;
  String status;
  bool featured;
  String catalogVisibility;
  String description;
  String shortDescription;
  String permalink;
  String sku;
  double price;
  double regularPrice;
  double salePrice;
  //DateTime dateOnSaleFromGmt;
  //DateTime dateOnSaleToGmt;
  bool onSale;
  bool purchasable;
  int totalSales;
  bool virtual;
  bool downloadable;
  String externalUrl;
  String buttonText;
  bool manageStock;
  int stockQuantity;
  String stockStatus;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  bool soldIndividually;
  String weight;
  Dimensions dimensions;
  //bool shippingRequired;
  //bool shippingTaxable;
  //String shippingClass;
  bool reviewsAllowed;
  String averageRating;
  int ratingCount;
  List<int> relatedIds;
  List<int> upsellIds;
  List<int> crossSellIds;
  //int parentId;
  String purchaseNote;
  List<int> categories;
  List<dynamic> tags;
  List<Mage> images;
  List<Attribute> attributes;
  List<dynamic> groupedProducts;
  //int menuOrder;
  List<MetaDatum> metaData;
  //String storeName;
  List<AvailableVariation> availableVariations;
  List<VariationOption> variationOptions;
  String variationId;
  String formattedPrice;
  String formattedSalesPrice;
  Vendor vendor;
  List<Product> children;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.permalink,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    //this.dateOnSaleFromGmt,
    //this.dateOnSaleToGmt,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.externalUrl,
    required this.buttonText,
    required this.manageStock,
    required this.stockQuantity,
    required this.stockStatus,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    required this.soldIndividually,
    required this.weight,
    required this.dimensions,
    //this.shippingRequired,
    //this.shippingTaxable,
    //this.shippingClass,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.relatedIds,
    required this.upsellIds,
    required this.crossSellIds,
    //this.parentId,
    required this.purchaseNote,
    required this.categories,
    required this.tags,
    required this.images,
    required this.attributes,
    required this.groupedProducts,
    //this.menuOrder,
    required this.metaData,
    //this.storeName,
    required this.availableVariations,
    required this.variationOptions,
    required this.variationId,
    required this.formattedPrice,
    required this.formattedSalesPrice,
    required this.vendor,
    required this.children
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    status: json["status"],
    featured: json["featured"],
    catalogVisibility: json["catalog_visibility"],
    description: json["description"],
    shortDescription: json["short_description"],
    permalink: json["permalink"],
    sku: json["sku"],
    formattedPrice: json["formated_price"],
    formattedSalesPrice: json["formated_sales_price"],
    price: json["price"]?.toDouble(),
    regularPrice: json["regular_price"]?.toDouble(),
    salePrice: json["sale_price"]?.toDouble(),
    //dateOnSaleFromGmt: json["date_on_sale_from_gmt"] == null ? null : DateTime.parse(json["date_on_sale_from_gmt"]),
    //dateOnSaleToGmt: json["date_on_sale_to_gmt"] == null ? null : DateTime.parse(json["date_on_sale_to_gmt"]),
    onSale: json["on_sale"],
    purchasable: json["purchasable"],
    totalSales: json["total_sales"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
    externalUrl: json["external_url"],
    buttonText: json["button_text"],
    manageStock: json["manage_stock"],
    stockQuantity: json["stock_quantity"],
    stockStatus: json["stock_status"],
    backorders: json["backorders"],
    backordersAllowed: json["backorders_allowed"],
    backordered: json["backordered"],
    soldIndividually: json["sold_individually"],
    weight: json["weight"],
    dimensions: json["dimensions"] == null ? Dimensions(length: '', width: '', height: '') : Dimensions.fromJson(json["dimensions"]),
    //shippingRequired: json["shipping_required"] == null ? null : json["shipping_required"],
    //shippingTaxable: json["shipping_taxable"] == null ? null : json["shipping_taxable"],
    //shippingClass: json["shipping_class"] == null ? null : json["shipping_class"],
    reviewsAllowed: json["reviews_allowed"],
    averageRating: json["average_rating"],
    ratingCount: json["rating_count"],
    relatedIds: json["related_ids"] == null ? [] : List<int>.from(json["related_ids"].map((x) => x)),
    upsellIds: json["upsell_ids"] == null ? [] : List<int>.from(json["upsell_ids"].map((x) => x)),
    crossSellIds: json["cross_sell_ids"] == null ? [] : List<int>.from(json["cross_sell_ids"].map((x) => x)),
    //parentId: json["parent_id"] == null ? null : json["parent_id"],
    purchaseNote: json["purchase_note"],
    categories: json["categories"] == null ? [] :  List<int>.from(json["categories"].map((x) => x)),
    tags:  json["tags"] == null ? [] : List<dynamic>.from(json["tags"].map((x) => x)),
    images:   json["images"] == null ? [] : List<Mage>.from(json["images"].map((x) => Mage.fromJson(x))),
    attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    groupedProducts:json["grouped_products"] == null ? [] : List<dynamic>.from(json["grouped_products"].map((x) => x)),
    //menuOrder: json["menu_order"] == null ? null : json["menu_order"],
    metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    //storeName: json["store_name"] == null ? null : json["store_name"],
    availableVariations: json["availableVariations"] == null ? [] : List<AvailableVariation>.from(json["availableVariations"].map((x) => AvailableVariation.fromJson(x))),
    variationOptions: json["variationOptions"] == null ? [] : List<VariationOption>.from(json["variationOptions"].map((x) => VariationOption.fromJson(x))),
    variationId: "",
    vendor: json["vendor"] == null ? Vendor(name: '', icon: '') : Vendor.fromJson(json["vendor"]),
    children: json["children"] == null ? [] : List<Product>.from(json["children"].map((x) => Product.fromJson(x))),
  );
}


class Vendor {
  dynamic id;
  String name;
  String icon;

  Vendor({
    this.id,
    required this.name,
    required this.icon,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    name: json["name"],
    icon: json["icon"] == null || json["icon"] == false ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
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
    required this.id,
    required this.name,
    required this.position,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    visible: json["visible"],
    variation: json["variation"],
    options:  json["options"] == null ? [] : List<String>.from(json["options"].map((x) => x)),
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
    required this.id,
    required this.name,
    required this.slug,
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

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({
    required this.length,
    required this.width,
    required this.height,
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

class Mage {
  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  Mage({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory Mage.fromJson(Map<String, dynamic> json) => Mage(
    id: json["id"],
    dateCreated: json["date_created"] == null ? DateTime.now() : DateTime.parse(json["date_created"]),
    dateCreatedGmt:  json["date_created_gmt"] == null ? DateTime.now() : DateTime.parse(json["date_created_gmt"]),
    dateModified:  json["date_modified"] == null ? DateTime.now() : DateTime.parse(json["date_modified"]),
    dateModifiedGmt: json["date_modified_gmt"] == null ? DateTime.now() : DateTime.parse(json["date_modified_gmt"]),
    src: json["src"],
    name: json["name"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated.toIso8601String(),
    "date_created_gmt": dateCreatedGmt.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "src": src,
    "name": name,
    "alt": alt,
  };
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

class AvailableVariation {
  String availabilityHtml;
  bool backordersAllowed;
  Dimensions dimensions;
  String dimensionsHtml;
  double displayPrice;
  double displayRegularPrice;
  AvailableVariationImage image;
  String imageId;
  bool isDownloadable;
  bool isInStock;
  bool isPurchasable;
  String isSoldIndividually;
  bool isVirtual;
  int maxQty;
  int minQty;
  String priceHtml;
  String sku;
  String variationDescription;
  int variationId;
  bool variationIsActive;
  bool variationIsVisible;
  String weight;
  String weightHtml;
  List<Option> option;
  String formattedPrice;
  String formattedSalesPrice;

  AvailableVariation({
    required this.availabilityHtml,
    required this.backordersAllowed,
    required this.dimensions,
    required this.dimensionsHtml,
    required this.displayPrice,
    required this.displayRegularPrice,
    required this.image,
    required this.imageId,
    required this.isDownloadable,
    required this.isInStock,
    required this.isPurchasable,
    required this.isSoldIndividually,
    required this.isVirtual,
    required this.maxQty,
    required this.minQty,
    required this.priceHtml,
    required this.sku,
    required this.variationDescription,
    required this.variationId,
    required this.variationIsActive,
    required this.variationIsVisible,
    required this.weight,
    required this.weightHtml,
    required this.option,
    required this.formattedPrice,
    required this.formattedSalesPrice
  });

  factory AvailableVariation.fromJson(Map<String, dynamic> json) {
    return AvailableVariation(
    //availabilityHtml: json["availability_html"] == null ? null : json["availability_html"],
    backordersAllowed: json["backorders_allowed"],
    dimensions: json["dimensions"] == null ? Dimensions(length: '', width: '', height: '') : Dimensions.fromJson(json["dimensions"]),
    //dimensionsHtml: json["dimensions_html"] == null ? null : json["dimensions_html"],
    displayPrice: json["display_price"]?.toDouble(),
    displayRegularPrice: json["display_regular_price"]?.toDouble(),
    image: json['image'] is Map<String, dynamic> ? AvailableVariationImage.fromJson(json["image"]) : AvailableVariationImage(
      title: '',
      caption: '',
      url: '',
      src: '',
      sizes: '',
      fullSrc: '',
      fullSrcW: 0,
      fullSrcH: 0,
      galleryThumbnailSrc: '',
      galleryThumbnailSrcW: 0,
      galleryThumbnailSrcH: 0,
      thumbSrc: '',
      thumbSrcW: 0,
      thumbSrcH: 0,
      srcW: 0,
      srcH: 0,
    ),
    //imageId: json["image_id"] == null ? null : json["image_id"],
    //isDownloadable: json["is_downloadable"] == null ? null : json["is_downloadable"],
    isInStock: json["is_in_stock"],
    isPurchasable: json["is_purchasable"],
    //isSoldIndividually: json["is_sold_individually"] == null ? null : json["is_sold_individually"],
    //isVirtual: json["is_virtual"] == null ? null : json["is_virtual"],
    //maxQty: (json["max_qty"] == null || json["max_qty"] == '') ? null : json["max_qty"],
    //minQty: json["min_qty"] == null ? null : json["min_qty"],
    //priceHtml: json["price_html"] == null ? null : json["price_html"],
    sku: json["sku"],
    variationDescription: json["variation_description"],
    variationId: json["variation_id"],
    //variationIsActive: json["variation_is_active"] == null ? null : json["variation_is_active"],
    //variationIsVisible: json["variation_is_visible"] == null ? null : json["variation_is_visible"],
    //weight: json["weight"] == null ? null : json["weight"],
    //weightHtml: json["weight_html"] == null ? null : json["weight_html"],
    option: json["option"] == null ? [] : List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
    formattedPrice: json["formated_price"],
    formattedSalesPrice: json["formated_sales_price"], availabilityHtml: '', dimensionsHtml: '', imageId: '', isDownloadable: false,isSoldIndividually: "",isVirtual: false,maxQty: 0,minQty: 0,priceHtml: "",variationIsActive: false,variationIsVisible: false,weight: "",weightHtml: ""
  );
  }
}

class Option {
  String key;
  String value;

  Option({
    required this.key,
    required this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

class AvailableVariationImage {
  String title;
  String caption;
  String url;
  //String alt;
  String src;
  //String srcset;
  String sizes;
  String fullSrc;
  int fullSrcW;
  int fullSrcH;
  String galleryThumbnailSrc;
  int galleryThumbnailSrcW;
  int galleryThumbnailSrcH;
  String thumbSrc;
  int thumbSrcW;
  int thumbSrcH;
  int srcW;
  int srcH;

  AvailableVariationImage({
    required this.title,
    required this.caption,
    required this.url,
    //this.alt,
    required this.src,
    //this.srcset,
    required this.sizes,
    required this.fullSrc,
    required this.fullSrcW,
    required this.fullSrcH,
    required this.galleryThumbnailSrc,
    required this.galleryThumbnailSrcW,
    required this.galleryThumbnailSrcH,
    required this.thumbSrc,
    required this.thumbSrcW,
    required this.thumbSrcH,
    required this.srcW,
    required this.srcH,
  });

  factory AvailableVariationImage.fromJson(Map<String, dynamic> json) => AvailableVariationImage(
    title: json["title"],
    //caption: json["caption"] == null ? null : json["caption"],
    url: json["url"],
    //alt: json["alt"] == null ? null : json["alt"],
    src: json["src"],
    //srcset: json["srcset"] == null ? null : json["srcset"],
    //sizes: json["sizes"] == null ? null : json["sizes"],
    fullSrc: json["full_src"],
    //fullSrcW: json["full_src_w"] == null ? null : json["full_src_w"],
    //fullSrcH: json["full_src_h"] == null ? null : json["full_src_h"],
    galleryThumbnailSrc: json["gallery_thumbnail_src"],
    //galleryThumbnailSrcW: json["gallery_thumbnail_src_w"] == null ? null : json["gallery_thumbnail_src_w"],
    //galleryThumbnailSrcH: json["gallery_thumbnail_src_h"] == null ? null : json["gallery_thumbnail_src_h"],
    thumbSrc: json["thumb_src"], caption: '', sizes: '', fullSrcW: 0, fullSrcH: 0, galleryThumbnailSrcW: 0, galleryThumbnailSrcH: 0, thumbSrcW: 0, thumbSrcH: 0, srcW: 0, srcH: 0,
    //thumbSrcW: json["thumb_src_w"] == null ? null : json["thumb_src_w"],
    //thumbSrcH: json["thumb_src_h"] == null ? null : json["thumb_src_h"],
    //srcW: json["src_w"] == null ? null : json["src_w"],
    //srcH: json["src_h"] == null ? null : json["src_h"],
  );
}

class VariationOption {
  String name;
  List<String> options;
  String attribute;
  String selected;

  VariationOption({
    required this.name,
    required this.options,
    required this.attribute,
    required this.selected,
  });

  factory VariationOption.fromJson(Map<String, dynamic> json) => VariationOption(
    name: json["name"],
    options: json["options"] == null ? [] : List<String>.from(json["options"].map((x) => x)),
    attribute: json["attribute"],
    selected: "",
  );
}

