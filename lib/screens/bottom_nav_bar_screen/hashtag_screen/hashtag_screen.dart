import 'package:flutter/material.dart';
import 'package:social_boster/themes/app_colors.dart';

import 'hashtag_group_screen.dart';

class HashTagScreen extends StatefulWidget {
  const HashTagScreen({super.key});

  @override
  State<HashTagScreen> createState() => _HashTagScreenState();
}

class _HashTagScreenState extends State<HashTagScreen> {
  int _currentIndex = 0;
  List<String> hashTag = [
    '#Breathe',
    '#Chill',
    '#Spark',
    '#Glow',
    '#Dream',
    '#Rise',
    '#Shine',
    '#Explore',
    '#Create',
    '#Love',
    '#Laugh',
    '#Play',
    '#Grow',
    '#Hope',
    '#Joy',
    '#Simplify',
    '#Thrive',
    '#Imagine',
    '#Nourish',
    '#Kindness',
    '#Balance',
    '#Harmony',
    '#Radiate',
    '#Calm',
    '#Serene',
    '#Delight',
    '#Inspire',
    '#Empower',
    '#Renew',
    '#Gratitude',
    '#Wonder',
    '#SerenityNow',
    '#Rejoice',
    '#SmileMore',
    '#CultivateJoy',
    '#NurtureSelf',
    '#Elevate',
    '#Revitalize',
    '#Refresh',
    '#Unwind',
    '#Vivid',
    '#VibrantLife',
    '#Gentle',
    '#SavorLife',
    '#CultivateKindness',
    '#Soulful',
    '#Blossom',
    '#Revive',
    '#Uplift',
    '#Tranquil',
    '#Blissful',
  ];

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
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Type up to 3 keywords",
                          contentPadding: const EdgeInsets.only(left: 10),
                          prefixIcon: const Icon(Icons.tag),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.filter_list),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.window,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const HashTagGroupScreen();
                              }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _currentIndex == 0
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade300,
                              ),
                              child: Center(
                                child: Text(
                                  "Hashtag Groups",
                                  style: TextStyle(
                                      color: _currentIndex == 0
                                          ? AppColors.primaryWhite
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: _currentIndex == 1
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade300,
                              ),
                              child: Center(
                                child: Text(
                                  "Handpick Hashtag",
                                  style: TextStyle(
                                      color: _currentIndex == 1
                                          ? AppColors.primaryWhite
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.bookmark,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                  hashTag.length,
                  (index) => IntrinsicWidth(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.primaryColor),
                          child: Center(
                            child: Text(
                              hashTag[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
