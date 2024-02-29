


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../models/feed_comment_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';

class CommentBottomSheet extends StatefulWidget {
  final String postId;

  CommentBottomSheet({required this.postId});

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("feeds")
                .doc(widget.postId)
                .collection("comments").orderBy(FeedCommentModelFields.commentTime,descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("No comments"));
              }



              return snapshot.data!.docs.isEmpty?const Center(child: Text("No comments")):ListView.builder(
                reverse: true,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {

                  // Customize the way you want to display the comments
                  FeedCommentModel comment = FeedCommentModel
                      .fromJson(
                      snapshot.data!.docs[index].data() as Map<String,dynamic>);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // index+1==snapshot.data!.docs.length?
                      // SizedBox(height: Get.height*.1,):
                      // SizedBox.shrink(),
                      ListTile(
                          contentPadding: EdgeInsets
                              .zero,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              comment
                                  .commenterImageUrl,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              comment
                                  .commenterName
                                  .capitalizeFirst!,
                              style: AppTextStyles
                                  .mediumStyle,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat
                                .yMd()
                                .add_jm()
                                .format(
                                DateTime
                                    .parse(
                                    comment
                                        .commentTime)),
                            style: AppTextStyles
                                .regularStyle
                                .copyWith(
                                color: Colors
                                    .grey,
                                fontSize: 8),
                          ),
                          trailing:
                          PopupMenuButton(
                              itemBuilder: (context){
                                return [
                                  PopupMenuItem(child: Text("About")),
                                  comment.commenterUid==FirebaseAuth.instance.currentUser!.uid?
                                  PopupMenuItem(
                                      onTap: ()async{
                                        await FirebaseFirestore.instance.collection("feeds").doc(widget.postId).collection("comments").doc(comment.commentId).delete();
                                      },
                                      child: Text("Delete")):
                                  PopupMenuItem(child: Text("Report"))
                                ];
                              })
                        // Icon(Icons.more_vert_outlined),
                      ),
                      const SizedBox(
                          height: 10),
                      Text(
                          comment
                              .comment),
                      const Divider(
                        height: 10,
                        thickness: 1,),
                      index==0?
                      SizedBox(height: Get.height*.08,):
                      SizedBox.shrink()
                    ],
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 60,
              width: double
                  .infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius
                    .circular(
                    15),
                border: Border
                    .all(
                    color: Colors
                        .grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets
                            .only(
                            left: 10),
                        hintText: "Write comment here",
                        border:
                        UnderlineInputBorder(
                            borderSide: BorderSide
                                .none),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 10),

                  InkWell(
                    onTap: commentController.text.isEmpty?null:() async {
                      String commentId=DateTime.now().microsecondsSinceEpoch.toString();
                      String commentTime=DateTime.now().toString();
                      UserModel user=Provider.of<UserProvider>(context,listen: false).user!;
                      FeedCommentModel feedComment = FeedCommentModel(
                          commentId: commentId,
                          commenterImageUrl: user.userProfileImage,
                          commenterName: user.userName,
                          commenterUid: FirebaseAuth.instance.currentUser!.uid,
                          commentTime: commentTime,
                          postId: widget.postId,
                          comment: commentController.text);
                      await FirebaseFirestore
                          .instance
                          .collection(
                          "feeds")
                          .doc(
                          widget.postId)
                          .collection(
                          "comments")
                          .doc(commentId).set(feedComment.toMap());
                      commentController.clear();
                      Fluttertoast.showToast(msg: "Comment posted");
                      setState((){});
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors
                          .primaryColor,
                      child: Transform
                          .rotate(
                        angle: 2 *
                            math
                                .pi /
                            1.1,
                        child: Icon(
                          Icons
                              .send,
                          color: AppColors
                              .primaryWhite,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 10),
                ],
              ),
            ),


            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: commentController,
            //         decoration: InputDecoration(
            //           hintText: "Write a comment...",
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 8.0),
            //     ElevatedButton(
            //       onPressed: () async {
            //         // Add your logic to post a new comment to Firebase
            //         await FirebaseFirestore.instance
            //             .collection("feeds")
            //             .doc(widget.postId)
            //             .collection("comments")
            //             .add({
            //           'comment': commentController.text,
            //           'commenterName': 'User', // Set your commenterName
            //         });
            //
            //         // Clear the text field after posting a comment
            //         commentController.clear();
            //         setState(() {}); // Refresh the bottom sheet to reflect the new comment
            //       },
            //       child: Text('Post'),
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}