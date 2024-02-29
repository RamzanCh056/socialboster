import 'package:cloud_firestore/cloud_firestore.dart';

abstract class StoryModelFields {
  static const String description = "description";
  static const String storyImageUrl = "storyImageUrl";
  static const String uploaderName = "uploaderName";
  static const String uploaderImageUrl = "uploaderImageUrl";
  static const String uploaderUid = "uploaderUid";
  static const String uploadTime = "uploadTime";
  static const String storyId = "storyId";
}

class StoryModel {


  String description;
  String storyImageUrl;

  String uploaderName;
  String uploaderImageUrl;
  String uploaderUid;
  Timestamp uploadTime;
  String storyId;

  StoryModel({
    required this.description,
    required this.storyImageUrl,

    required this.uploaderName,
    required this.uploaderImageUrl,
    required this.uploaderUid,
    required this.uploadTime,
    required this.storyId});


  toMap() =>
      {
        StoryModelFields.description: description,
        StoryModelFields.storyId: storyId,
        StoryModelFields.storyImageUrl: storyImageUrl,
        StoryModelFields.uploaderImageUrl: uploaderImageUrl,
        StoryModelFields.uploaderName: uploaderName,
        StoryModelFields.uploaderUid: uploaderUid,
        StoryModelFields.uploadTime: uploadTime,
        "expiryTime":Timestamp.fromDate(DateTime(uploadTime.toDate().year,uploadTime.toDate().day+1,uploadTime.toDate().hour,uploadTime.toDate().minute))
      };

  factory StoryModel.fromJson(Map<String,dynamic> json)=>
      StoryModel(
          description: json[StoryModelFields.description]??"",
          storyImageUrl: json[StoryModelFields.storyImageUrl]??"",
          uploaderName: json[StoryModelFields.uploaderName]??"",
          uploaderImageUrl: json[StoryModelFields.uploaderImageUrl]??"",
          uploaderUid: json[StoryModelFields.uploaderUid]??"",
          uploadTime: json[StoryModelFields.uploadTime]??"",
          storyId: json[StoryModelFields.storyId]??"");

}