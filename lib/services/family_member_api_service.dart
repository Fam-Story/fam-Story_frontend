import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가
class FamilyMemberApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  // TODO: FCM 토큰 생성 필요
  static const String tempFcmToken = 'seungwonTest';

  // POST: 가족 생성
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
}
