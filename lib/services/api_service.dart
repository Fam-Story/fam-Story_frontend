import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com';

  // /user 유저 생성
  static Future<bool> createUser(String email, String username, String password, String nickname, int age, int gender) async {
    final url = Uri.parse('$baseUrl/user');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "username": username, "password": password, "nickname": nickname, "age": age, "gender": gender}),
    );

    if (response.statusCode == 201) {
      return true;
    }
    throw ErrorDescription('Something wrong to create User ID');
  }
}
