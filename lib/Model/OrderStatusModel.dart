// To parse this JSON data, do
//
//     final orderStatusModel = orderStatusModelFromJson(jsonString);

import 'dart:convert';

OrderStatusModel orderStatusModelFromJson(String str) => OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) => json.encode(data.toJson());

class OrderStatusModel {
  OrderStatusModel({
    this.statusCode,
    this.orderStatusDetail,
    this.messageCode,
  });

  int statusCode;
  List<OrderStatusDetail> orderStatusDetail;
  String messageCode;

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
    statusCode: json["StatusCode"],
    orderStatusDetail: List<OrderStatusDetail>.from(json["OrderStatusDetail"].map((x) => OrderStatusDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "OrderStatusDetail": List<dynamic>.from(orderStatusDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class OrderStatusDetail {
  OrderStatusDetail({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory OrderStatusDetail.fromJson(Map<String, dynamic> json) => OrderStatusDetail(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
