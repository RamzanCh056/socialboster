import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/models/feed_model.dart';
import 'package:social_boster/models/story_model.dart';
import 'package:social_boster/models/user_model.dart';

import '../../../providers/user_provider.dart';
import '../../../services/storage_services.dart';

class HomeScreenServices {

  final picker = ImagePicker();

  Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }


  Future<bool?> postLink(String link, UserModel user,
      BuildContext context,bool isImage) async {

      String docId = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      Timestamp uploadingTime=Timestamp.now();
      FeedModel feed = FeedModel(
          description: link,
          imageOrVideoUrl: link,
          isImage: isImage,
          uploaderName: user.userName,
          uploaderImageUrl: user.userProfileImage,
          uploaderUid: FirebaseAuth.instance.currentUser!.uid,
          uploadTime: uploadingTime,
          feedOrVideoId: docId,
        views: 0
      );
      await FirebaseFirestore.instance.collection("feeds").doc(docId).set(
          feed.toMap()
      );


      Fluttertoast.showToast(msg: "Shared successfully");
      return true;

  }

  Future<bool?> postFeed(String description, File file, UserModel user,
      BuildContext context,bool isImage) async {
    String fileName = file.path
        .split("/")
        .last;


    String storagePath = 'stories/${DateTime
        .now()
        .millisecondsSinceEpoch}$fileName';

    String? downloadURL = await StorageServices().uploadFile(
        File(file.path),
        storagePath,
        context
    );

    if (downloadURL != null) {


      String docId = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      Timestamp uploadingTime=Timestamp.now();
      FeedModel feed = FeedModel(
          description: description,
          imageOrVideoUrl: downloadURL,
          isImage: isImage,
          uploaderName: user.userName,
          uploaderImageUrl: user.userProfileImage,
          uploaderUid: FirebaseAuth.instance.currentUser!.uid,
          uploadTime: uploadingTime,
          feedOrVideoId: docId,
        views: 0
      );
      await FirebaseFirestore.instance.collection("feeds").doc(docId).set(
          feed.toMap()
      );


      Fluttertoast.showToast(msg: "Shared successfully");
      return true;
    } else {
      // Handle error
      print('Failed to upload image.');
      return false;
    }
  }


  Future<bool?> postStory(String description, File file, UserModel user,
      BuildContext context) async {
    String fileName = file.path
        .split("/")
        .last;


    String storagePath = 'stories/${DateTime
        .now()
        .millisecondsSinceEpoch}$fileName';

    String? downloadURL = await StorageServices().uploadFile(
        File(file.path),
        storagePath,
        context
    );

    if (downloadURL != null) {
      String docId = DateTime
          .now()
          .microsecondsSinceEpoch
          .toString();
      Timestamp uploadingTime=Timestamp.now();

      StoryModel story = StoryModel(
          description: description,
          storyImageUrl: downloadURL,
          uploaderName: user.userName,
          uploaderImageUrl: user.userProfileImage,
          uploaderUid: FirebaseAuth.instance.currentUser!.uid,
          uploadTime: uploadingTime,
          storyId: docId);
      await FirebaseFirestore.instance.collection("stories").doc(docId).set(
          story.toMap()
      );

      Fluttertoast.showToast(msg: "Shared successfully");
      return true;
    } else {
      // Handle error
      print('Failed to upload image.');
      return false;
    }
  }



}