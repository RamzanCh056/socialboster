import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_boster/screens/auth_screen/auth_screen.dart';
import 'package:social_boster/screens/auth_screen/signup_screen.dart';
import 'package:social_boster/services/auth_services/auth_services.dart';
import 'package:social_boster/themes/app_text_styles.dart';

import '../../themes/app_colors.dart';
import '../bottom_nav_bar_screen/bottom_nav_bar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Center(
                child: Text(
                  "Login",
                  style: AppTextStyles.boldStyle,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Email",
                style: AppTextStyles.mediumStyle,
              ),
              const SizedBox(height: 10),
               TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
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
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Type your password",
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyles.mediumStyle
                          .copyWith(color: AppColors.primaryBlue),
                    )),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                title: "Login",
                loader: isLoading,
                onTap: ()async{
                  if(emailController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Email is required");
                  }else if(passwordController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Password must not be empty");
                  }else{
                    setState(() {
                      isLoading=true;
                    });
                  }
                  await AuthServices().signIn(emailController.text, passwordController.text);
                  setState(() {
                    isLoading=false;
                  });
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const SignupScreen();
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    const SizedBox(width: 5),
                    Text(
                      "Signup",
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
}
