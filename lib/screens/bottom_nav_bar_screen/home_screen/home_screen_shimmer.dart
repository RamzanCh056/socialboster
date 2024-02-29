import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/models/user_model.dart';
import 'package:social_boster/providers/upload_progress_provider.dart';
import 'package:social_boster/providers/user_provider.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/home_screen/home_screen_services.dart';
import 'package:social_boster/shimmer/shimmer_effect.dart';
import 'package:social_boster/themes/app_colors.dart';
import 'package:social_boster/themes/app_text_styles.dart';

class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({super.key});

  @override
  State<HomeScreenShimmer> createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer> {
  final List<String> images = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
    "assets/images/6.jpg",
    "assets/images/7.jpg",
    "assets/images/8.jpg",
  ];

  File? feedImage;
  TextEditingController feedDescriptionController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:
      EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerEffect(height: 20, width: Get.width*.4),
                ShimmerEffect(height: 20, width: 20),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(images.length, (index) {
                  return Stack(
                    children: [
                      ShimmerEffect(height: 60, width: 60)
                    ],
                  )
                      ;
                }),
              ),
            ),
            const SizedBox(height: 20),
            ShimmerEffect(height: 60, width: Get.width),

            const SizedBox(height: 20),
            GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.42,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [

                      const SizedBox(height: 10),
                      ShimmerEffect(
                        width: double.infinity,
                        height: 250,

                      ),

                      const SizedBox(width: 5),
                      ShimmerEffect(height: 20, width: 30)
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
