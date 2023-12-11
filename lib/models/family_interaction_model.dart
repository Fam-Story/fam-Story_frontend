class FamilyInteractionModel {
  final int interactionId, srcMemberId, dstMemberId, interactionType, isChecked, srcMemberRole;
  final String srcMemberNickname;

  FamilyInteractionModel.fromJson(Map<String, dynamic> json)
      : interactionId = json['interactionId'],
        srcMemberId = json['srcMemberId'],
        srcMemberRole = json['srcMemberRole'],
        srcMemberNickname = json['srcMemberNickname'],
        dstMemberId = json['dstMemberId'],
        isChecked = json['isChecked'],
        interactionType = json['interactionType'];
}