// To parse this JSON data, do
//
//     final orderReviewModel = orderReviewModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

OrderReviewModel orderReviewModelFromJson(String str) => OrderReviewModel.fromJson(json.decode(str));

String orderReviewModelToJson(OrderReviewModel data) => json.encode(data.toJson());

class OrderReviewModel {
  String result;
  String messages;
  String reload;
  Cart cart;
  Checkout checkout;
  Totals totals;
  double balance;
  String balanceFormatted;
  Totals totalsUnformatted;
  List<dynamic> chosenShipping;
  List<Shipping> shipping;
  List<WooPaymentMethod> paymentMethods;

  OrderReviewModel({
    required this.result,
    required this.messages,
    required this.reload,
    required this.cart,
    required this.checkout,
    required this.totals,
    required this.balance,
    required this.balanceFormatted,
    required this.chosenShipping,
    required this.shipping,
    required this.paymentMethods,
    required this.totalsUnformatted
  });

  factory OrderReviewModel.fromJson(Map<String, dynamic> json) => OrderReviewModel(
    result: json["result"],
    //messages: json["messages"] == null ? null : json["messages"],
    //reload: json["reload"] == null ? null : json["reload"],
    //cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    //checkout: json["checkout"] == null ? null : Checkout.fromJson(json["checkout"]),
    balance: json["balance"] == null ? 0.0 : json["balance"].toDouble(),
    balanceFormatted: json["balanceFormatted"] ?? '',
    totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
    totalsUnformatted: json["totalsUnformatted"] == null ? null : Totals.fromJson(json["totalsUnformatted"]),
    //chosenShipping: json["chosen_shipping"] == null ? null : new List<dynamic>.from(json["chosen_shipping"].map((x) => x)),
    shipping: json["shipping"] == null ? null : List<Shipping>.from(json["shipping"].map((x) => Shipping.fromJson(x))),
    paymentMethods: json["paymentMethods"] == null ? [] : List<WooPaymentMethod>.from(json["paymentMethods"].map((x) => WooPaymentMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "messages": messages,
    "reload": reload,
    "cart": cart.toJson(),
    "checkout": checkout.toJson(),
    "totals": totals.toJson(),
    "chosen_shipping": chosenShipping == null ? null : List<dynamic>.from(chosenShipping.map((x) => x)),
    "shipping": shipping == null ? null : List<dynamic>.from(shipping.map((x) => x.toJson())),
    "paymentMethods": paymentMethods == null ? null : List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
  };
}

class Cart {
  CartContents cartContents;
  List<dynamic> appliedCoupons;
  String taxDisplayCart;
  CartSessionData cartSessionData;
  List<dynamic> couponAppliedCount;
  List<dynamic> couponDiscountTotals;
  List<dynamic> couponDiscountTaxTotals;

  Cart({
    required this.cartContents,
    required this.appliedCoupons,
    required this.taxDisplayCart,
    required this.cartSessionData,
    required this.couponAppliedCount,
    required this.couponDiscountTotals,
    required this.couponDiscountTaxTotals,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    cartContents: json["cart_contents"] == null ? null : CartContents.fromJson(json["cart_contents"]),
    appliedCoupons: json["applied_coupons"] == null ? null : List<dynamic>.from(json["applied_coupons"].map((x) => x)),
    taxDisplayCart: json["tax_display_cart"],
    cartSessionData: json["cart_session_data"] == null ? null : CartSessionData.fromJson(json["cart_session_data"]),
    couponAppliedCount: json["coupon_applied_count"] == null ? null : List<dynamic>.from(json["coupon_applied_count"].map((x) => x)),
    couponDiscountTotals: json["coupon_discount_totals"] == null ? null : List<dynamic>.from(json["coupon_discount_totals"].map((x) => x)),
    couponDiscountTaxTotals: json["coupon_discount_tax_totals"] == null ? null : List<dynamic>.from(json["coupon_discount_tax_totals"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "cart_contents": cartContents?.toJson(),
    //"removed_cart_contents": removedCartContents == null ? null : new List<dynamic>.from(removedCartContents.map((x) => x)),
    "applied_coupons": appliedCoupons == null ? null : List<dynamic>.from(appliedCoupons.map((x) => x)),
    "tax_display_cart": taxDisplayCart,
    "cart_session_data": cartSessionData?.toJson(),
    "coupon_applied_count": couponAppliedCount == null ? null : List<dynamic>.from(couponAppliedCount.map((x) => x)),
    "coupon_discount_totals": couponDiscountTotals == null ? null : List<dynamic>.from(couponDiscountTotals.map((x) => x)),
    "coupon_discount_tax_totals": couponDiscountTaxTotals == null ? null : List<dynamic>.from(couponDiscountTaxTotals.map((x) => x)),
  };
}

class CartContents {
  The8Da153B3917424A1Cf24A9Cd1D7B4E9D the8Da153B3917424A1Cf24A9Cd1D7B4E9D;
  E610F941894B4A6488Cc1E06655862Ee e610F941894B4A6488Cc1E06655862Ee;

  CartContents({
    required this.the8Da153B3917424A1Cf24A9Cd1D7B4E9D,
    required this.e610F941894B4A6488Cc1E06655862Ee,
  });

  factory CartContents.fromJson(Map<String, dynamic> json) => CartContents(
    the8Da153B3917424A1Cf24A9Cd1D7B4E9D: json["8da153b3917424a1cf24a9cd1d7b4e9d"] == null 
        ? The8Da153B3917424A1Cf24A9Cd1D7B4E9D(addons: [], key: '', productId: 0, variationId: 0, variation: '', quantity: 0, dataHash: '', lineTaxData: LineTaxData(subtotal: [], total: []), lineSubtotal: 0, lineSubtotalTax: 0, lineTotal: 0, lineTax: 0, data: Checkout(), name: '') 
        : The8Da153B3917424A1Cf24A9Cd1D7B4E9D.fromJson(json["8da153b3917424a1cf24a9cd1d7b4e9d"]),
    e610F941894B4A6488Cc1E06655862Ee: json["e610f941894b4a6488cc1e06655862ee"] == null 
        ? E610F941894B4A6488Cc1E06655862Ee(
            addons: [], 
            key: '', 
            productId: 0, 
            variationId: 0, 
            variation: VariationClass(attributePaColor: '', attributePaSize: ''), 
            quantity: 0, 
            dataHash: '', 
            lineTaxData: LineTaxData(subtotal: [], total: []), 
            lineSubtotal: 0, 
            lineSubtotalTax: 0, 
            lineTotal: 0, 
            lineTax: 0, 
            data: Checkout(), 
            name: ''
          ) 
        : E610F941894B4A6488Cc1E06655862Ee.fromJson(json["e610f941894b4a6488cc1e06655862ee"]),
  );

  Map<String, dynamic> toJson() => {
    "8da153b3917424a1cf24a9cd1d7b4e9d": the8Da153B3917424A1Cf24A9Cd1D7B4E9D.toJson(),
    "e610f941894b4a6488cc1e06655862ee": e610F941894B4A6488Cc1E06655862Ee.toJson(),
  };
}

class E610F941894B4A6488Cc1E06655862Ee {
  List<dynamic> addons;
  String key;
  int productId;
  int variationId;
  VariationClass variation;
  int quantity;
  String dataHash;
  LineTaxData lineTaxData;
  int lineSubtotal;
  int lineSubtotalTax;
  int lineTotal;
  int lineTax;
  Checkout data;
  String name;

  E610F941894B4A6488Cc1E06655862Ee({
    required this.addons,
    required this.key,
    required this.productId,
    required this.variationId,
    required this.variation,
    required this.quantity,
    required this.dataHash,
    required this.lineTaxData,
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTax,
    required this.data,
    required this.name,
  });

  factory E610F941894B4A6488Cc1E06655862Ee.fromJson(Map<String, dynamic> json) => E610F941894B4A6488Cc1E06655862Ee(
    addons:   json["addons"] == null ? [] : List<dynamic>.from(json["addons"].map((x) => x)),
    key: json["key"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    variation: json["variation"] == null ? VariationClass(attributePaColor: '', attributePaSize: '') : VariationClass.fromJson(json["variation"]),
    quantity: json["quantity"],
    dataHash: json["data_hash"],
    lineTaxData:  json["line_tax_data"] == null ? LineTaxData(subtotal: [], total: []) : LineTaxData.fromJson(json["line_tax_data"]),
    lineSubtotal: json["line_subtotal"],
    lineSubtotalTax: json["line_subtotal_tax"],
    lineTotal: json["line_total"],
    lineTax: json["line_tax"],
    data: json["data"] == null ? Checkout() : Checkout.fromJson(json["data"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "addons": addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
    "key": key,
    "product_id": productId,
    "variation_id": variationId,
    "variation": variation?.toJson(),
    "quantity": quantity,
    "data_hash": dataHash,
    "line_tax_data": lineTaxData?.toJson(),
    "line_subtotal": lineSubtotal,
    "line_subtotal_tax": lineSubtotalTax,
    "line_total": lineTotal,
    "line_tax": lineTax,
    "data": data?.toJson(),
    "name": name,
  };
}

class Checkout {
  Checkout();

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
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

class The8Da153B3917424A1Cf24A9Cd1D7B4E9D {
  List<dynamic> addons;
  String key;
  int productId;
  int variationId;
  String variation;
  int quantity;
  String dataHash;
  LineTaxData lineTaxData;
  int lineSubtotal;
  int lineSubtotalTax;
  int lineTotal;
  int lineTax;
  Checkout data;
  String name;

  The8Da153B3917424A1Cf24A9Cd1D7B4E9D({
    required this.addons,
    required this.key,
    required this.productId,
    required this.variationId,
    required this.variation,
    required this.quantity,
    required this.dataHash,
    required this.lineTaxData,
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTax,
    required this.data,
    required this.name,
  });

  factory The8Da153B3917424A1Cf24A9Cd1D7B4E9D.fromJson(Map<String, dynamic> json) => The8Da153B3917424A1Cf24A9Cd1D7B4E9D(
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
    data: json["data"] == null ? null : Checkout.fromJson(json["data"]),
    name: json["name"],
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
    "name": name,
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

class WooPaymentMethod {
  dynamic orderButtonText;
  String enabled;
  String title;
  String description;
  bool chosen;
  String methodTitle;
  String methodDescription;
  bool hasFields;
  dynamic countries;
  dynamic availability;
  String icon;
  List<String> supports;
  int maxAmount;
  String viewTransactionUrl;
  String newMethodLabel;
  String pluginId;
  String id;
  Settings settings;
  FormFields formFields;
  String instructions;
  String payStackPublicKey;
  String stripePublicKey;

  WooPaymentMethod({
    required this.orderButtonText,
    required this.enabled,
    required this.title,
    required this.description,
    required this.chosen,
    required this.methodTitle,
    required this.methodDescription,
    required this.hasFields,
    required this.countries,
    required this.availability,
    required this.icon,
    required this.supports,
    required this.maxAmount,
    required this.viewTransactionUrl,
    required this.newMethodLabel,
    required this.pluginId,
    required this.id,
    required this.settings,
    required this.formFields,
    required this.instructions,
    required this.payStackPublicKey,
    required this.stripePublicKey
  });

  factory WooPaymentMethod.fromJson(Map<String, dynamic> json) => WooPaymentMethod(
    orderButtonText: json["order_button_text"],
    enabled: json["enabled"],
    title: json["title"],
    description: json["description"],
    chosen: json["chosen"],
    methodTitle: json["method_title"],
    methodDescription: json["method_description"],
    hasFields: json["has_fields"],
    countries: json["countries"],
    availability: json["availability"],
    icon: (json["icon"] == null || json["icon"] == false) ? null : json["icon"],
    supports: json["supports"] == null ? null : List<String>.from(json["supports"].map((x) => x)),
    maxAmount: json["max_amount"],
    viewTransactionUrl: json["view_transaction_url"],
    newMethodLabel: json["new_method_label"],
    pluginId: json["plugin_id"],
    id: json["id"],
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
    formFields: json["form_fields"] == null ? null : FormFields.fromJson(json["form_fields"]),
    instructions: json["instructions"],
    payStackPublicKey: json["public_key"],
    stripePublicKey: json["publishable_key"],
  );

  Map<String, dynamic> toJson() => {
    "order_button_text": orderButtonText,
    "enabled": enabled,
    "title": title,
    "description": description,
    "chosen": chosen,
    "method_title": methodTitle,
    "method_description": methodDescription,
    "has_fields": hasFields,
    "countries": countries,
    "availability": availability,
    "icon": icon,
    "supports": supports == null ? null : List<dynamic>.from(supports.map((x) => x)),
    "max_amount": maxAmount,
    "view_transaction_url": viewTransactionUrl,
    "new_method_label": newMethodLabel,
    "plugin_id": pluginId,
    "id": id,
    "settings": settings?.toJson(),
    "form_fields": formFields?.toJson(),
    "instructions": instructions,
  };
}

class FormFields {
  Enabled enabled;
  Description title;
  Description description;
  Description instructions;

  FormFields({
    required this.enabled,
    required this.title,
    required this.description,
    required this.instructions,
  });

  factory FormFields.fromJson(Map<String, dynamic> json) => FormFields(
    enabled: json["enabled"] == null ? null : Enabled.fromJson(json["enabled"]),
    title: json["title"] == null ? null : Description.fromJson(json["title"]),
    description: json["description"] == null ? null : Description.fromJson(json["description"]),
    instructions: json["instructions"] == null ? null : Description.fromJson(json["instructions"]),
  );

  Map<String, dynamic> toJson() => {
    "enabled": enabled?.toJson(),
    "title": title?.toJson(),
    "description": description?.toJson(),
    "instructions": instructions?.toJson(),
  };
}

class Description {
  String title;
  String type;
  String description;
  String descriptionDefault;
  //bool descTip;

  Description({
    required this.title,
    required this.type,
    required this.description,
    required this.descriptionDefault,
    //this.descTip,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    title: json["title"],
    type: json["type"],
    description: json["description"],
    descriptionDefault: json["default"],
    //descTip: json["desc_tip"] == null ? null : json["desc_tip"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type": type,
    "description": description,
    "default": descriptionDefault,
    //"desc_tip": descTip == null ? null : descTip,
  };
}

class Enabled {
  String title;
  String type;
  String label;
  String enabledDefault;

  Enabled({
    required this.title,
    required this.type,
    required this.label,
    required this.enabledDefault,
  });

  factory Enabled.fromJson(Map<String, dynamic> json) => Enabled(
    title: json["title"],
    type: json["type"],
    label: json["label"],
    enabledDefault: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type": type,
    "label": label,
    "default": enabledDefault,
  };
}

class Settings {
  String enabled;
  String title;
  String description;
  String instructions;
  String razorPayKeyId;


  Settings({
    required this.enabled,
    required this.title,
    required this.description,
    required this.instructions,
    required this.razorPayKeyId
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    enabled: json["enabled"],
    title: json["title"],
    description: json["description"],
    instructions: json["instructions"],
    razorPayKeyId: json["key_id"],
  );

  Map<String, dynamic> toJson() => {
    "enabled": enabled,
    "title": title,
    "description": description,
    "instructions": instructions,
  };
}

class Shipping {
  Package package;
  bool showPackageDetails;
  bool showShippingCalculator;
  String packageDetails;
  String packageName;
  String index;
  String chosenMethod;
  List<ShippingMethod> shippingMethods;

  Shipping({
    required this.package,
    required this.showPackageDetails,
    required this.showShippingCalculator,
    required this.packageDetails,
    required this.packageName,
    required this.index,
    required this.chosenMethod,
    required this.shippingMethods,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    package: json["package"] == null ? null : Package.fromJson(json["package"]),
    showPackageDetails: json["show_package_details"],
    showShippingCalculator: json["show_shipping_calculator"],
    packageDetails: json["package_details"],
    packageName: json["package_name"],
    index: json["index"]?.toString(),
    chosenMethod: (json["chosen_method"] == null || json["chosen_method"] == false ) ? '' : json["chosen_method"],
    shippingMethods: json["shippingMethods"] == null ? [] : List<ShippingMethod>.from(json["shippingMethods"].map((x) => ShippingMethod.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "package": package?.toJson(),
    "show_package_details": showPackageDetails,
    "show_shipping_calculator": showShippingCalculator,
    "package_details": packageDetails,
    "package_name": packageName,
    "index": index,
    "chosen_method": chosenMethod,
    "shippingMethods": shippingMethods == null ? null : List<dynamic>.from(shippingMethods.map((x) => x.toJson())),
  };
}

class Package {
  //List<Content> contents;
  double contentsCost;
  List<dynamic> appliedCoupons;
  User user;
  Destination destination;

  Package({
    //this.contents,
    required this.contentsCost,
    required this.appliedCoupons,
    required this.user,
    required this.destination,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    //contents: json["contents"] == null ? null : new List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
    contentsCost: json["contents_cost"]?.toDouble(),
    appliedCoupons: json["applied_coupons"] == null ? null : List<dynamic>.from(json["applied_coupons"].map((x) => x)),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    destination: json["destination"] == null ? null : Destination.fromJson(json["destination"]),
  );

  Map<String, dynamic> toJson() => {
    //"contents": contents == null ? null : new List<dynamic>.from(contents.map((x) => x.toJson())),
    "contents_cost": contentsCost,
    "applied_coupons": appliedCoupons == null ? null : List<dynamic>.from(appliedCoupons.map((x) => x)),
    "user": user?.toJson(),
    "destination": destination?.toJson(),
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
  Checkout data;

  Content({
    required this.addons,
    required this.key,
    required this.productId,
    required this.variationId,
    required this.variation,
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
    data: json["data"] == null ? null : Checkout.fromJson(json["data"]),
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
    cost: json["cost"]!.toString(),
    methodId: json["method_id"], taxes: [],
    //taxes: json["taxes"] == null ? null : new List<dynamic>.from(json["taxes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "cost": cost,
    "method_id": methodId,
    "taxes": taxes == null ? null : List<dynamic>.from(taxes.map((x) => x)),
  };
}

class Totals {
  String subtotal;
  String subtotalTax;
  String shippingTotal;
  String shippingTax;
  List<dynamic> shippingTaxes;
  String discountTotal;
  String discountTax;
  String cartContentsTotal;
  String cartContentsTax;
  List<dynamic> cartContentsTaxes;
  String feeTotal;
  String feeTax;
  List<dynamic> feeTaxes;
  String total;
  String totalTax;

  Totals({
    required this.subtotal,
    required this.subtotalTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.shippingTaxes,
    required this.discountTotal,
    required this.discountTax,
    required this.cartContentsTotal,
    required this.cartContentsTax,
    required this.cartContentsTaxes,
    required this.feeTotal,
    required this.feeTax,
    required this.feeTaxes,
    required this.total,
    required this.totalTax,
  });

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
    subtotal: json["subtotal"]!.toString(),
    subtotalTax: json["subtotal_tax"]!.toString(),
    shippingTotal: json["shipping_total"]!.toString(),
    shippingTax: json["shipping_tax"]!.toString(),
    //shippingTaxes: json["shipping_taxes"] == null ? null : new List<dynamic>.from(json["shipping_taxes"].map((x) => x)),
    discountTotal: json["discount_total"]!.toString(),
    discountTax: json["discount_tax"]!.toString(),
    cartContentsTotal: json["cart_contents_total"]!.toString(),
    //cartContentsTax: json["cart_contents_tax"] == null ? null : json["cart_contents_tax"].toDouble(),
    //cartContentsTaxes: json["cart_contents_taxes"] == null ? null : new List<dynamic>.from(json["cart_contents_taxes"].map((x) => x)),
    feeTotal: json["fee_total"]!.toString(),
    feeTax: json["fee_tax"]!.toString(),
    //feeTaxes: json["fee_taxes"] == null ? null : new List<dynamic>.from(json["fee_taxes"].map((x) => x)),
    total: json["total"]!.toString(),
    totalTax: json["total_tax"]!.toString(), shippingTaxes: [], cartContentsTax: '', cartContentsTaxes: [], feeTaxes: [],
  );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "shipping_taxes": shippingTaxes == null ? null : List<dynamic>.from(shippingTaxes.map((x) => x)),
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "cart_contents_total": cartContentsTotal,
    "cart_contents_tax": cartContentsTax,
    "cart_contents_taxes": cartContentsTaxes == null ? null : List<dynamic>.from(cartContentsTaxes.map((x) => x)),
    "fee_total": feeTotal,
    "fee_tax": feeTax,
    "fee_taxes": feeTaxes == null ? null : List<dynamic>.from(feeTaxes.map((x) => x)),
    "total": total,
    "total_tax": totalTax,
  };
}
