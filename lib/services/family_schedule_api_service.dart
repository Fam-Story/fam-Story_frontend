import 'dart:convert';

import 'package:fam_story_frontend/models/family_schedule_model.dart';
import 'package:http/http.dart' as http;

class FamilyScheduleApiService {
  static const baseUrl = 'https://famstory.thisiswandol.com';

  static const familySchedule = 'family-schedule';
  static const familyScheduleList = 'family-schedule/list';

  static const requestFamilyId = 'familyId=';
  static const requestYear = 'year=';
  static const requestTargetMonth = 'targetMonth=';
  static const requestScheduleName = 'scheduleName=';
  static const requestScheduleYear = 'scheduleYear=';
  static const requestScheduleMonth = 'scheduleMonth=';
  static const requestScheduleDay = 'scheduleDay=';
  static const requestScheduleId = 'scheduleId=';

  //TODO: 변경 필
  static const token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOiJkamFja3NkbjFAaWNsb3VkLmNvbSIsInVzZXJuYW1lIjoiZW9tY2hhbnUiLCJpYXQiOjE3MDA2NTQzNzYsImV4cCI6MTcwMDY1Nzk3Nn0.DIaoVLhzceXZ6oKx0ajQ68eR0XN43EfMnUObkJiSVDA';

  // Calendar Page
  // 월 단위로 가족 일정 불러오기
  static Future<List<FamilyScheduleModel>> getFamilyScheduleList(
      int familyId, int year, int targetMonth) async {
    List<FamilyScheduleModel> scheduleList = [];
    final url = Uri.parse(
        "$baseUrl/$familyScheduleList?$requestFamilyId$familyId&$requestYear$year&$requestTargetMonth$targetMonth");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data'];
      for (var data in list) {
        scheduleList.add(FamilyScheduleModel.fromJson(data));
      }
      print("call api");
      return scheduleList;
    } else {
      print(response.statusCode);
    }
    throw Error();
  }

  // 일정 등록
  static Future<bool> postFamilySchedule(String scheduleName, int familyId,
      int scheduleYear, int scheduleMonth, int scheduleDay) async {
    final url = Uri.parse("$baseUrl/$familySchedule");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "scheduleName": scheduleName,
          "scheduleYear": scheduleYear,
          "scheduleMonth": scheduleMonth,
          "scheduleDay": scheduleDay,
          "familyId": familyId
        }));

    if (response.statusCode == 201) {
      print("post success!");
      return true;
    } else {
      print("fail! post");
      print(response.statusCode);
    }
    throw Error();
  }

  // 일정 삭제
  static Future<bool> deleteFamilySchedule(int scheduleId) async {
    final url =
        Uri.parse("$baseUrl/$familySchedule?$requestScheduleId$scheduleId");
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print("delete success!");
      return true;
    } else {
      print("fail! delete");
      print(response.statusCode);
    }
    throw Error();
  }
}
