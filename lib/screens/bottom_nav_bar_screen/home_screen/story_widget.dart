


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/home_screen/home_screen_services.dart';

import '../../../models/user_model.dart';

class StoryWidget extends StatefulWidget {

  File? file;
  UserModel user;


  StoryWidget({required this.file,required this.user});

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: Get.height/3.5,
              width: Get.width,
              child: Image.file(widget.file!)),
        ],
      ),
      actions: [
        TextButton(
            onPressed: ()async{
              Navigator.pop(context);
            }, child: Text("Cancel")),
        TextButton(
            onPressed: ()async{

              await HomeScreenServices
                ().postStory("", widget.file!, widget.user, context,);
              Navigator.pop(context);
            }, child: Text("Post"))
      ],
    );
  }
}