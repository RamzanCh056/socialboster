



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:social_boster/models/user_model.dart';
import 'package:social_boster/utils/firebase_consts.dart';

class UserProvider extends ChangeNotifier{
  UserModel? user;

  getUser()async{
    await FirebaseFirestore.instance.collection(FirebaseConsts.userCollection).doc(FirebaseAuth.instance.currentUser!.uid).get().then((data){
      if(data.exists){
        user= UserModel.fromJson(data.data()!);
        notifyListeners();
      }
    });
  }

}