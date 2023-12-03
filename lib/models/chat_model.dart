class ChatModel {
  String familyId;
  String familyMemberId;
  String message;

  ChatModel({required this.familyId, required this.familyMemberId, required this.message});
  ChatModel.fromJson(Map<String, dynamic> json)
      : familyId = json['familyId'],
        familyMemberId = json['familyMemberId'],
        message = json['message'];

  Map<String, dynamic> toJson() {
    return {
      'familyId': familyId,
      'familyMemberId': familyMemberId,
      'message': message,
    };
  }
}
