class FamilyInteractionModel {
  final int interactionId, srcMemberId, dstMemberId, interactionType, isChecked;

  FamilyInteractionModel.fromJson(Map<String, dynamic> json)
      : interactionId = json['interactionId'],
        srcMemberId = json['srcMemberId'],
        dstMemberId = json['dstMemberId'],
        isChecked = json['isChecked'],
        interactionType = json['interactionType'];
}
