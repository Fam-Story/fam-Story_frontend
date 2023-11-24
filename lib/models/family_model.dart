class FamilyModel {
  final int familyId, memberNumber;
  final String familyName, createdDate, familyKeyCode;

  FamilyModel.fromJson(Map<String, dynamic> json)
      : familyId = json['familyId'],
        familyName = json['familyName'],
        memberNumber = json['memberNumber'],
        createdDate = json['createdDate'],
        familyKeyCode = json['familyKeyCode'];
}
