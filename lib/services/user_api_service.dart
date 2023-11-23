import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가
class ApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

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
    throw ErrorDescription('Something wrong to create User ID');
  }

  // /user/login 유저 로그인
  static Future<int> postUserLogin(String email, String password, bool autoLogin) async {
    final url = Uri.parse('$baseUrl/user/login');
    const storage = FlutterSecureStorage();

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

      // 토큰 업데이트
      dynamic userInfo = await storage.read(key: 'login');
      if (userInfo != null) {
        await storage.delete(key: 'login');
      }

      // 시스템 저장소에 토큰 저장; 자동로그인인 경우 email과 password도 저장
      var loginValue = autoLogin ? jsonEncode({"token": token, "email": email, "password": password}) : jsonEncode({"token": token});
      await storage.write(key: 'login', value: loginValue);

      print(token);
      print('token updated');
      return isBelongedToFamily;
    }
    throw ErrorDescription('Something wrong to login');
  }
}
