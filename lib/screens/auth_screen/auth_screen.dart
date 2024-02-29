import 'package:flutter/material.dart';
import 'package:social_boster/screens/auth_screen/signup_screen.dart';
import 'package:social_boster/themes/app_colors.dart';
import 'package:social_boster/themes/app_text_styles.dart';

import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(
                image: AssetImage("assets/images/onboarding_Screen/auth.jpg")),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryBlue),
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryWhite),
                child: Center(
                  child: Text(
                    "Log in",
                    style: AppTextStyles.semiBoldStyle
                        .copyWith(color: AppColors.primaryBlue),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
              title: "Create new account",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignupScreen();
                }));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'By sign up you are agree to the ',
                    style: AppTextStyles.semiBoldStyle
                        .copyWith(color: AppColors.primaryBlack, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Term of use & privacy policy',
                        style: AppTextStyles.semiBoldStyle.copyWith(
                            color: AppColors.primaryColor, fontSize: 16),
                      )
                    ])),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback? onTap;
  final String title;
  bool? loader;
   PrimaryButton({
    super.key,
    this.onTap,
    required this.title,
    this.loader=false
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: widget.loader!?const CircularProgressIndicator(color: Colors.white,):Text(
            widget.title,
            style: AppTextStyles.semiBoldStyle
                .copyWith(color: AppColors.primaryWhite),
          ),
        ),
      ),
    );
  }
}
