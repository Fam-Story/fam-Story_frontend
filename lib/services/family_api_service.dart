import 'dart:convert' as convert;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가
class FamilyApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  // POST: 가족 생성
  static Future<int> postFamily(String familyName) async {
    final url = Uri.parse('$baseUrl/family');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
    print('ok?');
    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription('Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];
    print(loginToken);

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
      int familyId = jsonDecode(response.body)['data'];
      return familyId;
    }
    throw ErrorDescription('Something wrong to create Family');
  }
}
