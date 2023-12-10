class FamilyMemberModel {
  final int familyMemberId, role, pokeCount, talkCount;
  final String name, nickname, introMessage;

  FamilyMemberModel.fromJson(Map<String, dynamic> json)
      : familyMemberId = json["familyMemberId"],
        name = json["name"],
        nickname = json["nickname"],
        role = json["role"],
        pokeCount = json["pokeCount"],
        talkCount = json["talkCount"],
        introMessage = json["introMessage"];
}
