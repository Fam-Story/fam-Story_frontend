class PostModel {
  final int postId, familyMemberId, familyId;
  final String context,
      title,
      createdYear,
      createdMonth,
      createdDay,
      createdHour,
      createdMinute;

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        familyMemberId = json['familyMemberId'],
        title = json['title'],
        context = json['context'],
        createdYear = json['createdYear'],
        createdMonth = json['createdMonth'],
        createdDay = json['createdDay'],
        createdHour = json['createdHour'],
        createdMinute = json['createdMinute'],
        familyId = json['familyId'];
}
