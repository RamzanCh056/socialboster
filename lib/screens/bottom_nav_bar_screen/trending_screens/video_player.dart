import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/trending_screens/video_player_screen_services.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/controller.dart';
import '../../../models/feed_like_model.dart';
import '../../../models/feed_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/upload_progress_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../themes/color.dart';
import '../../widget/reusable_text.dart';

class Player extends StatefulWidget {
  final int i;

  Player({Key? key, required this.i,}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final PCC c = Get.find();

  TextEditingController videoTitleController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    c.videoPlayerControllers[widget.i]!.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PCC>(
      initState: (x) async {
        //Need to change conditions according preaload page count
        //Don't load too many pages it will cause performance issue.
        // Below is for 1 page preaload.
        if (c.api > 1) {
          await c.disposeController(c.api - 2);
        }
        if (c.api < c.videoPlayerControllers.length - 2) {
          await c.disposeController(c.api + 2);
        }
        if (!c.initilizedIndexes.contains(widget.i)) {
          await c.initializePlayer(widget.i);
        }
        if (c.api > 0) {
          if (c.videoPlayerControllers[c.api - 1] == null) {
            await c.initializeIndexedController(c.api - 1);
          }
        }
        if (c.api < c.videoPlayerControllers.length - 1) {
          if (c.videoPlayerControllers[c.api + 1] == null) {
            await c.initializeIndexedController(c.api + 1);
          }
        }
      },
      builder: (_) {
        if (c.videoPlayerControllers.isEmpty ||
            c.videoPlayerControllers[c.api] == null ||
            !c.videoPlayerControllers[c.api]!.value.isInitialized) {
          return const Center(
              child: CircularProgressIndicator(
            color: indigoColor,
          ));
        }

        if (widget.i == c.api) {
          //If Index equals Auto Play Index
          //Set AutoPlay True Here
          if (widget.i < c.videoPlayerControllers.length) {
            if (c.videoPlayerControllers[c.api]!.value.isInitialized) {
              c.videoPlayerControllers[c.api]!.play();
            }
          }
          print('AutoPlaying ${c.api}');
        }
        return Stack(
          children: [
            c.videoPlayerControllers.isNotEmpty &&
                    c.videoPlayerControllers[c.api]!.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      if (c.videoPlayerControllers[c.api]!.value.isPlaying) {
                        print("paused");
                        c.videoPlayerControllers[c.api]!.pause();
                      } else {
                        c.videoPlayerControllers[c.api]!.play();
                        print("playing");
                      }
                    },
                    child: VideoPlayer(c.videoPlayerControllers[c.api]!),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: indigoColor,
                  )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const ReusableText(title: "Following",size: 18,weight: FontWeight.w700,color: whiteColor,),
                  //     const SizedBox(width: 10,),
                  //     Container(
                  //       height: 15,
                  //       width: 2,
                  //       color: whiteColor,
                  //     ),
                  //     const SizedBox(width: 10,),
                  //     const ReusableText(title: "For You",size: 18,weight: FontWeight.w700,color: whiteColor,),
                  //
                  //   ],
                  // ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        //like
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("videos").doc(c.videoURLs[widget.i].feedOrVideoId).collection("likes").snapshots(),
                          builder: (context, likeSnapshots) {
                            if(!likeSnapshots.hasData){
                              return Text("0");
                            }

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

                            return Column(
                              children: [
                                InkWell(
                                  onTap:()async{
                                    if(liked){
                                     await FirebaseFirestore.instance.collection("videos").doc(c.videoURLs[widget.i].feedOrVideoId).collection("likes").doc(myLikeId).delete();
                                    }else{

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

                                        FeedLikeModel videoLike = FeedLikeModel(
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
                                            postId: c.videoURLs[widget.i]
                                                .feedOrVideoId);
                                        await FirebaseFirestore
                                            .instance
                                            .collection(
                                            "videos")
                                            .doc(c.videoURLs[widget.i].feedOrVideoId)
                                            .collection(
                                            "likes")
                                            .doc(
                                            videoLike.likeId)
                                            .set(
                                            videoLike.toMap());
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
                                            videoLike.likeId)
                                            .set(
                                            videoLike.toMap());

                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: blackColor.withOpacity(0.3),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: liked?redColor:whiteColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ReusableText(
                                  title: likeSnapshots.data!.docs.length.toString(),
                                  color: whiteColor,
                                  weight: FontWeight.w700,
                                ),
                              ],
                            );
                          }
                        ),

                        // SizedBox(
                        //   height: 10,
                        // ),
                        // //comment
                        // Container(
                        //   height: 35,
                        //   width: 35,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: blackColor.withOpacity(0.3),
                        //   ),
                        //   child: const Icon(
                        //     Icons.messenger,
                        //     color: whiteColor,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // ReusableText(
                        //   title: "104",
                        //   color: whiteColor,
                        //   weight: FontWeight.w700,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        //
                        Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blackColor.withOpacity(0.3),
                          ),
                          child: const Icon(
                            Icons.share,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //
                        InkWell(
                          onTap: ()async{
                            File? video=await VideoPlayerScreenServices().pickVideo();
                            if(video!=null){
                              await showDialog(context: context,
                                  builder: (dialogContext){
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            child: Expanded(
                                              child: TextField(
                                                controller: videoTitleController,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: 10),
                                                  hintText: "Enter video title here",
                                                  border:
                                                  UnderlineInputBorder(borderSide: BorderSide.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(onPressed: ()async{
                                            if(videoTitleController.text.isEmpty){
                                              Fluttertoast.showToast(msg: "Title must not be empty");
                                            }else{
                                              Navigator.pop(dialogContext);
                                              await VideoPlayerScreenServices().postVideo(videoTitleController.text, video!, Provider.of<UserProvider>(context,listen: false).user!, context, false);
                                            }
                                          }, child: Text("Upload"))
                                        ],
                                      ),
                                    );
                                  });
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: blackColor.withOpacity(0.3),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ReusableText(
                    title: "@${c.videoURLs[widget.i].uploaderName.capitalizeFirst}",
                    size: 15,
                    weight: FontWeight.w700,
                    color: whiteColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ReusableText(
                    title:
                    c.videoURLs[widget.i].description.capitalizeFirst,
                    size: 15,
                    weight: FontWeight.w500,
                    color: whiteColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: Provider
                        .of<UploadProgressProvider>(context)
                        .uploading,
                    child: Positioned(
                      bottom: 300,
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),

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
            ),
          ],
        );
      },
    );
  }
}
