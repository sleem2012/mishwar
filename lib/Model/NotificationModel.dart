// To parse this JSON data, do
//
//     final notifications = notificationsFromJson(jsonString);

import 'dart:convert';

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));

String notificationsToJson(Notifications data) => json.encode(data.toJson());

class Notifications {
  Notifications({
    this.statusCode,
    this.notificationDetail,
    this.messageCode,
  });

  int statusCode;
  List<NotificationDetail> notificationDetail;
  String messageCode;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    statusCode: json["StatusCode"],
    notificationDetail: List<NotificationDetail>.from(json["NotificationDetail"].map((x) => NotificationDetail.fromJson(x))),
    messageCode: json["MessageCode"],
  );

  Map<String, dynamic> toJson() => {
    "StatusCode": statusCode,
    "NotificationDetail": List<dynamic>.from(notificationDetail.map((x) => x.toJson())),
    "MessageCode": messageCode,
  };
}

class NotificationDetail {
  NotificationDetail({
    this.title,
    this.description,
    this.model,
    this.referenceId,
    this.unread,
    this.createdAt,
  });

  String title;
  String description;
  String model;
  String referenceId;
  String unread;
  String createdAt;

  factory NotificationDetail.fromJson(Map<String, dynamic> json) => NotificationDetail(
    title: json["title"],
    description: json["description"],
    model: json["model"],
    referenceId: json["reference_id"],
    unread: json["unread"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "model": model,
    "reference_id": referenceId,
    "unread": unread,
    "created_at": createdAt,
  };
}
