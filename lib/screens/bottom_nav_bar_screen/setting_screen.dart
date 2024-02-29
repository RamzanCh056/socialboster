import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/models/feed_model.dart';
import 'package:social_boster/providers/upload_progress_provider.dart';
import 'package:social_boster/providers/user_provider.dart';
import 'package:social_boster/screens/auth_screen/login_screen.dart';
import 'package:social_boster/services/storage_services.dart';
import 'package:social_boster/shimmer/shimmer_effect.dart';
import 'package:social_boster/themes/app_colors.dart';
import 'package:social_boster/themes/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<String> images = [
    "assets/images/8.jpg",
    "assets/images/1.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/7.jpg",
    "assets/images/2.jpg",
    "assets/images/5.jpg",
    "assets/images/6.jpg",
  ];
  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String storagePath = 'images/${DateTime.now().millisecondsSinceEpoch}.png';

      String? downloadURL = await StorageServices().uploadFile(
        File(pickedFile.path),
        storagePath,
           context
      );

      if (downloadURL != null) {
        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
          {"profileImage":downloadURL}
        );
        Fluttertoast.showToast(msg: "Successfully updated");
        Provider.of<UserProvider>(context,listen: false).getUser();
        // Do something with the download URL
        print('Image uploaded successfully. URL: $downloadURL');
      } else {
        // Handle error
        print('Failed to upload image.');
      }
    }
  }

  int followers=0;
  int following=0;
  getFollowersAndFollowing()async{
    following=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("following").snapshots().length;
    followers=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("followers").snapshots().length;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getFollowersAndFollowing();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions:  [
          Icon(
            Icons.upload_sharp,
            color: Colors.grey,
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: ()async{
              await FirebaseAuth.instance.signOut().then((value){
                Get.to(()=>LoginScreen());
              });
            },
            child: Icon(
              Icons.logout,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer2<UserProvider,UploadProgressProvider>(
          builder: (context,user,uploadProgress,_) {
            return SingleChildScrollView(
                child: Stack(

                  children: [
                    Column(
                                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: user.user!.userProfileImage.isNotEmpty?NetworkImage(user.user!.userProfileImage):null,
                              child: user.user!.userProfileImage.isEmpty?Image.asset("assets/images/3.png"):
                              null,
                            ),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: Container(

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0x20000000),
                                ),
                                child: IconButton(
                                    onPressed: ()async{
                                     await uploadImage();
                                    },
                                    icon: Icon(Icons.camera_alt_outlined,color: Colors.white,)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.user!=null?user.user!.userName:"Unknown",
                                style: AppTextStyles.boldStyle,
                              ),
                              Text(
                                "Boost",
                                style: AppTextStyles.regularStyle
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                "Booster Follower",
                                style: AppTextStyles.mediumStyle
                                    .copyWith(color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Followers",
                                            style: AppTextStyles.regularStyle
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        user.user!.userFollowers.toString(),
                                        style: AppTextStyles.mediumStyle,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Following",
                                            style: AppTextStyles.regularStyle
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        user.user!.userFollowing.toString(),
                                        style: AppTextStyles.mediumStyle,
                                      )
                                    ],
                                  ),
                                  // Container(
                                  //   height: 30,
                                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(5),
                                  //     color: AppColors.primaryColor,
                                  //   ),
                                  //   child: Center(
                                  //     child: Text(
                                  //       "Message",
                                  //       style: AppTextStyles.regularStyle
                                  //           .copyWith(color: Colors.white),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("feeds").where(FeedModelFields.uploaderUid,isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          SettingLoadingShimmer();
                        }
                        if(snapshot.connectionState==ConnectionState.waiting){
                          SettingLoadingShimmer();
                        }

                        return snapshot.data!=null?
                        snapshot.data!.docs.isEmpty?
                            Text("No data found"):
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              FeedModel feed=FeedModel.fromJson(snapshot.data!.docs[index].data());
                              return AnyLinkPreview(
                                onTap:()async{

                                  await FirebaseFirestore.instance.collection("feeds").doc(feed.feedOrVideoId).update({
                                    FeedModelFields.views:FieldValue.increment(1)
                                  });

                                  if (!await launchUrl(Uri.parse(feed.imageOrVideoUrl))) {
                                    throw Exception('Could not launch ');
                                  }

                                },
                                link: feed.imageOrVideoUrl,
                                displayDirection: UIDirection.uiDirectionHorizontal,
                                showMultimedia: false,
                                bodyMaxLines: 5,
                                bodyTextOverflow: TextOverflow.ellipsis,
                                titleStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                errorBody: 'Show my custom error body',
                                errorTitle: 'Show my custom error title',
                                errorWidget: Container(
                                  color: Colors.grey[300],
                                  child: Text('Oops!'),
                                ),
                                errorImage: "https://google.com/",
                                cache: Duration(days: 7),
                                backgroundColor: Colors.grey[300],
                                borderRadius: 12,
                                removeElevation: false,
                                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],

                              );
                            }):
                        SettingLoadingShimmer();
                      }
                    ),
                                  ],
                                ),

                    Visibility(
                      visible: uploadProgress.uploading,
                      child: Positioned(
                        bottom: 300,
                        child: Container(
                          width: Get.width,
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${(uploadProgress.progressPercentage * 100).toStringAsFixed(2)}%'),
                              LinearProgressIndicator(
                                  value: uploadProgress.progressPercentage,
                                backgroundColor: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                minHeight: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ));
          }
        ),
      ),
    );
  }
}

class SettingLoadingShimmer extends StatelessWidget {
  const SettingLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return ShimmerEffect(height: Get.width/2.5, width: Get.width/2.5);
        });
  }
}
