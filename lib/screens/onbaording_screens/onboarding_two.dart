import 'package:concentric_transition/page_route.dart';
import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import 'onboarding_three.dart';

class OnBoardingTwo extends StatelessWidget {
  const OnBoardingTwo({super.key});

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
              image: AssetImage("assets/images/onboarding_Screen/best solutin.png")),
          const Spacer(),
          Text(
            "Give the best solution",
            textAlign: TextAlign.center,
            style: AppTextStyles.boldStyle.copyWith(color: AppColors.lightBlack,fontSize: 28),
          ),
          const SizedBox(height: 15,),
          Text(
            "Unlock your social potential",
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumStyle.copyWith(color: AppColors.primaryGray,fontSize: 20),
          ),
          const SizedBox(height: 10,),
          Text(
            "Join the community, amplify your voice, and let your story unfold in every click.",
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBoldStyle.copyWith(color: AppColors.primaryGray,fontSize: 18),
          ),
          const SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, ConcentricPageRoute(builder: (context)=>const OnBoardingThree()));
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
