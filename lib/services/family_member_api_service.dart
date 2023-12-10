import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/family_member_model.dart';
import '../models/family_model.dart';

class FamilyMemberApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  /// FCM 토큰 생성
  Future<String?> getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    const storage = FlutterSecureStorage();

    // FCM token 가져오기
    await Firebase.initializeApp();
    String? fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BE46-NFLsOf2G-GidNDD6Bq-gz_ktXKwarsctTAFZFa0E_I081YpdqJVAakadjBDJNNWSKpPX0EIvWS_aS0j1DE");

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
  static Future<int> postFamilyMember(
      int familyId, int role, String introMessage) async {
    final url = Uri.parse('$baseUrl/family-member');
    const storage = FlutterSecureStorage();

    // 로그인 토큰 불러오기
    String? userInfoString = await storage.read(key: 'login');
    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
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
      body: jsonEncode({
        "familyId": familyId,
        "role": role,
        "fcmToken": fcmToken,
        "introMessage": introMessage
      }),
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
  static Future<bool> putFamilyMember(
      int familyMemberId, int role, String introMessage) async {
    final url = Uri.parse('$baseUrl/family-member');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
    }
    Map<String, dynamic> userInfo = json.decode(userInfoString);
    String loginToken = userInfo['token'];

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $loginToken',
      },
      body: jsonEncode(
          {"id": familyMemberId, "role": role, "introMessage": introMessage}),
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
  static Future<bool> deleteFamilyMember(int familyMemberId) async {
    final url =
        Uri.parse('$baseUrl/family-member?familyMemberId=$familyMemberId');
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

  /// Get: /family-member [가족 구성원] 구성원 ID를 통한 가족 구성원 정보 반환
  static Future<FamilyMemberModel> getFamilyMemberID(int familyMemberId) async {
    final url =
        Uri.parse('$baseUrl/family-member?family-memberId=$familyMemberId');
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
      print(jsonDecode(response.body)['message']);
      FamilyMemberModel familyMemberInfo =
          FamilyMemberModel.fromJson(jsonDecode(response.body)['data']);
      print('ok!');
      return familyMemberInfo;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// Get: /family-member/user [가족 구성원] 회원이 속한 가족 구성원 정보 반환
  static Future<FamilyMemberModel> getFamilyMember() async {
    final url = Uri.parse('$baseUrl/family-member/user');
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
      print(jsonDecode(response.body)['message']);
      FamilyMemberModel familyMemberInfo =
          FamilyMemberModel.fromJson(jsonDecode(response.body)['data']);
      print('ok!');
      return familyMemberInfo;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// Post : /family-member/family [가족 구성원] 가족 구성원이 속한 가족의 정보 조회
  static Future<FamilyModel> postAndGetFamily(
      int familyMemberId, String fcmToken) async {
    final url = Uri.parse('$baseUrl/family-member/family');
    const storage = FlutterSecureStorage();

    String? userInfoString = await storage.read(key: 'login');

    if (userInfoString == null) {
      throw ErrorDescription(
          'Your login token has expired. Please Login Again.');
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
      body:
          jsonEncode({"familyMemberId": familyMemberId, "fcmToken": fcmToken}),
    );

    if (response.statusCode == 201) {
      print(jsonDecode(response.body)['message']);
      FamilyModel familyInfo =
          FamilyModel.fromJson(jsonDecode(response.body)['data']);
      return familyInfo;
    }
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }

  /// Get: /family-member/list [가족 구성원] 가족에 속한 모든 가족 구성원의 정보 반환
  static Future<List<FamilyMemberModel>> getAllFamilyMember(
      int familyId) async {
    final url = Uri.parse('$baseUrl/family-member/list?familyId=$familyId');
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
      print(jsonDecode(response.body)['message']);
      List<dynamic> jsonDataList = jsonDecode(response.body)['data'];
      List<FamilyMemberModel> familyMemberList = List<FamilyMemberModel>.from(
          jsonDataList.map((item) => FamilyMemberModel.fromJson(item)));
      return familyMemberList;
    }
    FamilyModel familyInfo =
        FamilyModel.fromJson(jsonDecode(response.body)['data']);
    // 예외 처리; 메시지를 포함한 예외를 던짐
    String errorMessage = jsonDecode(response.body)['message'] ?? 'Error';
    print(errorMessage);
    throw ErrorDescription(errorMessage);
  }
}
