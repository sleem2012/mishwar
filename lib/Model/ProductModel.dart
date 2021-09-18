// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.statusCode,
    this.productDetail,
    this.messageCode,
  });

  int statusCode;
  List<ProductDetail> productDetail;
  String messageCode;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    statusCode: json["StatusCode"],
    productDetail: List<ProductDetail>.from(json["ProductDetail"].map((x) => ProductDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "ProductDetail": List<dynamic>.from(productDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class ProductDetail {
  ProductDetail({
    this.id,
    this.name,
    this.description,
    this.foodCategoryId,
    this.price,
    this.price2,
    this.image,
    this.haveChilds,
    this.subItems,
  });

  String id;
  String name;
  String description;
  String foodCategoryId;
  String price;
  String price2;
  dynamic image;
  bool haveChilds;
  List<SubProductDetail1> subItems;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["id"],
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    foodCategoryId: json["FoodCategoryID"],
    price: json["Price"],
    price2: json["Price2"],
    image: json["Image"],
    haveChilds: json["HaveChilds"] == null ? null : json["HaveChilds"],
    subItems: json["SubItems"] == null ? null : List<SubProductDetail1>.from(json["SubItems"].map((x) => SubProductDetail1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description == null ? null : description,
    "FoodCategoryID": foodCategoryId,
    "Price": price,
    "Price2": price2,
    "Image": image,
    "HaveChilds": haveChilds == null ? null : haveChilds,
    "SubItems": subItems == null ? null : List<dynamic>.from(subItems.map((x) => x.toJson())),
  };
}
class SubProductDetail1{
  SubProductDetail1({
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
  String description;
  String foodCategoryId;
  String price;
  String price2;
  dynamic image;
  factory SubProductDetail1.fromJson(Map<String, dynamic> json) => SubProductDetail1(
    id: json["id"],
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    foodCategoryId: json["FoodCategoryID"],
    price: json["Price"],
    price2: json["Price2"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description == null ? null : description,
    "FoodCategoryID": foodCategoryId,
    "Price": price,
    "Price2": price2,
    "Image": image,
  };
}
