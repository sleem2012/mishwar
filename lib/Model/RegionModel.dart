// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  RegionModel({
    this.statusCode,
    this.regionDetail,
    this.messageCode,
  });

  int statusCode;
  List<RegionDetail> regionDetail;
  String messageCode;

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    statusCode: json["StatusCode"],
    regionDetail: List<RegionDetail>.from(json["RegionDetail"].map((x) => RegionDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "RegionDetail": List<dynamic>.from(regionDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class RegionDetail {
  RegionDetail({
    this.id,
    this.code,
    this.region,
    this.branchId,
    this.deliveryValue,
  });

  String id;
  String code;
  String region;
  String branchId;
  String deliveryValue;

  factory RegionDetail.fromJson(Map<String, dynamic> json) => RegionDetail(
    id: json["id"],
    code: json["Code"],
    region: json["region"],
    branchId: json["BranchID"],
    deliveryValue: json["DeliveryValue"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Code": code,
    "region": region,
    "BranchID": branchId,
    "DeliveryValue": deliveryValue,
  };
}
