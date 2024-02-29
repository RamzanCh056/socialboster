


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_boster/models/user_model.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';

class AuthServices{
  FirebaseAuth instance=FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;

  signUp({required UserModel user, required BuildContext context})async{
    print("Call");
    try{
      print("create user");
      await instance.createUserWithEmailAndPassword(email: user.userEmail, password: user.userPassword).then((userData)async {
        if(userData.user!=null){
          user.userUid=userData.user!.uid;
          await db.collection("users").doc(userData.user!.uid).set(user.toMap()).then((value){
            Fluttertoast.showToast(msg: "Account Created Successfully");
            Get.to(()=>const BottomNavBarScreen());
          });
        }
      }).onError((error, stackTrace) {Fluttertoast.showToast(msg: "Error: $error");});
    }catch(e){
      Fluttertoast.showToast(msg: "Error: $e");
    }

  }

  signIn(String email, String password)async{
    try{
      await instance.signInWithEmailAndPassword(email: email, password: password).then((user){
        if(user.user!=null){
          Get.to(()=>BottomNavBarScreen());
        }
      });
    }catch(e)
    {
      Fluttertoast.showToast(msg: "Error: $e");
    }

  }

}