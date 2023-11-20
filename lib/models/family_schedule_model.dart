class FamilyScheduleModel {
  final int familyId, scheduleId, scheduleYear, scheduleMonth, scheduleDay;
  final String scheduleName;

  FamilyScheduleModel.fromJson(Map<String, dynamic> json) 
        : familyId = json['data']['familyId'], scheduleId = json['data']['scheduleId'],scheduleName = json['data']['scheduleName'], scheduleYear = json['data']['scheduleYear'], scheduleMonth = json['data']['scheduleMonth'], scheduleDay = json['data']['scheduleDay'];
  
}
