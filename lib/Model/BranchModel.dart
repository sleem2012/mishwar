// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

BranchModel branchModelFromJson(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToJson(BranchModel data) => json.encode(data.toJson());

class BranchModel {
  BranchModel({
    this.statusCode,
    this.branchModelDetail,
    this.messageCode,
  });

  int statusCode;
  List<BranchModelDetail> branchModelDetail;
  String messageCode;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    statusCode: json["StatusCode"],
    branchModelDetail: List<BranchModelDetail>.from(json["BranchModelDetail"].map((x) => BranchModelDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "BranchModelDetail": List<dynamic>.from(branchModelDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class BranchModelDetail {
  BranchModelDetail({
    this.name,
    this.workingTime,
    this.branchId,
    this.phone,
    this.taxNumber,
    this.address,
    this.email,
    this.lat,
    this.long,
    this.image,
  });

  String name;
  String workingTime;
  String branchId;
  String phone;
  String taxNumber;
  Address address;
  String email;
  String lat;
  String long;
  String image;

  factory BranchModelDetail.fromJson(Map<String, dynamic> json) => BranchModelDetail(
    name: json["Name"],
    workingTime: json["WorkingTime"],
    branchId: json["BranchID"],
    phone: json["Phone"],
    taxNumber: json["TaxNumber"] == null ? null : json["TaxNumber"],
    address: addressValues.map[json["Address"]],
    email: json["Email"],
    lat: json["Lat"] == null ? null : json["Lat"],
    long: json["Long"] == null ? null : json["Long"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "WorkingTime": workingTimeValues.reverse[workingTime],
    "BranchID": branchId,
    "Phone": phone,
    "TaxNumber": taxNumber == null ? null : taxNumber,
    "Address": addressValues.reverse[address],
    "Email": email,
    "Lat": lat == null ? null : lat,
    "Long": long == null ? null : long,
    "Image": image,
  };
}

enum Address { THE_12 }

final addressValues = EnumValues({
  "12 شارع الهرم - الجيزة": Address.THE_12
});

enum WorkingTime { ALL_DAYS_OF_THE_WEEK_FROM_900_TO_1000 }

final workingTimeValues = EnumValues({
  "All days of the week from 9:00 to 10:00 ": WorkingTime.ALL_DAYS_OF_THE_WEEK_FROM_900_TO_1000
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
