// To parse this JSON data, do
//
//     final checkoutFormModel = checkoutFormModelFromJson(jsonString);

import 'dart:convert';

CheckoutFormModel checkoutFormModelFromJson(String str) => CheckoutFormModel.fromJson(json.decode(str));

String checkoutFormModelToJson(CheckoutFormModel data) => json.encode(data.toJson());

class CheckoutFormModel {
  String billingFirstName;
  String billingLastName;
  String billingCompany;
  String billingCountry;
  String billingAddress1;
  String billingAddress2;
  String billingCity;
  String billingState;
  String billingPostcode;
  String billingPhone;
  String billingEmail;
  String shippingFirstName;
  String shippingLastName;
  String shippingCompany;
  String shippingCountry;
  String shippingAddress1;
  String shippingAddress2;
  String shippingCity;
  String shippingState;
  String shippingPostcode;
  List<Country> countries;
  Nonce nonce;
  String checkoutNonce;
  String wpnonce;
  String checkoutLogin;
  String saveAccountDetails;
  bool userLogged;
  String logoutUrl;
  int userId;

  CheckoutFormModel({
    this.billingFirstName,
    this.billingLastName,
    this.billingCompany,
    this.billingCountry,
    this.billingAddress1,
    this.billingAddress2,
    this.billingCity,
    this.billingState,
    this.billingPostcode,
    this.billingPhone,
    this.billingEmail,
    this.shippingFirstName,
    this.shippingLastName,
    this.shippingCompany,
    this.shippingCountry,
    this.shippingAddress1,
    this.shippingAddress2,
    this.shippingCity,
    this.shippingState,
    this.shippingPostcode,
    this.countries,
    this.nonce,
    this.checkoutNonce,
    this.wpnonce,
    this.checkoutLogin,
    this.saveAccountDetails,
    this.userLogged,
    this.logoutUrl,
    this.userId,
  });

  factory CheckoutFormModel.fromJson(Map<String, dynamic> json) => CheckoutFormModel(
    billingFirstName: json["billing_first_name"] ?? '',
    billingLastName: json["billing_last_name"] ?? '',
    billingCompany: json["billing_company"] ?? '',
    billingCountry: json["billing_country"] ?? '',
    billingAddress1: json["billing_address_1"] ?? '',
    billingAddress2: json["billing_address_2"] ?? '',
    billingCity: json["billing_city"] ?? '',
    billingState: json["billing_state"] ?? '',
    billingPostcode: json["billing_postcode"] ?? '',
    billingPhone: json["billing_phone"] ?? '',
    billingEmail: json["billing_email"] ?? '',
    shippingFirstName: json["shipping_first_name"] ?? '',
    shippingLastName: json["shipping_last_name"] ?? '',
    shippingCompany: json["shipping_company"] ?? '',
    shippingCountry: json["shipping_country"] ?? '',
    shippingAddress1: json["shipping_address_1"] ?? '',
    shippingAddress2: json["shipping_address_2"] ?? '',
    shippingCity: json["shipping_city"] ?? '',
    shippingState: json["shipping_state"] ?? '',
    shippingPostcode: json["shipping_postcode"] ?? '',
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    nonce: json["nonce"] == null ? null : Nonce.fromJson(json["nonce"]),
    checkoutNonce: json["checkout_nonce"] ?? '',
    wpnonce: json["_wpnonce"] ?? '',
    checkoutLogin: json["checkout_login"] ?? false,
    saveAccountDetails: json["save_account_details"],
    userLogged: json["user_logged"],
  );

  Map<String, dynamic> toJson() => {
    "billing_first_name": billingFirstName,
    "billing_last_name": billingLastName,
    "billing_company": billingCompany,
    "billing_country": billingCountry,
    "billing_address_1": billingAddress1,
    "billing_address_2": billingAddress2,
    "billing_city": billingCity,
    "billing_state": billingState,
    "billing_postcode": billingPostcode,
    "billing_phone": billingPhone,
    //"billing_email": billingEmail == null ? null : billingEmail,
    "shipping_first_name": shippingFirstName,
    "shipping_last_name": shippingLastName,
    "shipping_company": shippingCompany,
    "shipping_country": shippingCountry,
    "shipping_address_1": shippingAddress1,
    "shipping_address_2": shippingAddress2,
    "shipping_city": shippingCity,
    "shipping_state": shippingState,
    "shipping_postcode": shippingPostcode,
    "countries": countries == null ? null : List<dynamic>.from(countries.map((x) => x.toJson())),
    "nonce": nonce?.toJson(),
    "checkout_nonce": checkoutNonce,
    "_wpnonce": wpnonce,
    "checkout_login": checkoutLogin,
    "save_account_details": saveAccountDetails,
    "user_logged": userLogged,
    "logout_url": logoutUrl,
    "user_id": userId,
  };
}

class Country {
  String label;
  String value;
  List<Region> regions;

  Country({
    this.label,
    this.value,
    this.regions,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    label: json["label"],
    value: json["value"],
    regions: json["regions"] == null ? null : List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "regions": regions == null ? null : List<dynamic>.from(regions.map((x) => x.toJson())),
  };
}

class Region {
  String label;
  String value;

  Region({
    this.label,
    this.value,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

class Nonce {
  String ajaxUrl;
  String wcAjaxUrl;
  String updateOrderReviewNonce;
  String applyCouponNonce;
  String removeCouponNonce;
  String optionGuestCheckout;
  String checkoutUrl;
  bool debugMode;
  String i18NCheckoutError;

  Nonce({
    this.ajaxUrl,
    this.wcAjaxUrl,
    this.updateOrderReviewNonce,
    this.applyCouponNonce,
    this.removeCouponNonce,
    this.optionGuestCheckout,
    this.checkoutUrl,
    this.debugMode,
    this.i18NCheckoutError,
  });

  factory Nonce.fromJson(Map<String, dynamic> json) => Nonce(
    ajaxUrl: json["ajax_url"],
    wcAjaxUrl: json["wc_ajax_url"],
    updateOrderReviewNonce: json["update_order_review_nonce"],
    applyCouponNonce: json["apply_coupon_nonce"],
    removeCouponNonce: json["remove_coupon_nonce"],
    optionGuestCheckout: json["option_guest_checkout"],
    checkoutUrl: json["checkout_url"],
    debugMode: json["debug_mode"],
    i18NCheckoutError: json["i18n_checkout_error"],
  );

  Map<String, dynamic> toJson() => {
    "ajax_url": ajaxUrl,
    "wc_ajax_url": wcAjaxUrl,
    "update_order_review_nonce": updateOrderReviewNonce,
    "apply_coupon_nonce": applyCouponNonce,
    "remove_coupon_nonce": removeCouponNonce,
    "option_guest_checkout": optionGuestCheckout,
    "checkout_url": checkoutUrl,
    "debug_mode": debugMode,
    "i18n_checkout_error": i18NCheckoutError,
  };
}
