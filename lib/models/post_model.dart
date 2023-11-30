class PostModel {
  final int postId, familyMemberId;
  final String context, createdDate;

  PostModel.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        familyMemberId = json['familyMemberId'],
        context = json['context'],
        createdDate = json['createdDate'];
}
