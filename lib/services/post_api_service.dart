import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fam_story_frontend/models/post_model.dart';

class PostApiService {
  static const String baseUrl = 'https://famstory.thisiswandol.com/api';

  //TODO: 변경 필
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOiJkamFja3NkbjFAaWNsb3VkLmNvbSIsInVzZXJuYW1lIjoiZW9tY2hhbnUiLCJpYXQiOjE3MDA3MDAzNjQsImV4cCI6MTcwMDcwMzk2NH0.Jlv9SESNO3ZSXHkOPowRGjBJz01cWmYseUQnCpEeGzk';

  // 게시글 post
  static Future<int> postPost(
      int srcMemberId, int familyId, String context, String createdDate) async {
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
        "title": "",
        "context": context,
        "createdDate": createdDate
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['data'];
    } else {
      print(response.statusCode);
    }
    throw ErrorDescription('Something wrong to post!');
  }

  // 게시글 수정
  static Future<int> putPost(
      int srcMemberId, String context, String createdDate) async {
    final url = Uri.parse('$baseUrl/post');

    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        "srcMemberId": srcMemberId,
        "title": "",
        "context": context,
        "createdDate": createdDate
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['data'];
    } else {
      print(response.statusCode);
    }
    throw ErrorDescription('Something wrong to update post!');
  }

  // 게시글 삭제
  static Future<int> deletePost(int postId) async {
    final url = Uri.parse('$baseUrl/post/post?postId=$postId');

    final response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['data'];
    } else {
      print(response.statusCode);
    }
    throw ErrorDescription('Something wrong to delete post!');
  }

  // // 가족 게시글 전부 받아오기
  // static Future<List<PostModel>> getPostList(
  //     int familyId, int year, int targetMonth) async {
  //   List<FamilyScheduleModel> scheduleList = [];
  //   final url = Uri.parse(
  //       "$baseUrl/$familyScheduleList?$requestFamilyId$familyId&$requestYear$year&$requestTargetMonth$targetMonth");
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   });

  //   if (response.statusCode == 200) {
  //     List<dynamic> list = jsonDecode(response.body)['data'];
  //     for (var data in list) {
  //       scheduleList.add(FamilyScheduleModel.fromJson(data));
  //     }
  //     print("call api");
  //     return scheduleList;
  //   } else {
  //     print(response.statusCode);
  //   }
  //   throw Error();
  // }
}
