// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'customer_model.dart';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int id;
  int parentId;
  String number;
  String orderKey;
  String createdVia;
  String version;
  String status;
  String currency;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  bool pricesIncludeTax;
  int customerId;
  String customerIpAddress;
  String customerUserAgent;
  String customerNote;
  Address billing;
  Address shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  dynamic datePaid;
  dynamic datePaidGmt;
  dynamic dateCompleted;
  dynamic dateCompletedGmt;
  String cartHash;
  List<MetaDatum> metaData;
  List<LineItem> lineItems;
  List<dynamic> taxLines;
  List<ShippingLine> shippingLines;
  List<dynamic> feeLines;
  List<dynamic> couponLines;
  List<dynamic> refunds;
  int decimals;

  Order({
    this.id,
    this.parentId,
    this.number,
    this.orderKey,
    this.createdVia,
    this.version,
    this.status,
    this.currency,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.pricesIncludeTax,
    this.customerId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.dateCompleted,
    this.dateCompletedGmt,
    this.cartHash,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.decimals,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    parentId: json["parent_id"],
    number: json["number"],
    orderKey: json["order_key"],
    createdVia: json["created_via"],
    version: json["version"],
    status: json["status"],
    currency: json["currency"],
    dateCreated: json["date_created"] == null ? null : DateTime.parse(json["date_created"]),
    dateCreatedGmt: json["date_created_gmt"] == null ? null : DateTime.parse(json["date_created_gmt"]),
    dateModified: json["date_modified"] == null ? null : DateTime.parse(json["date_modified"]),
    dateModifiedGmt: json["date_modified_gmt"] == null ? null : DateTime.parse(json["date_modified_gmt"]),
    discountTotal: json["discount_total"],
    discountTax: json["discount_tax"],
    shippingTotal: json["shipping_total"],
    shippingTax: json["shipping_tax"],
    cartTax: json["cart_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    pricesIncludeTax: json["prices_include_tax"],
    customerId: json["customer_id"],
    customerIpAddress: json["customer_ip_address"],
    customerUserAgent: json["customer_user_agent"],
    customerNote: json["customer_note"],
    billing: json["billing"] == null ? null : Address.fromJson(json["billing"]),
    shipping: json["shipping"] == null ? null : Address.fromJson(json["shipping"]),
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    transactionId: json["transaction_id"],
    datePaid: json["date_paid"],
    datePaidGmt: json["date_paid_gmt"],
    dateCompleted: json["date_completed"],
    dateCompletedGmt: json["date_completed_gmt"],
    cartHash: json["cart_hash"],
    metaData: json["meta_data"] == null ? null : List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    lineItems: json["line_items"] == null ? null : List<LineItem>.from(json["line_items"].map((x) => LineItem.fromJson(x))),
    taxLines: json["tax_lines"] == null ? null : List<dynamic>.from(json["tax_lines"].map((x) => x)),
    shippingLines: json["shipping_lines"] == null ? null : List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
    feeLines: json["fee_lines"] == null ? null : List<dynamic>.from(json["fee_lines"].map((x) => x)),
    couponLines: json["coupon_lines"] == null ? null : List<dynamic>.from(json["coupon_lines"].map((x) => x)),
    refunds: json["refunds"] == null ? null : List<dynamic>.from(json["refunds"].map((x) => x)),
    decimals: json["decimals"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "number": number,
    "order_key": orderKey,
    "created_via": createdVia,
    "version": version,
    "status": status,
    "currency": currency,
    "date_created": dateCreated?.toIso8601String(),
    "date_created_gmt": dateCreatedGmt?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "cart_tax": cartTax,
    "total": total,
    "total_tax": totalTax,
    "prices_include_tax": pricesIncludeTax,
    "customer_id": customerId,
    "customer_ip_address": customerIpAddress,
    "customer_user_agent": customerUserAgent,
    "customer_note": customerNote,
    "billing": billing?.toJson(),
    "shipping": shipping?.toJson(),
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "transaction_id": transactionId,
    "date_paid": datePaid,
    "date_paid_gmt": datePaidGmt,
    "date_completed": dateCompleted,
    "date_completed_gmt": dateCompletedGmt,
    "cart_hash": cartHash,
    "meta_data": metaData == null ? null : List<dynamic>.from(metaData.map((x) => x.toJson())),
    "line_items": lineItems == null ? null : List<dynamic>.from(lineItems.map((x) => x.toJson())),
    "tax_lines": taxLines == null ? null : List<dynamic>.from(taxLines.map((x) => x)),
    "shipping_lines": shippingLines == null ? null : List<dynamic>.from(shippingLines.map((x) => x.toJson())),
    "fee_lines": feeLines == null ? null : List<dynamic>.from(feeLines.map((x) => x)),
    "coupon_lines": couponLines == null ? null : List<dynamic>.from(couponLines.map((x) => x)),
    "refunds": refunds == null ? null : List<dynamic>.from(refunds.map((x) => x)),
  };
}

class LineItem {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<LineItemMetaDatum> metaData;
  String sku;
  double price;

  LineItem({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
    this.sku,
    this.price,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    id: json["id"],
    name: json["name"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    quantity: json["quantity"],
    taxClass: json["tax_class"],
    subtotal: json["subtotal"],
    subtotalTax: json["subtotal_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    metaData: json["meta_data"] == null ? null : List<LineItemMetaDatum>.from(json["meta_data"].map((x) => LineItemMetaDatum.fromMap(x))),
    taxes: json["taxes"] == null ? null : List<dynamic>.from(json["taxes"].map((x) => x)),
    sku: json["sku"],
    price: json["price"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "tax_class": taxClass,
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "total": total,
    "total_tax": totalTax,
    "taxes": taxes == null ? null : List<dynamic>.from(taxes.map((x) => x)),
    "meta_data": metaData == null ? null : List<dynamic>.from(metaData.map((x) => x)),
    "sku": sku,
    "price": price,
  };
}


class LineItemMetaDatum {
  LineItemMetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int id;
  String key;
  dynamic value;

  factory LineItemMetaDatum.fromJson(String str) => LineItemMetaDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LineItemMetaDatum.fromMap(Map<String, dynamic> json) => LineItemMetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "key": key,
    "value": value,
  };
}

class MetaDatum {
  int id;
  String key;
  String value;

  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) {
    try {
      return MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );
    } catch (e) {
      return MetaDatum(
        id: json["id"],
        key: json["key"],
        value: null,
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
  };
}

class ShippingLine {
  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<MetaDatum> metaData;

  ShippingLine({
    this.id,
    this.methodTitle,
    this.methodId,
    this.instanceId,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
  });

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
    id: json["id"],
    methodTitle: json["method_title"],
    methodId: json["method_id"],
    instanceId: json["instance_id"],
    total: json["total"],
    totalTax: json["total_tax"],
    taxes: json["taxes"] == null ? null : List<dynamic>.from(json["taxes"].map((x) => x)),
    metaData: json["meta_data"] == null ? null : List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_title": methodTitle,
    "method_id": methodId,
    "instance_id": instanceId,
    "total": total,
    "total_tax": totalTax,
    "taxes": taxes == null ? null : List<dynamic>.from(taxes.map((x) => x)),
    "meta_data": metaData == null ? null : List<dynamic>.from(metaData.map((x) => x.toJson())),
  };
}
