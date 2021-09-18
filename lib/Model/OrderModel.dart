// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  OrdersModel({
    this.statusCode,
    this.orderDetailModel,
    this.messageCode,
  });

  int statusCode;
  List<OrderDetailModel> orderDetailModel;
  String messageCode;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    statusCode: json["StatusCode"],
    orderDetailModel: List<OrderDetailModel>.from(json["OrderDetailModel"].map((x) => OrderDetailModel.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "OrderDetailModel": List<dynamic>.from(orderDetailModel.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class OrderDetailModel {
  OrderDetailModel({
    this.id,
    this.orderNumber,
    this.orderStatusId,
    this.orderType,
    this.paymentType,
    this.subTotal,
    this.deliveryValue,
    this.discountAmount,
    this.tax,
    this.totalValue,
    this.driverId,
    this.orderDate,
    this.latitude,
    this.lang,
    this.orderAddress,
    this.orderDetails,
    this.allQuantity,
  });

  String id;
  String orderNumber;
  String orderStatusId;
  String orderType;
  String paymentType;
  String subTotal;
  String deliveryValue;
  String discountAmount;
  String tax;
  String totalValue;
  String driverId;
  DateTime orderDate;
  dynamic latitude;
  dynamic lang;
  OrderAddress orderAddress;
  List<OrderDetail> orderDetails;
  int allQuantity;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
    id: json["id"],
    orderNumber: json["OrderNumber"],
    orderStatusId: json["OrderStatusID"],
    orderType: json["OrderType"],
    paymentType: json["PaymentType"],
    subTotal: json["SubTotal"],
    deliveryValue: json["DeliveryValue"],
    discountAmount: json["DiscountAmount"],
    tax: json["Tax"],
    totalValue: json["TotalValue"],
    driverId: json["DriverID"],
    orderDate: DateTime.parse(json["OrderDate"]),
    latitude: json["Latitude"],
    lang: json["Lang"],
    orderAddress: OrderAddress.fromJson(json["OrderAddress"]),
    orderDetails: List<OrderDetail>.from(json["OrderDetails"].map((x) => OrderDetail.fromJson(x))),
    allQuantity: json["allQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "OrderNumber": orderNumber,
    "OrderStatusID": orderStatusId,
    "OrderType": orderType,
    "PaymentType": paymentType,
    "SubTotal": subTotal,
    "DeliveryValue": deliveryValue,
    "DiscountAmount": discountAmount,
    "Tax": tax,
    "TotalValue": totalValue,
    "DriverID": driverId,
    "OrderDate": orderDate.toIso8601String(),
    "Latitude": latitude,
    "Lang": lang,
    "OrderAddress": orderAddress.toJson(),
    "OrderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    "allQuantity": allQuantity,
  };
}

class OrderAddress {
  OrderAddress({
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
  });

  String id;
  String isPrimary;
  String title;
  String address;
  String landMark;
  String phone1;
  String phone2;
  String lat;
  String lng;
  String region;

  factory OrderAddress.fromJson(Map<String, dynamic> json) => OrderAddress(
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
  };
}

class OrderDetail {
  OrderDetail({
    this.name,
    this.description,
    this.price2,
    this.image,
    this.details,
  });

  String name;
  String description;
  String price2;
  String image;
  Details details;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    price2: json["Price2"],
    image: json["Image"],
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description == null ? null : description,
    "Price2": price2,
    "Image": image,
    "details": details.toJson(),
  };
}

class Details {
  Details({
    this.orderDetailsId,
    this.orderId,
    this.branchId,
    this.itemId,
    this.unitId,
    this.quantity,
    this.salePrice,
    this.subTotal,
    this.discount,
    this.discountPercent,
    this.totalValue,
    this.groupId,
    this.notes,
    this.isEdit,
    this.editQuantity,
    this.masterId,
  });

  String orderDetailsId;
  String orderId;
  String branchId;
  String itemId;
  dynamic unitId;
  String quantity;
  String salePrice;
  String subTotal;
  String discount;
  String discountPercent;
  String totalValue;
  dynamic groupId;
  String notes;
  String isEdit;
  dynamic editQuantity;
  String masterId;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    orderDetailsId: json["OrderDetailsID"],
    orderId: json["OrderID"],
    branchId: json["BranchID"],
    itemId: json["ItemID"],
    unitId: json["UnitID"],
    quantity: json["Quantity"],
    salePrice: json["SalePrice"],
    subTotal: json["SubTotal"],
    discount: json["Discount"],
    discountPercent: json["DiscountPercent"],
    totalValue: json["TotalValue"],
    groupId: json["GroupID"],
    notes: json["Notes"],
    isEdit: json["IsEdit"],
    editQuantity: json["EditQuantity"],
    masterId: json["MasterID"],
  );

  Map<String, dynamic> toJson() => {
    "OrderDetailsID": orderDetailsId,
    "OrderID": orderId,
    "BranchID": branchId,
    "ItemID": itemId,
    "UnitID": unitId,
    "Quantity": quantity,
    "SalePrice": salePrice,
    "SubTotal": subTotal,
    "Discount": discount,
    "DiscountPercent": discountPercent,
    "TotalValue": totalValue,
    "GroupID": groupId,
    "Notes": notes,
    "IsEdit": isEdit,
    "EditQuantity": editQuantity,
    "MasterID": masterId,
  };
}
