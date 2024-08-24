import 'dart:convert';

import 'package:chat_app/models/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    bool sucess;
    User user;
    String token;

    LoginResponse({
        required this.sucess,
        required this.user,
        required this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        sucess: json["sucess"],
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "sucess": sucess,
        "user": user.toJson(),
        "token": token,
    };
}
