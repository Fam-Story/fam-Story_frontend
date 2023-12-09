import 'dart:convert';

import 'package:fam_story_frontend/models/family_interaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가, 테스트 필요, 토큰 확인
class FamilyInteractionApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  /// POST: /interaction [상호작용] 상호작용 전송
  static Future<int> postFamilyInteraction(
    int srcMemberId,
    int dstMemberId,
    int interactionType,
  ) async {
    final url = Uri.parse('$baseUrl/interaction');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
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
      body: jsonEncode({
        "familyId": srcMemberId,
        "role": dstMemberId,
        "fcmToken": interactionType
      }),
    );

    // 상호작용 전송 완료
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']);
      int interactionId = jsonDecode(response.body)['data'];
      return interactionId;
    }
    throw ErrorDescription('Something Wrong To Send Interaction');
  }

  /// GET: /interaction [상호작용] 상호작용 수신함 확인
  static Future<FamilyInteractionModel> getFamilyInteraction(
      int familyId) async {
    final url = Uri.parse('$baseUrl/interaction?familyId=$familyId');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
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

    // 상호작용 정보 받기
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']);
      FamilyInteractionModel familyInteraction =
          FamilyInteractionModel.fromJson(jsonDecode(response.body)['data']);
      return familyInteraction;
    }
    throw ErrorDescription('Something wrong to get family interaction');
  }

  /// DELETE: /interaction [상호작용] 모든 상호작용들 삭제
  static Future<bool> deleteFamilyInteraction(int familyId) async {
    final url = Uri.parse('$baseUrl/interaction');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
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

    // 상호작용 삭제
    if (response.statusCode == 200) {
      return true;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }
}
