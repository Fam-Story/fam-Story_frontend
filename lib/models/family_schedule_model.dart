class FamilyScheduleModel {
  final int scheduleId, scheduleYear, scheduleMonth, scheduleDay;
  final String scheduleName;

  FamilyScheduleModel.fromJson(Map<String, dynamic> json)
      : scheduleId = json['scheduleId'],
        scheduleName = json['scheduleName'],
        scheduleYear = json['scheduleYear'],
        scheduleMonth = json['scheduleMonth'],
        scheduleDay = json['scheduleDay'];
}
