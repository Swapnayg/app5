

// To parse this JSON data, do
//
//     final deliveryTime = deliveryTimeFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

DeliveryTime deliveryTimeFromJson(String str) => DeliveryTime.fromJson(json.decode(str));

String deliveryTimeToJson(DeliveryTime data) => json.encode(data.toJson());

class DeliveryTime {
  DeliveryTime({
    required this.success,
    required this.reservation,
    required this.html,
    required this.slots,
  });

  bool success;
  bool reservation;
  String html;
  List<Slot> slots;

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
    success: json["success"],
    reservation: json["reservation"],
    html: json["html"],
    slots: json["slots"] == null ? [] : List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))), 
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "reservation": reservation,
    "html": html,
    "slots": slots == null ? null : List<dynamic>.from(slots.map((x) => x.toJson())),
  };
}

class Slot {
  Slot({
    required this.timefrom,
    required this.timeto,
    required this.cutoff,
    required this.lockout,
    required this.shippingMethods,
    required this.fee,
    required this.days,
    required this.id,
    required this.timeId,
    required this.formatted,
    required this.formattedWithFee,
    required this.value,
    required this.slotId,
  });

  Time timefrom;
  Time timeto;
  String cutoff;
  String lockout;
  List<String> shippingMethods;
  Fee? fee;
  List<String> days;
  int id;
  String timeId;
  String formatted;
  String formattedWithFee;
  String value;
  String slotId;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
    timefrom: json["timefrom"] == null ? Time(time: '', stripped: '') : Time.fromJson(json["timefrom"]),
    timeto: json["timeto"] == null ? Time(time: '', stripped: '') : Time.fromJson(json["timeto"]),
    cutoff: json["cutoff"],
    lockout: json["lockout"],
    shippingMethods: json["shipping_methods"] == null ? [] : List<String>.from(json["shipping_methods"].map((x) => x)),
    fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]), 
    days: json["days"] == null ? [] : List<String>.from(json["days"].map((x) => x)),
    id: json["id"],
    timeId: json["time_id"],
    formatted: json["formatted"],
    formattedWithFee: json["formatted_with_fee"],
    value: json["value"],
    slotId: json["slot_id"],
  );

  Map<String, dynamic> toJson() => {
    "timefrom": timefrom.toJson(),
    "timeto": timeto.toJson(),
    "cutoff": cutoff,
    "lockout": lockout,
    "shipping_methods": shippingMethods == null ? null : List<dynamic>.from(shippingMethods.map((x) => x)),
    "fee": fee?.toJson(),
    "days": days == null ? null : List<dynamic>.from(days.map((x) => x)),
    "id": id,
    "time_id": timeId,
    "formatted": formatted,
    "formatted_with_fee": formattedWithFee,
    "value": value,
    "slot_id": slotId,
  };
}

class Fee {
  Fee({
    required this.value,
    required this.formatted,
  });

  String value;
  String formatted;

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    value: json["value"],
    formatted: json["formatted"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "formatted": formatted,
  };
}

class Time {
  Time({
    required this.time,
    required this.stripped,
  });

  String time;
  String stripped;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    time: json["time"],
    stripped: json["stripped"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "stripped": stripped,
  };
}

DeliveryDate deliveryDateFromJson(String str) => DeliveryDate.fromJson(json.decode(str));

String deliveryDateToJson(DeliveryDate data) => json.encode(data.toJson());

class DeliveryDate {
  DeliveryDate({
    required this.success,
    required this.bookableDates,
  });

  bool success;
  List<String> bookableDates;

  factory DeliveryDate.fromJson(Map<String, dynamic> json) => DeliveryDate(
    success: json["success"],
    bookableDates: json["bookable_dates"] == null ? [] : List<String>.from(json["bookable_dates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "bookable_dates": bookableDates == null ? null : List<dynamic>.from(bookableDates.map((x) => x)),
  };
}

