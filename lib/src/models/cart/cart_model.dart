// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

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
    required this.appliedCoupons,
    required this.taxDisplayCart,
    required this.cartSessionData,
    required this.couponAppliedCount,
    required this.couponDiscountTotals,
    required this.couponDiscountTaxTotals,
    required this.cartContents,
    required this.cartNonce,
    required this.cartTotals,
    required this.chosenShipping,
    required this.points,
    required this.purchasePoint,
    required this.currency,
    required this.cartFees,
    required this.coupons
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      appliedCoupons: json["applied_coupons"] == null ? [] : List<dynamic>.from(json["applied_coupons"].map((x) => x)),
      taxDisplayCart: json["tax_display_cart"] ?? '',
      cartSessionData: json["cart_session_data"] == null
          ? CartSessionData(
              cartContentsTotal: 0,
              total: 0,
              subtotal: 0,
              subtotalExTax: 0,
              taxTotal: 0,
              taxes: [],
              shippingTaxes: [],
              discountCart: 0,
              discountCartTax: 0,
              shippingTotal: 0,
              shippingTaxTotal: 0,
              couponDiscountAmounts: [],
              couponDiscountTaxAmounts: [],
              feeTotal: 0,
              fees: [],
            )
          : CartSessionData.fromJson(json["cart_session_data"]),
      couponAppliedCount: json["coupon_applied_count"] == null ? [] : List<dynamic>.from(json["coupon_applied_count"].map((x) => x)),
      couponDiscountTotals: json["coupon_discount_totals"] == null ? [] : List<dynamic>.from(json["coupon_discount_totals"].map((x) => x)),
      couponDiscountTaxTotals: json["coupon_discount_tax_totals"] == null ? [] : List<dynamic>.from(json["coupon_discount_tax_totals"].map((x) => x)),
      cartContents: json["cartContents"] == null ? [] : List<CartContent>.from(json["cartContents"].map((x) => CartContent.fromJson(x))),
      cartNonce: json["cart_nonce"] ?? '',
      cartTotals: json["cart_totals"] == null
          ? CartTotals(
              subtotal: '0',
              subtotalTax: '0',
              shippingTotal: '0',
              shippingTax: '0',
              discountTotal: '0',
              discountTax: '0',
              cartContentsTotal: '0',
              cartContentsTax: '0',
              feeTotal: '0',
              feeTax: '0',
              total: '0',
              totalTax: '0',
            )
          : CartTotals.fromJson(json["cart_totals"]),
      chosenShipping: json["chosen_shipping"] == null ? [] : List<dynamic>.from(json["chosen_shipping"].map((x) => x)),
      points: json["points"] == null ? Points(value:0,points: 0, discountAvailable: 0.0, message: '') : Points.fromJson(json["points"]),
      purchasePoint: json["purchase_point"] ?? 0,
      currency: json["currency"] ?? 'USD',
      cartFees: json["cart_fees"] == null ? [] : List<CartFee>.from(json["cart_fees"].map((x) => CartFee.fromJson(x))),
      coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"].map((x) => Coupon.fromJson(x))),
    );
  }
}

class CartFee {
  CartFee({
    required this.id,
    required this.name,
    required this.total,
    required this.amount,
  });

  String id;
  String name;
  String amount;
  String total;

  factory CartFee.fromJson(Map<String, dynamic> json) => CartFee(
    id: json["id"],
    name: json["name"],
    total: json["total"], amount: '',
  );
}

class Coupon {
  Coupon({
    required this.code,
    required this.amount,
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
    required this.subtotal,
    required this.total,
  });

  factory LineTaxData.fromJson(Map<String, dynamic> json) => LineTaxData(
    subtotal: json["subtotal"] == null ? [] : List<dynamic>.from(json["subtotal"].map((x) => x)),
    total: json["total"] == null ? [] : List<dynamic>.from(json["total"].map((x) => x)),
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
    required this.attributePaColor,
    required this.attributePaSize,
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
    required this.addons,
    required this.key,
    required this.productId,
    required this.variationId,
    this.variation,
    required this.quantity,
    required this.dataHash,
    //this.lineTaxData,
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTax,
    required this.data,
    required this.name,
    required this.thumb,
    required this.removeUrl,
    required this.price,
    required this.taxPrice,
    required this.regularPrice,
    required this.salesPrice,
    required this.loadingQty,
    required this.formattedPrice,
    required this.formattedSalesPrice,
    required this.parentId
  });

  factory CartContent.fromJson(Map<String, dynamic> json) => CartContent(
    addons: json["addons"] == null ? [] : List<dynamic>.from(json["addons"].map((x) => x)),
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
    data: json["data"] == null ? Data() : Data.fromJson(json["data"]),
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
    "data": data.toJson(),
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
    required this.cartContentsTotal,
    required this.total,
    required this.subtotal,
    required this.subtotalExTax,
    required this.taxTotal,
    required this.taxes,
    required this.shippingTaxes,
    required this.discountCart,
    required this.discountCartTax,
    required this.shippingTotal,
    required this.shippingTaxTotal,
    required this.couponDiscountAmounts,
    required this.couponDiscountTaxAmounts,
    required this.feeTotal,
    required this.fees,
  });

  factory CartSessionData.fromJson(Map<String, dynamic> json) => CartSessionData(
    cartContentsTotal: json["cart_contents_total"],
    total: json["total"],
    subtotal: json["subtotal"],
    subtotalExTax: json["subtotal_ex_tax"],
    taxTotal: json["tax_total"],
    taxes: json["taxes"] == null ? [] : List<dynamic>.from(json["taxes"].map((x) => x)),
    shippingTaxes: json["shipping_taxes"] == null ? [] : List<dynamic>.from(json["shipping_taxes"].map((x) => x)),
    discountCart: json["discount_cart"],
    discountCartTax: json["discount_cart_tax"],
    shippingTotal: json["shipping_total"],
    shippingTaxTotal: json["shipping_tax_total"],
    couponDiscountAmounts:json["coupon_discount_amounts"] == null ? [] : List<dynamic>.from(json["coupon_discount_amounts"].map((x) => x)),
    couponDiscountTaxAmounts: json["coupon_discount_tax_amounts"] == null ? [] : List<dynamic>.from(json["coupon_discount_tax_amounts"].map((x) => x)),
    feeTotal: json["fee_total"],
    fees: json["fees"] == null ? [] : List<dynamic>.from(json["fees"].map((x) => x)),
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
    required this.subtotal,
    required this.subtotalTax,
    required this.shippingTotal,
    required this.shippingTax,
    //this.shippingTaxes,
    required this.discountTotal,
    required this.discountTax,
    required this.cartContentsTotal,
    required this.cartContentsTax,
    //this.cartContentsTaxes,
    required this.feeTotal,
    required this.feeTax,
    //this.feeTaxes,
    required this.total,
    required this.totalTax,
  });

  factory CartTotals.fromJson(Map<String, dynamic> json) => CartTotals(
    subtotal: json["subtotal"] == 0 ? '0' : json["subtotal"],
    subtotalTax: (json["subtotal_tax"] == null || json["subtotal_tax"] == 0) ? null : json["subtotal_tax"],
    shippingTotal: json["shipping_total"] == 0 ? '0' : json["shipping_total"],
    shippingTax: json["shipping_tax"] ?? '0',
    discountTotal: json["discount_total"]!.toString(),
    discountTax: json["discount_tax"] ?? '0',
    cartContentsTotal: json["cart_contents_total"] == 0 ? '0' : json["cart_contents_total"],
    cartContentsTax: json["cart_contents_tax"] ?? '0',
    feeTotal: json["fee_total"] == 0 ? '0' : json["fee_total"],
    feeTax: json["fee_tax"] ?? '0',
    total: json["total"] == 0 ? '0' : json["total"],
    totalTax: json["total_tax"]!.toString(),
  );

}

class Points {
  int points;
  double discountAvailable;
  String message;

  Points({
    required this.points,
    required this.discountAvailable,
    required this.message, required int value,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    value:json["value"],
    points: json["points"],
    discountAvailable: json["discount_available"] == null || json["discount_available"] == false ? 0.0 : double.parse(json["discount_available"].toString()),
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
    required this.addons,
    required this.key,
    required this.productId,
    required this.variationId,
    this.variation,
    required this.quantity,
    required this.dataHash,
    required this.lineTaxData,
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTax,
    required this.data,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    addons: json["addons"] == null ? [] : List<dynamic>.from(json["addons"].map((x) => x)),
    key: json["key"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    variation: json["variation"],
    quantity: json["quantity"],
    dataHash: json["data_hash"],
    lineTaxData: json["line_tax_data"] == null ? LineTaxData(subtotal: [], total: []) : LineTaxData.fromJson(json["line_tax_data"]),
    lineSubtotal: json["line_subtotal"],
    lineSubtotalTax: json["line_subtotal_tax"],
    lineTotal: json["line_total"],
    lineTax: json["line_tax"],
    data: json["data"] == null ? Data() : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "addons": addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
    "key": key,
    "product_id": productId,
    "variation_id": variationId,
    "variation": variation,
    "quantity": quantity,
    "data_hash": dataHash,
    "line_tax_data": lineTaxData.toJson(),
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_tax": lineTax,
    "data": data.toJson(),
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
    required this.country,
    required this.state,
    required this.postcode,
    required this.city,
    required this.address,
    required this.address2,
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
    required this.id,
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
    required this.id,
    required this.label,
    required this.cost,
    required this.methodId,
    required this.taxes,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
    id: json["id"],
    label: json["label"],
    cost: json["cost"],
    methodId: json["method_id"],
    taxes: json["taxes"] == null ? [] : List<dynamic>.from(json["taxes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "cost": cost,
    "method_id": methodId,
    "taxes": taxes == null ? null : List<dynamic>.from(taxes.map((x) => x)),
  };
}
