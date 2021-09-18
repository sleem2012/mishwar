// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.statusCode,
    this.categoryDetail,
    this.messageCode,
  });

  int statusCode;
  List<CategoryDetail> categoryDetail;
  String messageCode;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    statusCode: json["StatusCode"],
    categoryDetail: List<CategoryDetail>.from(json["CategoryDetail"].map((x) => CategoryDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "CategoryDetail": List<dynamic>.from(categoryDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class CategoryDetail {
  CategoryDetail({
    this.id,
    this.parentId,
    this.name,
    this.description,
    this.itemIndex,
    this.isLoloGroup,
    this.isPromotion,
  });

  String id;
  String parentId;
  String name;
  String description;
  String itemIndex;
  dynamic isLoloGroup;
  String isPromotion;

  factory CategoryDetail.fromJson(Map<String, dynamic> json) => CategoryDetail(
    id: json["id"],
    parentId: json["ParentID"],
    name: json["name"],
    description: json["description"],
    itemIndex: json["ItemIndex"],
    isLoloGroup: json["IsLoloGroup"],
    isPromotion: json["IsPromotion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ParentID": parentId,
    "name": name,
    "description": description,
    "ItemIndex": itemIndex,
    "IsLoloGroup": isLoloGroup,
    "IsPromotion": isPromotion,
  };
}
