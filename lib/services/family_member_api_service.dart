import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가
class FamilyMemberApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  // TODO: FCM 토큰 생성 필요
  static const String tempFcmToken = 'seungwonTest';

  /// POST: /family-member [가족 구성원] 가족 구성원 생성
  static Future<int> postFamilyMember(int familyId, int role) async {
    final url = Uri.parse('$baseUrl/family-member');
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
      body: jsonEncode({"familyId": familyId, "role": role, "fcmToken": tempFcmToken}),
    );

    // 가족 생성 완료
    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      int familyMemberId = jsonDecode(response.body)['data'];
      return familyMemberId;
    }
    throw ErrorDescription('Something Wrong To Join Family');
  }

  /// PUT: /family-member [가족 구성원] 가족 구성원 역할 수정
  static Future<bool> putFamilyMember(int familyMemberId, int role) async {
    final url = Uri.parse('$baseUrl/family-member');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription('Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];

    // TODO: 가족 멤버 정보 수정 창에서 null 체크 하기
    // 가족 이름만 수정 가능
    Map<String, dynamic> data = {};
    data.putIfAbsent("familyMemberId", () => familyMemberId);
    data.putIfAbsent("role", () => role);

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

  /// DELETE: /family-member [가족 구성원] 가족 구성원 삭제
  static Future<bool> deleteUser(int familyMemberId) async {
    final url = Uri.parse('$baseUrl/family-member?family-memberId=$familyMemberId');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription('Your login token has expired. Please Login Again.');
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
}
