// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

CartModel cartFromJson(String str) => CartModel.fromJson(json.decode(str));

class CartModel {
  List<dynamic> appliedCoupons;
  String taxDisplayCart;
  CartSessionData cartSessionData;
  List<dynamic> couponAppliedCount;
  List<dynamic> couponDiscountTotals;
  List<dynamic> couponDiscountTaxTotals;
  List<CartContent> cartContents;
  String cartNonce;
  CartTotals cartTotals;
  List<dynamic> chosenShipping;
  Points points;
  int purchasePoint;
  String currency;
  List<CartFee> cartFees;
  List<Coupon> coupons;

  CartModel({
    this.appliedCoupons,
    this.taxDisplayCart,
    this.cartSessionData,
    this.couponAppliedCount,
    this.couponDiscountTotals,
    this.couponDiscountTaxTotals,
    this.cartContents,
    this.cartNonce,
    this.cartTotals,
    this.chosenShipping,
    this.points,
    this.purchasePoint,
    this.currency,
    this.cartFees,
    this.coupons
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      //appliedCoupons: json["applied_coupons"] == null ? null : new List<dynamic>.from(json["applied_coupons"].map((x) => x)),
      //taxDisplayCart: json["tax_display_cart"] == null ? null : json["tax_display_cart"],
      //cartSessionData: json["cart_session_data"] == null ? null : CartSessionData.fromJson(json["cart_session_data"]),
      //couponAppliedCount: json["coupon_applied_count"] == null ? null : new List<dynamic>.from(json["coupon_applied_count"].map((x) => x)),
      //couponDiscountTotals: json["coupon_discount_totals"] == null ? null : new List<dynamic>.from(json["coupon_discount_totals"].map((x) => x)),
      //couponDiscountTaxTotals: json["coupon_discount_tax_totals"] == null ? null : new List<dynamic>.from(json["coupon_discount_tax_totals"].map((x) => x)),
      cartContents: json["cartContents"] == null ? null : List<CartContent>.from(json["cartContents"].map((x) => CartContent.fromJson(x))),
      cartNonce: json["cart_nonce"],
      cartTotals: json["cart_totals"] == null ? null : CartTotals.fromJson(json["cart_totals"]),
      //chosenShipping: (json["chosen_shipping"] == false || json["chosen_shipping"] == null) ? null : new List<dynamic>.from(json["chosen_shipping"].map((x) => x)),
      points: json["points"] == null ? null : Points.fromJson(json["points"]),
      //purchasePoint: json["purchase_point"] == null ? null : json["purchase_point"],
      currency: json["currency"] ?? 'USD',
      cartFees: json["cart_fees"] == null ? null : List<CartFee>.from(json["cart_fees"].map((x) => CartFee.fromJson(x))),
      coupons: json["coupons"] == null ? null : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
    );
  }
}

class CartFee {
  CartFee({
    this.id,
    this.name,
    this.total,
  });

  String id;
  String name;
  String amount;
  String total;

  factory CartFee.fromJson(Map<String, dynamic> json) => CartFee(
    id: json["id"],
    name: json["name"],
    total: json["total"],
  );
}

class Coupon {
  Coupon({
    this.code,
    this.amount,
  });

  String code;
  String amount;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    code: json["code"],
    amount: json["amount"],
  );
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}

class LineTaxData {
  List<dynamic> subtotal;
  List<dynamic> total;

  LineTaxData({
    this.subtotal,
    this.total,
  });

  factory LineTaxData.fromJson(Map<String, dynamic> json) => LineTaxData(
    subtotal: json["subtotal"] == null ? null : List<dynamic>.from(json["subtotal"].map((x) => x)),
    total: json["total"] == null ? null : List<dynamic>.from(json["total"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal == null ? null : List<dynamic>.from(subtotal.map((x) => x)),
    "total": total == null ? null : List<dynamic>.from(total.map((x) => x)),
  };
}

class VariationClass {
  String attributePaColor;
  String attributePaSize;

  VariationClass({
    this.attributePaColor,
    this.attributePaSize,
  });

  factory VariationClass.fromJson(Map<String, dynamic> json) => VariationClass(
    attributePaColor: json["attribute_pa_Color"],
    attributePaSize: json["attribute_pa_Size"],
  );

  Map<String, dynamic> toJson() => {
    "attribute_pa_Color": attributePaColor,
    "attribute_pa_Size": attributePaSize,
  };
}

class CartContent {
  List<dynamic> addons;
  String key;
  int productId;
  int variationId;
  dynamic variation;
  int quantity;
  String dataHash;
  //LineTaxData lineTaxData;
  double lineSubtotal;
  double lineSubtotalTax;
  double lineTotal;
  double lineTax;
  Data data;
  String name;
  String thumb;
  String removeUrl;
  double price;
  double taxPrice;
  double regularPrice;
  double salesPrice;
  bool loadingQty;
  String formattedPrice;
  String formattedSalesPrice;
  int parentId;


  CartContent({
    this.addons,
    this.key,
    this.productId,
    this.variationId,
    this.variation,
    this.quantity,
    this.dataHash,
    //this.lineTaxData,
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTax,
    this.data,
    this.name,
    this.thumb,
    this.removeUrl,
    this.price,
    this.taxPrice,
    this.regularPrice,
    this.salesPrice,
    this.loadingQty,
    this.formattedPrice,
    this.formattedSalesPrice,
    this.parentId
  });

  factory CartContent.fromJson(Map<String, dynamic> json) => CartContent(
    addons: json["addons"] == null ? null : List<dynamic>.from(json["addons"].map((x) => x)),
    key: json["key"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    variation: json["variation"],
    quantity: json["quantity"] == null ? null : json["quantity"] is int ? json["quantity"] : int.parse(json["quantity"]),
    dataHash: json["data_hash"],
    //lineTaxData: json["line_tax_data"] == null ? null : LineTaxData.fromJson(json["line_tax_data"]),
    lineSubtotal: json["line_subtotal"]?.toDouble(),
    lineSubtotalTax: json["line_subtotal_tax"]?.toDouble(),
    lineTotal: json["line_total"]?.toDouble(),
    lineTax: json["line_tax"]?.toDouble(),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    name: json["name"],
    thumb: json["thumb"],
    removeUrl: json["remove_url"],
    price: json["price"]?.toDouble(),
    taxPrice: json["tax_price"],
    regularPrice: json["regular_price"]?.toDouble(),
    salesPrice: json["sales_price"]?.toDouble(),
    formattedPrice: json["formated_price"],
    formattedSalesPrice: json["formated_sales_price"],
    loadingQty: false,
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "addons": addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
    "key": key,
    "product_id": productId,
    "variation_id": variationId,
    "variation": variation,
    "quantity": quantity,
    "data_hash": dataHash,
    //"line_tax_data": lineTaxData == null ? null : lineTaxData.toJson(),
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_tax": lineTax,
    "data": data?.toJson(),
    "name": name,
    "thumb": thumb,
    "remove_url": removeUrl,
    "price": price,
    "regular_price": regularPrice,


  };
}

class CartSessionData {
  int cartContentsTotal;
  int total;
  int subtotal;
  int subtotalExTax;
  int taxTotal;
  List<dynamic> taxes;
  List<dynamic> shippingTaxes;
  int discountCart;
  int discountCartTax;
  int shippingTotal;
  int shippingTaxTotal;
  List<dynamic> couponDiscountAmounts;
  List<dynamic> couponDiscountTaxAmounts;
  int feeTotal;
  List<dynamic> fees;

  CartSessionData({
    this.cartContentsTotal,
    this.total,
    this.subtotal,
    this.subtotalExTax,
    this.taxTotal,
    this.taxes,
    this.shippingTaxes,
    this.discountCart,
    this.discountCartTax,
    this.shippingTotal,
    this.shippingTaxTotal,
    this.couponDiscountAmounts,
    this.couponDiscountTaxAmounts,
    this.feeTotal,
    this.fees,
  });

  factory CartSessionData.fromJson(Map<String, dynamic> json) => CartSessionData(
    cartContentsTotal: json["cart_contents_total"],
    total: json["total"],
    subtotal: json["subtotal"],
    subtotalExTax: json["subtotal_ex_tax"],
    taxTotal: json["tax_total"],
    taxes: json["taxes"] == null ? null : List<dynamic>.from(json["taxes"].map((x) => x)),
    shippingTaxes: json["shipping_taxes"] == null ? null : List<dynamic>.from(json["shipping_taxes"].map((x) => x)),
    discountCart: json["discount_cart"],
    discountCartTax: json["discount_cart_tax"],
    shippingTotal: json["shipping_total"],
    shippingTaxTotal: json["shipping_tax_total"],
    couponDiscountAmounts: json["coupon_discount_amounts"] == null ? null : List<dynamic>.from(json["coupon_discount_amounts"].map((x) => x)),
    couponDiscountTaxAmounts: json["coupon_discount_tax_amounts"] == null ? null : List<dynamic>.from(json["coupon_discount_tax_amounts"].map((x) => x)),
    feeTotal: json["fee_total"],
    fees: json["fees"] == null ? null : List<dynamic>.from(json["fees"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "cart_contents_total": cartContentsTotal,
    "total": total,
    "subtotal": subtotal,
    "subtotal_ex_tax": subtotalExTax,
    "tax_total": taxTotal,
    "taxes": taxes == null ? null : List<dynamic>.from(taxes.map((x) => x)),
    "shipping_taxes": shippingTaxes == null ? null : List<dynamic>.from(shippingTaxes.map((x) => x)),
    "discount_cart": discountCart,
    "discount_cart_tax": discountCartTax,
    "shipping_total": shippingTotal,
    "shipping_tax_total": shippingTaxTotal,
    "coupon_discount_amounts": couponDiscountAmounts == null ? null : List<dynamic>.from(couponDiscountAmounts.map((x) => x)),
    "coupon_discount_tax_amounts": couponDiscountTaxAmounts == null ? null : List<dynamic>.from(couponDiscountTaxAmounts.map((x) => x)),
    "fee_total": feeTotal,
    "fees": fees == null ? null : List<dynamic>.from(fees.map((x) => x)),
  };
}

class CartTotals {
  String subtotal;
  String subtotalTax;
  String shippingTotal;
  String shippingTax;
  //List<dynamic> shippingTaxes;
  String discountTotal;
  String discountTax;
  String cartContentsTotal;
  String cartContentsTax;
  //List<dynamic> cartContentsTaxes;
  String feeTotal;
  String feeTax;
  //List<dynamic> feeTaxes;
  String total;
  String totalTax;

  CartTotals({
    this.subtotal,
    this.subtotalTax,
    this.shippingTotal,
    this.shippingTax,
    //this.shippingTaxes,
    this.discountTotal,
    this.discountTax,
    this.cartContentsTotal,
    this.cartContentsTax,
    //this.cartContentsTaxes,
    this.feeTotal,
    this.feeTax,
    //this.feeTaxes,
    this.total,
    this.totalTax,
  });

  factory CartTotals.fromJson(Map<String, dynamic> json) => CartTotals(
    subtotal: json["subtotal"] == 0 ? '0' : json["subtotal"],
    subtotalTax: (json["subtotal_tax"] == null || json["subtotal_tax"] == 0) ? null : json["subtotal_tax"],
    shippingTotal: json["shipping_total"] == 0 ? '0' : json["shipping_total"],
    //shippingTax: json["shipping_tax"] == null ? null : json["shipping_tax"],
    //shippingTaxes: json["shipping_taxes"] == null ? null : new List<dynamic>.from(json["shipping_taxes"].map((x) => x)),
    discountTotal: json["discount_total"]?.toString(),
    //discountTax: json["discount_tax"] == null ? null : json["discount_tax"],
    cartContentsTotal: json["cart_contents_total"] == 0 ? '0' : json["cart_contents_total"],
    //cartContentsTax: json["cart_contents_tax"] == null ? null : json["cart_contents_tax"],
    //cartContentsTaxes: json["cart_contents_taxes"] == null ? null : new List<dynamic>.from(json["cart_contents_taxes"].map((x) => x)),
    feeTotal: json["fee_total"] == 0 ? '0' : json["fee_total"],
    //feeTax: json["fee_tax"] == null ? null : json["fee_tax"],
    //feeTaxes: json["fee_taxes"] == null ? null : new List<dynamic>.from(json["fee_taxes"].map((x) => x)),
    total: json["total"] == 0 ? '0' : json["total"],
    totalTax: json["total_tax"]?.toString(),
  );

}

class Points {
  int points;
  double discountAvailable;
  String message;

  Points({
    this.points,
    this.discountAvailable,
    this.message,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    points: json["points"],
    discountAvailable: json["discount_available"] == null || json["discount_available"] == false ? null : double.parse(json["discount_available"].toString()),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
    "discount_available": discountAvailable,
    "message": message,
  };
}

class Content {
  List<dynamic> addons;
  String key;
  int productId;
  int variationId;
  dynamic variation;
  int quantity;
  String dataHash;
  LineTaxData lineTaxData;
  int lineSubtotal;
  int lineSubtotalTax;
  int lineTotal;
  int lineTax;
  Data data;

  Content({
    this.addons,
    this.key,
    this.productId,
    this.variationId,
    this.variation,
    this.quantity,
    this.dataHash,
    this.lineTaxData,
    this.lineSubtotal,
    this.lineSubtotalTax,
    this.lineTotal,
    this.lineTax,
    this.data,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    addons: json["addons"] == null ? null : List<dynamic>.from(json["addons"].map((x) => x)),
    key: json["key"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    variation: json["variation"],
    quantity: json["quantity"],
    dataHash: json["data_hash"],
    lineTaxData: json["line_tax_data"] == null ? null : LineTaxData.fromJson(json["line_tax_data"]),
    lineSubtotal: json["line_subtotal"],
    lineSubtotalTax: json["line_subtotal_tax"],
    lineTotal: json["line_total"],
    lineTax: json["line_tax"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "addons": addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
    "key": key,
    "product_id": productId,
    "variation_id": variationId,
    "variation": variation,
    "quantity": quantity,
    "data_hash": dataHash,
    "line_tax_data": lineTaxData?.toJson(),
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_tax": lineTax,
    "data": data?.toJson(),
  };
}

class Destination {
  String country;
  String state;
  String postcode;
  String city;
  String address;
  String address2;

  Destination({
    this.country,
    this.state,
    this.postcode,
    this.city,
    this.address,
    this.address2,
  });

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
    country: json["country"],
    state: json["state"],
    postcode: json["postcode"],
    city: json["city"],
    address: json["address"],
    address2: json["address_2"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "state": state,
    "postcode": postcode,
    "city": city,
    "address": address,
    "address_2": address2,
  };
}

class User {
  int id;

  User({
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
  };
}

class ShippingMethod {
  String id;
  String label;
  String cost;
  String methodId;
  List<dynamic> taxes;

  ShippingMethod({
    this.id,
    this.label,
    this.cost,
    this.methodId,
    this.taxes,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
    id: json["id"],
    label: json["label"],
    cost: json["cost"],
    methodId: json["method_id"],
    taxes: json["taxes"] == null ? null : List<dynamic>.from(json["taxes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "cost": cost,
    "method_id": methodId,
    "taxes": taxes == null ? null : List<dynamic>.from(taxes.map((x) => x)),
  };
}
