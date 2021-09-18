// To parse this JSON data, do
//
//     final subProductModel = subProductModelFromJson(jsonString);

import 'dart:convert';

SubProductModel subProductModelFromJson(String str) => SubProductModel.fromJson(json.decode(str));

String subProductModelToJson(SubProductModel data) => json.encode(data.toJson());

class SubProductModel {
  SubProductModel({
    this.statusCode,
    this.subProductDetail,
    this.messageCode,
  });

  int statusCode;
  List<SubProductDetail> subProductDetail;
  String messageCode;

  factory SubProductModel.fromJson(Map<String, dynamic> json) => SubProductModel(
    statusCode: json["StatusCode"],
    subProductDetail: List<SubProductDetail>.from(json["SubProductDetail"].map((x) => SubProductDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "SubProductDetail": List<dynamic>.from(subProductDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class SubProductDetail {
  SubProductDetail({
    this.id,
    this.name,
    this.description,
    this.foodCategoryId,
    this.price,
    this.price2,
    this.image,
  });

  String id;
  String name;
  dynamic description;
  String foodCategoryId;
  String price;
  String price2;
  String image;

  factory SubProductDetail.fromJson(Map<String, dynamic> json) => SubProductDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    foodCategoryId: json["FoodCategoryID"],
    price: json["Price"],
    price2: json["Price2"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "FoodCategoryID": foodCategoryId,
    "Price": price,
    "Price2": price2,
    "Image": image,
  };
}
