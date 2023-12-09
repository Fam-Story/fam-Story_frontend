class ChatModel {
  int? familyId;
  int? familyMemberId;
  String message;
  String? date;
  int? role;
  String? nickname;
  ChatModel(
      {required this.familyId,
      required this.familyMemberId,
      required this.message,
      required this.nickname,
      required this.role});

  // http 통신으로 받을 때
  ChatModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        role = json['role'],
        familyMemberId = json['familyMemberId'],
        message = json['message'],
        date = json['createdTime'];

  // 소켓에서 받을 때
  ChatModel.fromChatDto(Map<String, dynamic> chatDto)
      : nickname = chatDto['nickname'],
        role = int.parse(chatDto['role']),
        message = chatDto['message'],
        familyMemberId = int.parse(chatDto['familyMemberId']),
        date = chatDto['createdAt'];

  // 소켓으로 보낼 때
  Map<String, dynamic> toChatDto() {
    print(nickname);
    return {
      'familyId': familyId.toString(),
      'familyMemberId': familyMemberId.toString(),
      'message': message,
      'role': role.toString(),
      'nickname': nickname,
    };
  }
}
