import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:social_boster/models/feed_model.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/trending_screens/video_player.dart';

import '../../../controller/controller.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  initState(){
    getVideos();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  final c = Get.put(PCC());
  bool loading=true;
  getVideos()async{
    QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("videos").get();
    List<FeedModel> videos=[];
    for(int i=0;i<snapshot.docs.length;i++){
      print(snapshot.docs[i].data());
      FeedModel video=FeedModel.fromJson(snapshot.docs[i].data() as Map<String,dynamic>);
      videos.add(video);
    }
    print(videos.first.imageOrVideoUrl);
    c.setVideoURLs(videos);
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        child: loading?CircularProgressIndicator():PreloadPageView.builder(
          itemBuilder: (ctx, i) {
            return Player(i: i,);
    },
      onPageChanged: (i) async {
        c.updateAPI(i);
      },
      //If you are increasing or descrising preaload page count change accordingly in the player widget
      preloadPagesCount: 1,
      controller: PreloadPageController(initialPage: 0),
      itemCount: c.videoURLs.length,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
    )
      ),
    );
  }
}
