import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';

class HashTagGroupScreen extends StatefulWidget {
  const HashTagGroupScreen({super.key});

  @override
  State<HashTagGroupScreen> createState() => _HashTagGroupScreenState();
}

class _HashTagGroupScreenState extends State<HashTagGroupScreen> {
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

  List<String> reelsTitles = [
    'DartMastermind',
    'Fluttering with Code',
    'Darting into the Future',
    'CodeCrafting Adventures',
    'Flutter Finesse',
    'Darting Through Challenges',
    'Code Ninja Vibes',
    'FlutterJoy: Code & Play!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Reels Trending Sound",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 15,
            child: const Icon(
              Icons.window,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 15,
            child: const Icon(
              Icons.bookmark,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 15,
            child: const Icon(
              Icons.filter_list,
              size: 20,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Trending Now",
                          style: AppTextStyles.mediumStyle
                              .copyWith(color: AppColors.primaryWhite),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text("Trending Now", style: AppTextStyles.mediumStyle),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 8,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 80,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              images[index],
                            ),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        reelsTitles[index],
                        style: AppTextStyles.mediumStyle,
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "Crafting Code",
                            style: AppTextStyles.regularStyle,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 22,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryColor),
                            child: Center(
                              child: Text(
                                "${(index + 1) * 112} reels",
                                style: AppTextStyles.mediumStyle
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      trailing: const FittedBox(
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.instagram),
                            SizedBox(width: 5),
                            Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
