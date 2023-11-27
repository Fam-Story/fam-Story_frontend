import 'dart:convert';

class UserModel {
  final int userId, age, gender;
  final String email, username, nickname;

  UserModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'],
        age = json['age'],
        username = json['username'],
        nickname = json['nickname'] ?? "",
        gender = json['gender'];
}
