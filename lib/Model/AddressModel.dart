// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.id,
    this.isPrimary,
    this.title,
    this.address,
    this.landMark,
    this.phone1,
    this.phone2,
    this.lat,
    this.lng,
    this.region,
    this.createdAt,
  });

  String id;
  String isPrimary;
  String title;
  String address;
  String landMark;
  String phone1;
  dynamic phone2;
  String lat;
  String lng;
  String region;
  DateTime createdAt;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    isPrimary: json["is_primary"],
    title: json["title"],
    address: json["address"],
    landMark: json["land_mark"],
    phone1: json["phone1"],
    phone2: json["phone2"],
    lat: json["lat"],
    lng: json["lng"],
    region: json["region"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_primary": isPrimary,
    "title": title,
    "address": address,
    "land_mark": landMark,
    "phone1": phone1,
    "phone2": phone2,
    "lat": lat,
    "lng": lng,
    "region": region,
    "created_at": createdAt.toIso8601String(),
  };
}
