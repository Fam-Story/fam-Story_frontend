import 'dart:convert';

import 'package:fam_story_frontend/models/family_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가
class FamilyApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  // GET: 가족 정보 불러오기
  static Future<FamilyModel> getFamily(int familyId) async {
    final url = Uri.parse('$baseUrl/family?familyId=$familyId');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription('Your login token has expired. Please Login Again.');
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

    // 가족 정보 받기
    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      FamilyModel familyInfo = FamilyModel.fromJson(jsonDecode(response.body)['data']);
      print('ok!');
      return familyInfo;
    }
    throw ErrorDescription('Something wrong to get family Info');
  }

  // POST: 가족 생성
  static Future<int> postFamily(String familyName) async {
    final url = Uri.parse('$baseUrl/family');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription('Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      },
      body: jsonEncode({"familyName": familyName}),
    );

    // 가족 생성 완료
    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      int familyId = jsonDecode(response.body)['data'];
      return familyId;
    }
    throw ErrorDescription('Something wrong to create Family');
  }

  // GET: 가족 참가
  static Future<FamilyModel> getFamilyJoin(String keyCode) async {
    final url = Uri.parse('$baseUrl/family/join?keyCode=$keyCode');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription('Your login token has expired. Please Login Again.');
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

    // 가족 정보 받기
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']);
      FamilyModel familyInfo = FamilyModel.fromJson(jsonDecode(response.body)['data']);
      return familyInfo;
    }
    throw Error();
  }
}
