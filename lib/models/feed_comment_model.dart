import 'package:social_boster/models/feed_like_model.dart';

class FeedCommentModelFields {
  static const String postId = "postId";
  static const String commentId = "commentId";

  static const String commenterImageUrl = "commenterImageUrl";
  static const String commenterName = "commenterName";
  static const String commenterUid = "commenterUid";
  static const String commentTime = "commentTime";
  static const String comment = "comment";
}

class FeedCommentModel {
  String postId;
  String commentId;

  String commenterImageUrl;
  String commenterName;
  String commenterUid;
  String commentTime;
  String comment;

  FeedCommentModel({
    required this.commentId,

    required this.commenterImageUrl,
    required this.commenterName,
    required this.commenterUid,
    required this.commentTime,
    required this.postId,
    required this.comment
  });

  toMap() =>
      {
        FeedCommentModelFields.postId: postId,
        FeedCommentModelFields.commentTime: commentTime,
        FeedCommentModelFields.commenterUid: commenterUid,
        FeedCommentModelFields.commenterName: commenterName,
        FeedCommentModelFields.commenterImageUrl: commenterImageUrl,
        FeedCommentModelFields.commentId: commentId,
        FeedCommentModelFields.comment:comment
      };

  factory FeedCommentModel.fromJson(Map<String, dynamic> json)=>
      FeedCommentModel(
          commentId: json[FeedCommentModelFields.commentId],
          commenterImageUrl: json[FeedCommentModelFields.commenterImageUrl],
          commenterName: json[FeedCommentModelFields.commenterName],
          commenterUid: json[FeedCommentModelFields.commenterUid],
          commentTime: json[FeedCommentModelFields.commentTime],
          postId: json[FeedCommentModelFields.postId],
        comment: json[FeedCommentModelFields.comment]
      );

}