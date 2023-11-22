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
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5₩cCI6IkpXVCJ9.eyJpZCI6OCwiZW1haWwiOiJ0ZXN0SnVuZ0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6InRlc3RKdW5nIiwiaWF0IjoxNzAwNTY5NTM3LCJleHAiOjE3MDA1NzMxMzd9.OAzw7I5Nk_KYoToRH2iK5A3SJjBWnO6Pku3HfKNfjS8'
    });

    print("hi");
    print(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("testing in controller");
      print(jsonDecode(response.body));
      List<dynamic> list = jsonDecode(response.body)['data'];
      for (var data in list) {
        scheduleList.add(FamilyScheduleModel.fromJson(data));
      }
      return scheduleList;
    } else {
      print(response.statusCode);
    }
    throw Error();
  }

  // 일정 등록
  // TODO: 인자들 encode 후 json으로 body에 넣어 post
  static void postFamilySchedule(String scheduleName, int familyId,
      int scheduleYear, int scheduleMonth, int scheduleDay) async {
    final url = Uri.parse("$baseUrl/$familySchedule");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwiZW1haWwiOiJ0ZXN0SnVuZ0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6InRlc3RKdW5nIiwiaWF0IjoxNzAwNTY5NTM3LCJleHAiOjE3MDA1NzMxMzd9.OAzw7I5Nk_KYoToRH2iK5A3SJjBWnO6Pku3HfKNfjS8'
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
    } else {
      print("fail!");
      print(response.statusCode);
    }
    throw Error();
  }
}
