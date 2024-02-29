class FeedLikeModelFields {
  static const String postId = "postId";
  static const String likeId = "likeId";

  static const String likerImageUrl = "likerImageUrl";
  static const String likerName = "likerName";
  static const String likerUid = "likerUid";
  static const String likeTime = "likeTime";
}

class FeedLikeModel {
  String postId;
  String likeId;

  String likerImageUrl;
  String likerName;
  String likerUid;
  String likeTime;

  FeedLikeModel({
    required this.likeId,

    required this.likerImageUrl,
    required this.likerName,
    required this.likerUid,
    required this.likeTime,
    required this.postId
  });

  toMap() =>
      {
        FeedLikeModelFields.postId: postId,
        FeedLikeModelFields.likeTime: likeTime,
        FeedLikeModelFields.likerUid: likerUid,
        FeedLikeModelFields.likerName: likerName,
        FeedLikeModelFields.likerImageUrl: likerImageUrl,
        FeedLikeModelFields.likeId: likeId
      };

  factory FeedLikeModel.fromJson(Map<String, dynamic> json)=>
      FeedLikeModel(
          likeId: json[FeedLikeModelFields.likeId],
          likerImageUrl: json[FeedLikeModelFields.likerImageUrl],
          likerName: json[FeedLikeModelFields.likerName],
          likerUid: json[FeedLikeModelFields.likerUid],
          likeTime: json[FeedLikeModelFields.likeTime],
          postId: json[FeedLikeModelFields.postId]);

}