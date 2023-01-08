// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
    Notification({
        required this.message,
        required this.data,
        required this.status,
    });

    String message;
    List<NotificationModel> data;
    int status;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        message: json["message"],
        data: List<NotificationModel>.from(json["data"].map((x) => NotificationModel.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class NotificationModel {
    NotificationModel({
        required this.id,
        required this.description,
        required this.image,
        required this.is_read,
        required this.title,
        required this.user_id,
    });

    String id;
    String description;
    String image;
    bool is_read;
    String title;
    dynamic user_id;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        description: json["description"],
        image: json["image"],
        is_read: json["is_read"],
        title: json["title"],
        user_id: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "image": image,
        "is_read": is_read,
        "title": title,
        "user_id": user_id,
    };
}

class UserIdClass {
    UserIdClass({
        required this.firestore,
        required this.path,
        required this.converter,
    });

    Firestore firestore;
    Path path;
    Converter converter;

    factory UserIdClass.fromJson(Map<String, dynamic> json) => UserIdClass(
        firestore: Firestore.fromJson(json["_firestore"]),
        path: Path.fromJson(json["_path"]),
        converter: Converter.fromJson(json["_converter"]),
    );

    Map<String, dynamic> toJson() => {
        "_firestore": firestore.toJson(),
        "_path": path.toJson(),
        "_converter": converter.toJson(),
    };
}

class Converter {
    Converter();

    factory Converter.fromJson(Map<String, dynamic> json) => Converter(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Firestore {
    Firestore({
        required this.projectId,
    });

    String projectId;

    factory Firestore.fromJson(Map<String, dynamic> json) => Firestore(
        projectId: json["projectId"],
    );

    Map<String, dynamic> toJson() => {
        "projectId": projectId,
    };
}

class Path {
    Path({
        required this.segments,
    });

    List<String> segments;

    factory Path.fromJson(Map<String, dynamic> json) => Path(
        segments: List<String>.from(json["segments"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "segments": List<dynamic>.from(segments.map((x) => x)),
    };
}
