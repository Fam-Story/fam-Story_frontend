import 'package:fam_story_frontend/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  static Future<List<ChatModel>> getChatHistory(int familyId) async {
    final url = Uri.parse('$baseUrl/chat/history?familyId=$familyId');
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

    // 이전 채팅 정보 받기
    // String errorMessage = 'ERROR';
    if (response.statusCode == 201) {
      List<ChatModel> chatHistory = [];

      List<dynamic> chatData = jsonDecode(response.body)['data'];
      for (var chat in chatData) {
        chatHistory.add(ChatModel.fromJson(chat));
      }
      return chatHistory;
    } else {
      throw ErrorDescription('Failed to load chat history');
    }
  }
}
