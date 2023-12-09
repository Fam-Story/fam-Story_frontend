import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fam_story_frontend/models/post_model.dart';

class PostApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  //TODO: 변경 필
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsImVtYWlsIjoiZGphY2tzZG4xQGljbG91ZC5jb20iLCJ1c2VybmFtZSI6ImVvbWNoYW53b28iLCJpYXQiOjE3MDIxMTE0MTEsImV4cCI6MTcwMjExNTAxMX0.RNCInpnqWrRXAs2Ji5E9KNMEw3Q-WQVSoTFFGzGvIOk';

  // 게시글 post
  static Future<int> postPost(
      int srcMemberId,
      int familyId,
      String context,
      int createdYear,
      int createdMonth,
      int createdDay,
      int createdHour,
      int createdMinute) async {
    final url = Uri.parse('$baseUrl/post');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        "srcMemberId": srcMemberId,
        "familyId": familyId,
        "title": "-",
        "context": context,
        "createdYear": createdYear,
        "createdMonth": createdMonth,
        "createdDay": createdDay,
        "createdHour": createdHour,
        "createdMinute": createdMinute,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['data'];
    } else {
      print(response.statusCode);
      print(jsonDecode(response.body)['message']);
    }
    throw ErrorDescription('Something wrong to post!');
  }

  // 게시글 수정
  static Future<void> putPost(
      int id,
      int srcMemberId,
      String context,
      int createdYear,
      int createdMonth,
      int createdDay,
      int createdHour,
      int createdMinute) async {
    final url = Uri.parse('$baseUrl/post');

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        "id": id,
        // "srcMemberId": srcMemberId,
        // "title": "-",
        "context": context,
        // "createdYear": createdYear,
        // "createdMonth": createdMonth,
        // "createdDay": createdDay,
        // "createdHour": createdHour,
        // "createdMinute": createdMinute,
      }),
    );

    if (response.statusCode == 200) {
      // return jsonDecode(response.body)['data'];
      return;
    } else {
      print(response.statusCode);
    }
    throw ErrorDescription('Something wrong to update post!');
  }

  // 게시글 삭제
  static Future<void> deletePost(int postId) async {
    final url = Uri.parse('$baseUrl/post?postId=$postId');

    final response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      // return jsonDecode(response.body)['data'];
      return;
    } else {
      print(response.statusCode);
    }
    throw ErrorDescription('Something wrong to delete post!');
  }

  // 가족 게시글 전부 받아오기
  static Future<List<PostModel>> getPostList(int familyId) async {
    List<PostModel> postList = [];
    final url = Uri.parse("$baseUrl/post?familyId=$familyId");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    String errorMsg = 'Something wrong to get posts..';
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data'];
      for (var data in list) {
        postList.add(PostModel.fromJson(data));
      }
      return postList;
    } else {
      print(response.statusCode);
      errorMsg = jsonDecode(response.body)['message'];
    }
    throw ErrorDescription(errorMsg);
  }
}
