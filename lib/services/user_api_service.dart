import 'dart:convert';

import 'package:fam_story_frontend/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  /// POST: /user [회원가입] 회원 가입
  static Future<bool> postUser(String email, String username, String password,
      String nickname, int age, int gender) async {
    final url = Uri.parse('$baseUrl/user');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "username": username,
        "password": password,
        "nickname": nickname,
        "age": age,
        "gender": gender
      }),
    );

    String errorMessage = 'ERROR';
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 409) {
      errorMessage = 'Email address already exists.';
    }
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// PUT: /user [프로필] 회원 정보 수정
  static Future<bool> putUser(
      {String? email,
      String? username,
      String? password,
      String? nickname,
      int? age,
      int? gender}) async {
    final url = Uri.parse('$baseUrl/user');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];

    // TODO: 회원 정보 수정 창에서 null 체크 하기
    Map<String, dynamic> data = {};
    if (email != null) {
      data.putIfAbsent("email", () => email);
    }
    if (username != null) {
      data.putIfAbsent("usename", () => username);
    }
    if (password != null) {
      data.putIfAbsent("password", () => password);
    }
    if (nickname != null) {
      data.putIfAbsent("nickname", () => nickname);
    }
    if (age != null) {
      data.putIfAbsent("age", () => age);
    }
    if (gender != null) {
      data.putIfAbsent("gender", () => gender);
    }

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return true;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// DELETE: /user [프로필] 회원 탈퇴
  static Future<bool> deleteUser(String email, String username, String password,
      String? nickname, int age, int gender) async {
    final url = Uri.parse('$baseUrl/user');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];

    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// GET: /user [프로필] 회원 정보 조회
  static Future<UserModel> getUser() async {
    final url = Uri.parse('$baseUrl/user');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];

    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      },
    );

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(jsonDecode(response.body)['data']);
      return user;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// POST: /user/login [로그인] 로그인 후 JWT 토큰 발급
  static Future<int> postUserLogin(
      String email, String password, bool autoLogin) async {
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
      var loginValue = autoLogin
          ? jsonEncode({"token": token, "email": email, "password": password})
          : jsonEncode({"token": token});
      await storage.write(key: 'login', value: loginValue);

      print(token);
      print('token updated');
      return isBelongedToFamily;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }
}
