import 'package:get/get.dart';
import 'package:social_boster/models/feed_model.dart';
import 'package:video_player/video_player.dart';

class PCC extends GetxController {
  int _api = 0;
  List<VideoPlayerController?> videoPlayerControllers = [];
  List<int> initilizedIndexes = [];
  bool autoplay = true;
  int get api => _api;

  void updateAPI(int i) {
    if (videoPlayerControllers[_api] != null) {
      videoPlayerControllers[_api]!.pause();
    }
    _api = i;
    update();
  }

  Future initializePlayer(int i) async {
    print('initializing $i');
    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.networkUrl(Uri.parse(videoURLs[i].imageOrVideoUrl));
    videoPlayerControllers.add(singleVideoController);
    initilizedIndexes.add(i);
    await videoPlayerControllers[i]!.initialize();
    await videoPlayerControllers[i]!.setLooping(true);
    update();
  }

  Future initializeIndexedController(int index) async {
    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.networkUrl(Uri.parse(videoURLs[index].imageOrVideoUrl));
    videoPlayerControllers[index] = singleVideoController;
    await videoPlayerControllers[index]!.initialize();
    update();
  }

  Future disposeController(int i) async {
    if (videoPlayerControllers[i] != null) {
      await videoPlayerControllers[i]!.dispose();
      videoPlayerControllers[i] = null;
    }
  }


  void setVideoURLs(List<FeedModel> videos) {
    videoURLs=videos;
    update();
  }

  List<FeedModel> videoURLs = [];
}
