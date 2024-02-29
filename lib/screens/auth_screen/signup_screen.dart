import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_boster/models/user_model.dart';
import 'package:social_boster/screens/auth_screen/auth_screen.dart';
import 'package:social_boster/screens/auth_screen/login_screen.dart';
import 'package:social_boster/services/auth_services/auth_services.dart';
import 'package:social_boster/themes/app_text_styles.dart';

import '../../themes/app_colors.dart';
import '../bottom_nav_bar_screen/bottom_nav_bar_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
        EdgeInsets.fromLTRB(15, MediaQuery
            .of(context)
            .padding
            .top, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Text(
                  "Signup",
                  style: AppTextStyles.boldStyle,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Name",
                style: AppTextStyles.mediumStyle,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Type your Name",
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Email",
                style: AppTextStyles.mediumStyle,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Type your email",
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Password",
                style: AppTextStyles.mediumStyle,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Type your password",
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                title: "Signup",
                loader: isLoading,
                onTap: () async {
                  print("Button pressed");
                  if(nameController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Name is required");
                  }else if(emailController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Email is required");
                  }else if(passwordController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Password is required");
                  }else{
                    print("Everything is fine");
                    try{
                      setState(() {
                        isLoading=true;
                      });
          
                      UserModel user = UserModel(
                          userName: nameController.text,
                          userEmail: emailController.text,
                          userPassword: passwordController.text,
                          userProfileImage: "",
                          userAccountCreationDate: Timestamp.now().toDate(),
                        userUid: "",
                        userPostsLimit: 10,
                        premiumUser: false,
                        userFollowing: 0,
                        userFollowers: 0
                      );
                      print("Before");
                      await AuthServices().signUp(user: user, context: context);
                      print("After");
                      setState(() {
                        isLoading=false;
                      });
                    }catch(e){
                      setState(() {
                        isLoading=false;
                      });
                    }
          
                  }
          
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const LoginScreen();
                      }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account ?"),
                    const SizedBox(width: 5),
                    Text(
                      "Login",
                      style: AppTextStyles.mediumStyle
                          .copyWith(color: AppColors.primaryBlue),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  FirebaseAuth instance=FirebaseAuth.instance;
  FirebaseFirestore db=FirebaseFirestore.instance;

  signUp({required UserModel user, required BuildContext context})async{
    print("Call");
    try{
      print("create user");
      await instance.createUserWithEmailAndPassword(email: user.userEmail, password: user.userPassword).then((userData)async {
        if(userData.user!=null){
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
}
