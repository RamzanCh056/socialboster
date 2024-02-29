
import 'package:social_boster/stripe_payment/stripe_payment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/models/feed_comment_model.dart';
import 'package:social_boster/models/feed_like_model.dart';
import 'package:social_boster/models/feed_model.dart';
import 'package:social_boster/models/story_model.dart';
import 'package:social_boster/models/user_model.dart';
import 'package:social_boster/providers/upload_progress_provider.dart';
import 'package:social_boster/providers/user_provider.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/home_screen/home_screen_services.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/home_screen/home_screen_shimmer.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/home_screen/story_widget.dart';
import 'package:social_boster/themes/app_colors.dart';
import 'package:social_boster/themes/app_text_styles.dart';

import 'feed_comment_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  File? storyImage;
  TextEditingController feedDescriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  RegExp urlPattern = RegExp(r'^(ftp|http|https):\/\/[^ "]+$');

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, _) {
        return Padding(
          padding:
          EdgeInsets.fromLTRB(15, MediaQuery
              .of(context)
              .padding
              .top, 15, 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<UserProvider>(
                        builder: (context, user, _) {
                          return Text(
                            "Welcome ${user.user != null
                                ? user.user!.userName
                                : ""}",
                            style: AppTextStyles.boldStyle,
                          );
                        }
                    ),
                    const Icon(Icons.search)
                  ],
                ),
                const SizedBox(height: 20),
                // StreamBuilder(
                //   stream: FirebaseFirestore.instance.collection("stories").snapshots(),
                //   builder: (context, snapshot) {
                //     if(!snapshot.hasData){
                //       return CircleAvatar();
                //     }
                //
                //     return SizedBox(
                //       width: Get.width,
                //       height: 60,
                //       child: Row(
                //         children: [
                //       InkWell(
                //               onTap: ()async{
                //                 storyImage = await HomeScreenServices().pickImage();
                //                 if(storyImage!=null){
                //                   showDialog(context: context,
                //                       builder: (context){
                //                     return StoryWidget(file: storyImage!, user: user.user!);
                //                       });
                //                 }
                //               },
                //               child: Stack(
                //                 children: [
                //                   Container(
                //                     height: 60,
                //                     width: 60,
                //                     padding: const EdgeInsets.all(5),
                //                     margin: const EdgeInsets.only(right: 10),
                //                     decoration: const BoxDecoration(
                //                       shape: BoxShape.circle,
                //                     ),
                //                     child: Container(
                //                       padding: const EdgeInsets.all(5),
                //                       decoration: BoxDecoration(
                //                         shape: BoxShape.circle,
                //                         image: DecorationImage(
                //                           fit: BoxFit.fill,
                //                           image: NetworkImage(user.user!.profileImage),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                   const Positioned(
                //                     right: 0,
                //                     bottom: 0,
                //                     child: CircleAvatar(
                //                       radius: 15,
                //                       backgroundColor: Colors.white,
                //                       child: Icon(
                //                         Icons.add,
                //                         color: AppColors.primaryColor,
                //                         size: 20,
                //                       ),
                //                     ),
                //                   ),
                //                                           ],
                //                                         ),
                //                 ),
                //           SizedBox(
                //             height: 60,
                //             width: Get.width*.7,
                //             child: ListView.builder(
                //               itemCount: snapshot.data!.docs.length,
                //               scrollDirection: Axis.horizontal,
                //                 itemBuilder: (context,index){
                //                 StoryModel story=StoryModel.fromJson(snapshot.data!.docs[index].data());
                //                   return Container(
                //                               height: 60,
                //                               width: 60,
                //                               padding: const EdgeInsets.all(5),
                //                               margin: const EdgeInsets.only(right: 10),
                //                               decoration: BoxDecoration(
                //                                 shape: BoxShape.circle,
                //                                 border: Border.all(
                //                                   width: 2,
                //                                   color: AppColors.primaryColor,
                //                                 ),
                //                               ),
                //                               child: Container(
                //                                 padding: const EdgeInsets.all(5),
                //                                 decoration: BoxDecoration(
                //                                     shape: BoxShape.circle,
                //                                     image: DecorationImage(
                //                                       fit: BoxFit.fill,
                //                                       image: NetworkImage(story.storyImageUrl),
                //                                     )),
                //                               ),
                //                             );
                //
                //                 }
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //
                //     //   SingleChildScrollView(
                //     //   scrollDirection: Axis.horizontal,
                //     //   child: Row(
                //     //     children: List.generate(images.length, (index) {
                //     //       return index == 0
                //     //           ? InkWell(
                //     //         onTap: ()async{
                //     //           storyImage = await HomeScreenServices().pickImage();
                //     //           if(storyImage!=null){
                //     //             showDialog(context: context,
                //     //                 builder: (context){
                //     //               return StoryWidget(file: storyImage!, user: user.user!);
                //     //                 });
                //     //           }
                //     //         },
                //     //         child: Stack(
                //     //                                     children: [
                //     //             Container(
                //     //               height: 60,
                //     //               width: 60,
                //     //               padding: const EdgeInsets.all(5),
                //     //               margin: const EdgeInsets.only(right: 10),
                //     //               decoration: const BoxDecoration(
                //     //                 shape: BoxShape.circle,
                //     //               ),
                //     //               child: Container(
                //     //                 padding: const EdgeInsets.all(5),
                //     //                 decoration: BoxDecoration(
                //     //                   shape: BoxShape.circle,
                //     //                   image: DecorationImage(
                //     //                     fit: BoxFit.fill,
                //     //                     image: NetworkImage(user.user!.profileImage),
                //     //                   ),
                //     //                 ),
                //     //               ),
                //     //             ),
                //     //             const Positioned(
                //     //               right: 0,
                //     //               bottom: 0,
                //     //               child: CircleAvatar(
                //     //                 radius: 15,
                //     //                 backgroundColor: Colors.white,
                //     //                 child: Icon(
                //     //                   Icons.add,
                //     //                   color: AppColors.primaryColor,
                //     //                   size: 20,
                //     //                 ),
                //     //               ),
                //     //             ),
                //     //                                     ],
                //     //                                   ),
                //     //           )
                //     //           : Container(
                //     //         height: 60,
                //     //         width: 60,
                //     //         padding: const EdgeInsets.all(5),
                //     //         margin: const EdgeInsets.only(right: 10),
                //     //         decoration: BoxDecoration(
                //     //           shape: BoxShape.circle,
                //     //           border: Border.all(
                //     //             width: 2,
                //     //             color: AppColors.primaryColor,
                //     //           ),
                //     //         ),
                //     //         child: Container(
                //     //           padding: const EdgeInsets.all(5),
                //     //           decoration: BoxDecoration(
                //     //               shape: BoxShape.circle,
                //     //               image: DecorationImage(
                //     //                 fit: BoxFit.fill,
                //     //                 image: AssetImage(images[index]),
                //     //               )),
                //     //         ),
                //     //       );
                //     //     }),
                //     //   ),
                //     // );
                //   }
                // ),
                // const SizedBox(height: 20),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: feedDescriptionController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "Paste your link here",
                            border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          if(urlPattern.hasMatch(feedDescriptionController.text)){
                            if(user.user!.premiumUser==false && user.user!.userPostsLimit>=10){
                              Fluttertoast.showToast(msg: "Your limit is reached, please buy premium to upload unlimited links");
                              showDialog(context: context, builder: (dialogContext){
                                return AlertDialog(
                                  content: Text("Your limit is reached, please buy premium to upload unlimited links"),
                                  actions: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(dialogContext);
                                    }, child: Text("Cancel")),
                                    ElevatedButton(onPressed: ()async{
                                      Navigator.pop(dialogContext);
                                      await StripeServices().makePayment(context, "10", "Social Booster");
                                    }, child: Text("Buy Premium"))
                                  ],
                                );
                              });
                            }else{
                              await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                UserModel.postLimit: FieldValue.increment(1)
                              });
                              await HomeScreenServices().postLink(
                                  feedDescriptionController.text, user.user!, context, false).then((value){
                                feedDescriptionController.clear();
                                setState(() {

                                });
                              });
                            }
                            
                          }else{
                            Fluttertoast.showToast(msg: "Invalid link");
                          }
                          // feedImage = await HomeScreenServices().pickImage();
                          setState(() {

                          });
                          // print("Feed image: $feedImage");
                          // if (feedImage != null) {
                          //
                          // }
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            // Icons.image,
                            Icons.send,
                            color: AppColors.primaryWhite,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // CircleAvatar(
                      //   backgroundColor: AppColors.primaryColor,
                      //   child: Icon(
                      //     Icons.text_fields,
                      //     color: AppColors.primaryWhite,
                      //     size: 20,
                      //   ),
                      // ),
                      // SizedBox(width: 10),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: feedImage != null ? true : false,
                //   child: Column(
                //     children: [
                //       const SizedBox(height: 20),
                //       SizedBox(
                //         child: feedImage != null ? Image.file(feedImage!) : SizedBox
                //             .shrink(),
                //       ),
                //       Row(
                //         children: [
                //           TextButton(onPressed: () {
                //             showDialog(
                //                 context: context,
                //                 builder: (context) {
                //                   return AlertDialog(
                //                     content: Text("Are you sure to cancel post"),
                //                     actions: [
                //                       TextButton(onPressed: () {
                //                         Navigator.pop(context);
                //                       }, child: Text("No")),
                //                       TextButton(onPressed: () {
                //                         feedImage = null;
                //                         feedDescriptionController.clear();
                //                         setState(() {
                //
                //                         });
                //                         Navigator.pop(context);
                //                       }, child: Text("Yes"))
                //                     ],
                //                   );
                //                 });
                //           }, child: Text("Cancel")),
                //           TextButton(onPressed: () async {
                //             if (feedDescriptionController.text.isEmpty) {
                //               showDialog(context: context,
                //                   builder: (context) {
                //                     return AlertDialog(
                //                       content: Text(
                //                           "You are posting image without description. Are you sure to proceed"),
                //                       actions: [
                //                         TextButton(onPressed: () {
                //                           Navigator.pop(context);
                //                         }, child: Text("Cancel")),
                //                         TextButton(onPressed: () async {
                //                           await HomeScreenServices().postFeed(
                //                               feedDescriptionController.text,
                //                               feedImage!, Provider
                //                               .of<UserProvider>(
                //                               context, listen: false)
                //                               .user!, context, true);
                //                         }, child: Text("Post"))
                //                       ],
                //                     );
                //                   });
                //             } else {
                //               bool? status = await HomeScreenServices().postFeed(
                //                   feedDescriptionController.text, feedImage!,
                //                   Provider
                //                       .of<UserProvider>(context, listen: false)
                //                       .user!, context, true);
                //               if (status != null && status == true) {
                //                 feedImage = null;
                //                 feedDescriptionController.clear();
                //                 setState(() {
                //
                //                 });
                //               }
                //             }
                //           }, child: Text("Post"))
                //         ],
                //       )
                //     ],
                //   ),
                // ),

                const SizedBox(height: 20),
                Stack(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("feeds").orderBy(FeedModelFields.uploadTime,descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("No Feeds Found");
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return HomeScreenShimmer();
                          }
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              physics: const NeverScrollableScrollPhysics(),
                              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 1,
                              //   childAspectRatio: 0.42,
                              //   crossAxisSpacing: 20,
                              // ),
                              itemBuilder: (context, index) {
                                FeedModel feed = FeedModel.fromJson(snapshot.data!
                                    .docs[index].data());

                                fetchFollowing()async{
                                  print(feed.uploaderUid);
                                  QuerySnapshot following=await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("following").where("followerId",isEqualTo: feed.uploaderUid).get();
                                  if(following.docs.isNotEmpty){
                                    return true;
                                  }else{
                                    return false;
                                  }
                                }

                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          feed.uploaderImageUrl,
                                        ),
                                      ),
                                      title: Text(
                                        feed.uploaderName.capitalizeFirst!,
                                        style: AppTextStyles.mediumStyle,
                                      ),
                                      subtitle: Text(
                                        DateFormat.yMd().add_jm().format(
                                            feed.uploadTime.toDate()),
                                        style: AppTextStyles.regularStyle
                                            .copyWith(
                                            color: Colors.grey, fontSize: 8),
                                      ),
                                      trailing: feed.uploaderUid!=FirebaseAuth.instance.currentUser!.uid?
                                      FutureBuilder(
                                        future: fetchFollowing(),
                                        builder: (context, data) {
                                          if (data.connectionState == ConnectionState.waiting) {
                                            print("Loading");
                                            // Handle the loading state
                                            return SizedBox.shrink();
                                          } else if (data.hasError) {
                                            // Handle the error state
                                            print(data.error);
                                            return SizedBox.shrink();
                                          }
                                          print(data.data);
                                          return data.data==true?ElevatedButton(
                                              onPressed: ()async{
                                                Timestamp followTime=Timestamp.now();
                                                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("following").
                                                doc(feed.uploaderUid).delete();

                                                await FirebaseFirestore.instance.collection("users").doc(feed.uploaderUid).collection("followers").
                                                doc(FirebaseAuth.instance.currentUser!.uid).delete();
                                                await FirebaseFirestore.instance.collection("users").
                                                doc(feed.uploaderUid)
                                                    .update({
                                                  "followers": FieldValue.increment(-1),

                                                });
                                                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
                                                    .update({
                                                  "following": FieldValue.increment(-1),

                                                });
                                                await user!.getUser();
                                                setState(() {

                                                });

                                              },
                                              child: Text("Unfollow")):
                                          ElevatedButton(
                                              onPressed: ()async{
                                                Timestamp followTime=Timestamp.now();
                                                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("following").
                                                doc(feed.uploaderUid).set({
                                                  "followerId": feed.uploaderUid,
                                                  "followerName": feed.uploaderName,
                                                  "followerImageUrl": feed.uploaderImageUrl,
                                                  "followTime": followTime
                                                });
                                                await FirebaseFirestore.instance.collection("users").
                                                doc(feed.uploaderUid)
                                                    .update({
                                                  "followers": FieldValue.increment(1),

                                                });
                                                await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
                                                .update({
                                                  "following": FieldValue.increment(1),
                                                });

                                                await FirebaseFirestore.instance.collection("users").doc(feed.uploaderUid).collection("followers").
                                                doc(FirebaseAuth.instance.currentUser!.uid).set({
                                                  "followingId": user.user!.userUid,
                                                  "followingName": user.user!.userName,
                                                  "followingImageUrl": user.user!.userProfileImage,
                                                  "followingTime": followTime
                                                });

                                                await user!.getUser();

                                                setState(() {

                                                });
                                              },
                                              child: Text("Follow"));
                                        }
                                      ):null,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      // height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        // image: DecorationImage(
                                        //   fit: BoxFit.fill,
                                          // image: NetworkImage(feed.imageOrVideoUrl),
                                        // ),

                                      ),
                                      child:
                                      AnyLinkPreview(
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

                                      )

                                      // LinkPreview(
                                      //   enableAnimation: true,
                                      //   onPreviewDataFetched: (data) {
                                      //     // setState(() {
                                      //     //   // Save preview data to the state
                                      //     // });
                                      //   },
                                      //   previewData: null, // Pass the preview data from the state
                                      //   text: feed.imageOrVideoUrl,
                                      //   width: MediaQuery.of(context).size.width,
                                      // )
                                    ),
                                    const SizedBox(height: 10),
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("feeds").doc(
                                            feed.feedOrVideoId)
                                            .collection("likes")
                                            .snapshots(),
                                        builder: (context, likeSnapshots) {
                                          return StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("feeds").doc(
                                                  feed.feedOrVideoId).collection(
                                                  "comments").snapshots(),
                                              builder: (context, commentSnapshot) {
                                                bool liked = false;
                                                String myLikeId = "";
                                                if (likeSnapshots.hasData &&
                                                    likeSnapshots.data!.docs.any((
                                                        element) =>
                                                    element
                                                        .data()[FeedLikeModelFields
                                                        .likerUid] ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid)) {
                                                  liked = true;
                                                  myLikeId = likeSnapshots
                                                      .data!
                                                      .docs
                                                      .where((element) =>
                                                  element.data()[FeedLikeModelFields
                                                      .likerUid] ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .first
                                                      .data()[FeedLikeModelFields
                                                      .likeId];
                                                }
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        liked ? InkWell(
                                                            onTap: () async {
                                                              print(myLikeId);
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "feeds").doc(feed
                                                                  .feedOrVideoId)
                                                                  .collection(
                                                                  "likes").doc(
                                                                  myLikeId)
                                                                  .delete();
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "users")
                                                                  .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!.uid)
                                                                  .collection(
                                                                  "myLikedFeeds")
                                                                  .doc(myLikeId)
                                                                  .delete();
                                                            },
                                                            child: const Icon(
                                                              Icons.favorite_border,
                                                              color: Colors.red,)) :
                                                        InkWell(
                                                            onTap: () async {
                                                              UserModel user = Provider
                                                                  .of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                                  .user!;
                                                              String likeId = DateTime
                                                                  .now()
                                                                  .microsecondsSinceEpoch
                                                                  .toString();
                                                              String likeTime = DateTime
                                                                  .now().toString();

                                                              FeedLikeModel feedLike = FeedLikeModel(
                                                                  likeId: likeId,
                                                                  likerImageUrl: user
                                                                      .userProfileImage,
                                                                  likerName: user
                                                                      .userName,
                                                                  likerUid: FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                                  likeTime: likeTime,
                                                                  postId: feed
                                                                      .feedOrVideoId);
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "feeds")
                                                                  .doc(feed
                                                                  .feedOrVideoId)
                                                                  .collection(
                                                                  "likes")
                                                                  .doc(
                                                                  feedLike.likeId)
                                                                  .set(
                                                                  feedLike.toMap());
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                  "users")
                                                                  .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!.uid)
                                                                  .collection(
                                                                  "myLikedFeeds")
                                                                  .doc(
                                                                  feedLike.likeId)
                                                                  .set(
                                                                  feedLike.toMap());
                                                            },
                                                            child: const Icon(Icons
                                                                .favorite_border)),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          !likeSnapshots.hasData
                                                              ? "0"
                                                              : likeSnapshots.data!
                                                              .docs.length
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .regularStyle,
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              isDismissible: true,
                                                                isScrollControlled: true,
                                                                context: context,
                                                                builder: (context) {
                                                                  return CommentBottomSheet(postId: feed.feedOrVideoId,);

                                                                });
                                                          },
                                                          child: const Icon(Icons
                                                              .chat_bubble_outline),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          !commentSnapshot.hasData
                                                              ? "0"
                                                              : commentSnapshot
                                                              .data!.docs.length
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .regularStyle,
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {

                                                          },
                                                          child: const Icon(Icons
                                                              .remove_red_eye_outlined),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          feed.views
                                                              .toString(),
                                                          style: AppTextStyles
                                                              .regularStyle,
                                                        )
                                                      ],
                                                    ),
                                                    InkWell(
                                                        onTap: () {

                                                        },
                                                        child: const Icon(
                                                            Icons.more_horiz))
                                                  ],
                                                );
                                              }
                                          );
                                        }
                                    )
                                  ],
                                );
                              });
                        }
                    ),
                    Visibility(
                      visible: Provider
                          .of<UploadProgressProvider>(context)
                          .uploading,
                      child: Positioned(
                        bottom: 300,
                        child: Container(
                          width: Get.width,
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${(Provider
                                  .of<UploadProgressProvider>(context)
                                  .progressPercentage * 100).toStringAsFixed(2)}%'),
                              LinearProgressIndicator(
                                value: Provider
                                    .of<UploadProgressProvider>(context)
                                    .progressPercentage,
                                backgroundColor: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green),
                                minHeight: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
//
// class LinkPriviewWidget extends StatelessWidget {
//   const LinkPriviewWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return LinkPreview(
//       enableAnimation: true,
//       onPreviewDataFetched: (data) {
//
//       },
//       previewData: null, // Pass the preview data from the state
//       text: feed.feedOrVideoId,
//       width: MediaQuery.of(context).size.width,
//     );
//   }
// }
