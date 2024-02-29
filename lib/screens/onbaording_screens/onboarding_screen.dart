import 'package:concentric_transition/concentric_transition.dart';
import 'package:concentric_transition/page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_boster/screens/onbaording_screens/onboarding_two.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Spacer(),
          const Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/onboarding_Screen/6-tips-onboarding-tehnical-employees.png")),
          const Spacer(),
          Text(
            "Grow Account",
            textAlign: TextAlign.center,
            style: AppTextStyles.boldStyle.copyWith(color: AppColors.lightBlack,fontSize: 28),
          ),
          const SizedBox(height: 15,),
          Text(
              "Embark on a journey of connection",
              textAlign: TextAlign.center,
              style: AppTextStyles.mediumStyle.copyWith(color: AppColors.primaryGray,fontSize: 18,)
          ),
          const SizedBox(height: 10,),
          Text(
            "Swipe, share, and shine as you cultivate your social presence with us!",
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBoldStyle.copyWith(color: AppColors.primaryGray,fontSize: 18),
          ),
          const SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
              Navigator.push(context,ConcentricPageRoute(builder: (context)=>const OnBoardingTwo()));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(shape: BoxShape.circle,
                  color: AppColors.primaryColor),
              child: const Center(child: Icon(Icons.arrow_forward_ios,color: AppColors.primaryWhite,),),),
          ),
          const SizedBox(height: 15,)


        ],),
    )
    )

    );
  }
}
