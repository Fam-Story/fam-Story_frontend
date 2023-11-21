import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com';
  static const storage = FlutterSecureStorage();

  // /user 유저 생성
  static Future<bool> createUser(String email, String username, String password, String? nickname, int age, int gender) async {
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
    // TODO: 에러 코드 추가
    throw ErrorDescription('Something wrong to create User ID');
  }

  // /user/login 유저 로그인
  static Future<int> postUserLogin(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body)['data'];

      String token = data['token'];
      int isBelongedToFamily = data['isBelongedToFamily'];

      var loginValue = jsonEncode({"token": token, "email": email});
      await storage.write(key: 'login', value: loginValue);
      return isBelongedToFamily;
    }
    throw ErrorDescription('Something wrong to login');
  }
}
