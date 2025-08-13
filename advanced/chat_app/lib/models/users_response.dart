import 'dart:convert';

import 'package:chat_app/models/user.dart';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
    bool success;
    List<User> users;

    UsersResponse({
        required this.success,
        required this.users,
    });

    factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        success: json["success"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sucess": success,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}
