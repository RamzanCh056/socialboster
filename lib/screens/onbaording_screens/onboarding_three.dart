import 'package:flutter/material.dart';
import 'package:social_boster/screens/auth_screen/auth_screen.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class OnBoardingThree extends StatelessWidget {
  const OnBoardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body:   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Spacer(),
          const Image(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/onboarding_Screen/reach.jpg")),
          const Spacer(),
          Text(
            "Reach the target",
            textAlign: TextAlign.center,
            style: AppTextStyles.boldStyle.copyWith(color: AppColors.lightBlack,fontSize: 28),
          ),
          const SizedBox(height: 15,),
          Text(
            "Elevate your social game with our Followers Booster app. Turn followers into a thriving community",
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumStyle.copyWith(color: AppColors.primaryGray,fontSize: 20),
          ),
          const SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(shape: BoxShape.circle,
                  color: AppColors.primaryColor),
              child: const Center(child: Icon(Icons.arrow_forward_ios,color: AppColors.primaryWhite,),),),
          ),
          const SizedBox(height: 15,)


        ],),
    ),)
      ,
    );
  }
}
