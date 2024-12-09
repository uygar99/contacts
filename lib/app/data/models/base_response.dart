import 'package:contacts/app/data/models/user.dart';
import 'package:get/get.dart';

class BaseResponse {
  bool success;
  List<String>? messages;
  dynamic data;
  int status;

  BaseResponse({
    required this.success,
    this.messages,
    this.data,
    required this.status,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    dynamic parsedData;
    if (json['data'] != null) {
      if (json['data'] is Map<String, dynamic> && json['data']['users'] != null) {
        parsedData = Data.fromJson(json['data']);
      } else if(json['data']['id'] != null){
        parsedData = User.fromJson(json['data']);
      }
    }
    return BaseResponse(
      success: json["success"],
      messages: json["messages"] == null ? [] : List<String>.from(json["messages"]!.map((x) => x)),
      data: parsedData,
      status: json["status"],
    );

  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "messages": List<dynamic>.from(messages!.map((x) => x)),
    "data": data!.toJson(),
    "status": status,
  };
}

class Data {
  List<User>? users;

  Data({
    this.users,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: json["users"] == null ? [] : List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}