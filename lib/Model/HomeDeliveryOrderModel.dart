// To parse this JSON data, do
//
//     final homeDeliveryOrdersModel = homeDeliveryOrdersModelFromJson(jsonString);

import 'dart:convert';

HomeDeliveryOrdersModel homeDeliveryOrdersModelFromJson(String str) => HomeDeliveryOrdersModel.fromJson(json.decode(str));

String homeDeliveryOrdersModelToJson(HomeDeliveryOrdersModel data) => json.encode(data.toJson());

class HomeDeliveryOrdersModel {
  HomeDeliveryOrdersModel({
    this.statusCode,
    this.homeDeliveryOrderDetail,
    this.messageCode,
  });

  int statusCode;
  List<HomeDeliveryOrderDetail> homeDeliveryOrderDetail;
  String messageCode;

  factory HomeDeliveryOrdersModel.fromJson(Map<String, dynamic> json) => HomeDeliveryOrdersModel(
    statusCode: json["StatusCode"],
    homeDeliveryOrderDetail: List<HomeDeliveryOrderDetail>.from(json["HomeDeliveryOrderDetail"].map((x) => HomeDeliveryOrderDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "HomeDeliveryOrderDetail": List<dynamic>.from(homeDeliveryOrderDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class HomeDeliveryOrderDetail {
  HomeDeliveryOrderDetail({
    this.id,
    this.orderNumber,
    this.orderStatusId,
    this.orderStatusName,
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
    this.orderUser,
    this.orderAddress,
    this.orderDetails,
    this.allQuantity,
  });

  String id;
  String orderNumber;
  String orderStatusId;
  String orderStatusName;
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
  OrderUser orderUser;
  OrderAddress orderAddress;
  List<OrderDetail> orderDetails;
  int allQuantity;

  factory HomeDeliveryOrderDetail.fromJson(Map<String, dynamic> json) => HomeDeliveryOrderDetail(
    id: json["id"],
    orderNumber: json["OrderNumber"],
    orderStatusId: json["OrderStatusID"],
    orderStatusName: json["OrderStatusName"],
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
    orderUser: OrderUser.fromJson(json["OrderUser"]),
    orderAddress: OrderAddress.fromJson(json["OrderAddress"]),
    orderDetails: List<OrderDetail>.from(json["OrderDetails"].map((x) => OrderDetail.fromJson(x))),
    allQuantity: json["allQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "OrderNumber": orderNumber,
    "OrderStatusID": orderStatusId,
    "OrderStatusName": orderStatusName,
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
    "OrderUser": orderUser.toJson(),
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
    description: json["description"],
    price2: json["Price2"],
    image: json["Image"],
    details: Details.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
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

class OrderUser {
  OrderUser({
    this.id,
    this.name,
    this.email,
    this.verificationCode,
    this.password,
    this.rememberToken,
    this.image,
    this.phone,
    this.status,
    this.deviceType,
    this.isAdmin,
    this.createdAt,
    this.userRoles,
    this.driverId,
    this.updatedAt,
  });

  String id;
  String name;
  String email;
  String verificationCode;
  String password;
  String rememberToken;
  dynamic image;
  String phone;
  String status;
  String deviceType;
  dynamic isAdmin;
  DateTime createdAt;
  String userRoles;
  dynamic driverId;
  dynamic updatedAt;

  factory OrderUser.fromJson(Map<String, dynamic> json) => OrderUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    verificationCode: json["verification_code"],
    password: json["password"],
    rememberToken: json["remember_token"],
    image: json["image"],
    phone: json["phone"],
    status: json["status"],
    deviceType: json["device_type"],
    isAdmin: json["is_admin"],
    createdAt: DateTime.parse(json["created_at"]),
    userRoles: json["user_roles"],
    driverId: json["DriverID"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "verification_code": verificationCode,
    "password": password,
    "remember_token": rememberToken,
    "image": image,
    "phone": phone,
    "status": status,
    "device_type": deviceType,
    "is_admin": isAdmin,
    "created_at": createdAt.toIso8601String(),
    "user_roles": userRoles,
    "DriverID": driverId,
    "updated_at": updatedAt,
  };
}
