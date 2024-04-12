import 'dart:developer';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key? key}) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}
enum Source{Asset,Network}
class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _customVideoPlayerController;
  String assetsPath = "assets/videos/Shri_Krishna_status.mp4";
  Source currentSource = Source.Asset;

  bool isLoading = false;
  
  Uri videoUrl = Uri.parse("https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideoPlayer(currentSource);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading? Center(child: CircularProgressIndicator(),):Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController,
          ),
          sourceButtons(),
        ],
      ),
    );
  }
  Widget sourceButtons(){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(onPressed: (){
              currentSource = Source.Asset;
              initializeVideoPlayer(currentSource);
            }, child: Text("Assset"),
            color: Colors.blueAccent,
            textColor: Colors.white,),
            MaterialButton(onPressed: (){
              currentSource = Source.Network;
              initializeVideoPlayer(currentSource);
            }, child: Text("Network"),
              color: Colors.blueAccent,
              textColor: Colors.white,),
            
          ],
        );
  }
  void initializeVideoPlayer(Source src){
    setState(() {
      isLoading = true;
    });
    VideoPlayerController _videoPlayerController;
    if(src == Source.Asset){

      _videoPlayerController = VideoPlayerController.asset(assetsPath)..initialize()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }else if(src==Source.Network){
      _videoPlayerController = VideoPlayerController.networkUrl(videoUrl)..initialize()
      .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
    else{
      return;
    }

    _customVideoPlayerController = CustomVideoPlayerController(context: context, videoPlayerController: _videoPlayerController);
  }
}
