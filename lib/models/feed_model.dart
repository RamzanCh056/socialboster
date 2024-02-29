import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FeedModelFields {
  static const String description = "description";
  static const String imageOrVideoUrl = "imageOrVideoUrl";
  static const String isImage = "isImage";
  static const String uploaderName = "uploaderName";
  static const String uploaderImageUrl = "uploaderImageUrl";
  static const String uploaderUid = "uploaderUid";
  static const String uploadTime = "uploadTime";
  static const String feedOrVideoId = "feedOrVideoId";
  static const String views="views";
}

class FeedModel {


  String description;
  String imageOrVideoUrl;
  bool isImage;
  String uploaderName;
  String uploaderImageUrl;
  String uploaderUid;
  Timestamp uploadTime;
  String feedOrVideoId;
  int views;

  FeedModel({
    required this.description,
    required this.imageOrVideoUrl,
    required this.isImage,
    required this.uploaderName,
    required this.uploaderImageUrl,
    required this.uploaderUid,
    required this.uploadTime,
    required this.feedOrVideoId,
  required this.views});


  toMap() =>
      {
        FeedModelFields.description: description,
        FeedModelFields.feedOrVideoId: feedOrVideoId,
        FeedModelFields.imageOrVideoUrl: imageOrVideoUrl,
        FeedModelFields.isImage: isImage,
        FeedModelFields.uploaderImageUrl: uploaderImageUrl,
        FeedModelFields.uploaderName: uploaderName,
        FeedModelFields.uploaderUid: uploaderUid,
        FeedModelFields.uploadTime: uploadTime,
        FeedModelFields.views:views
      };

  factory FeedModel.fromJson(Map<String,dynamic> json)=>
      FeedModel(
          description: json[FeedModelFields.description]??"",
          imageOrVideoUrl: json[FeedModelFields.imageOrVideoUrl]??"",
          isImage: json[FeedModelFields.isImage]??"",
          uploaderName: json[FeedModelFields.uploaderName]??"",
          uploaderImageUrl: json[FeedModelFields.uploaderImageUrl]??"",
          uploaderUid: json[FeedModelFields.uploaderUid]??"",
          uploadTime: json[FeedModelFields.uploadTime]??"",
          feedOrVideoId: json[FeedModelFields.feedOrVideoId]??"",
        views: json[FeedModelFields.views]??0
      );

}