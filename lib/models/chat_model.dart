class ChatModel {
  int familyId;
  int familyMemberId;
  String message;
  ChatModel({required this.familyId, required this.familyMemberId, required this.message});

  // http 통신으로 받을 때
  ChatModel.fromJson(Map<String, dynamic> json)
      : familyId = json['familyId'],
        familyMemberId = json['familyMemberId'],
        message = json['message'];

  // 소켓에서 받을 때
  ChatModel.fromChatDto(Map<String, dynamic> chatDto)
      : familyId = 8,
        familyMemberId = int.parse(chatDto['familyMemberId']),
        message = chatDto['message'];

  // 소켓으로 보낼 때
  Map<String, dynamic> toChatDto() {
    return {
      'familyId': familyId.toString(),
      'familyMemberId': familyMemberId.toString(),
      'message': message,
    };
  }
}
