class ChatModel {
  int? familyId;
  int? familyMemberId;
  String message;
  String? date;
  String? role;
  String? nickname;
  ChatModel({required this.familyId, required this.familyMemberId, required this.message});

  // http 통신으로 받을 때
  ChatModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        role = json['role'],
        message = json['message'],
        date = json['date'];

  // 소켓에서 받을 때
  ChatModel.fromChatDto(Map<String, dynamic> chatDto)
      : nickname = chatDto['nickname'],
        role = chatDto['role'],
        message = chatDto['message'],
        date = chatDto['date'];

  // 소켓으로 보낼 때
  Map<String, dynamic> toChatDto() {
    return {
      'familyId': familyId.toString(),
      'familyMemberId': familyMemberId.toString(),
      'message': message,
    };
  }
}
