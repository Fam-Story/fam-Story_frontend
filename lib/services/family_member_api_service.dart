import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// TODO: 에러 코드 추가
class FamilyMemberApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  /// FCM 토큰 생성
  Future<String?> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    const storage = FlutterSecureStorage();

    // FCM token 가져오기
    await Firebase.initializeApp();
    String? fcmToken = await FirebaseMessaging.instance.getToken(vapidKey:"BE46-NFLsOf2G-GidNDD6Bq-gz_ktXKwarsctTAFZFa0E_I081YpdqJVAakadjBDJNNWSKpPX0EIvWS_aS0j1DE");

    if (fcmToken != null) {
      // 기존 'fcm' 키의 값을 읽어옴
      dynamic userInfo = await storage.read(key: 'fcm');

      // 기존 값이 있으면 삭제
      if (userInfo != null) {
        await storage.delete(key: 'fcm');
      }

      // FCM token만 저장
      var fcmValue = jsonEncode({"fcmToken": fcmToken});

      // 'fcm' 키에 새로운 값을 저장
      await storage.write(key: 'fcm', value: fcmValue);

      print(fcmToken);
      print('FCM token updated');

      return fcmToken; // FCM 토큰 반환
    }

    return null; // FCM 토큰이 없는 경우 null 반환
  }

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

    String? fcmToken = await FamilyMemberApiService().getFCMToken();

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      },
      body: jsonEncode({"familyId": familyId, "role": role, "fcmToken": fcmToken}),
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
