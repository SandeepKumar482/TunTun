import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TunTunVideoPlayer extends StatefulWidget {
  TunTunVideoPlayer({Key? key , required this.videoUrl}) : super(key: key);
  String videoUrl;

  @override
  State<TunTunVideoPlayer> createState() => _TunTunVideoPlayerState();
}

class _TunTunVideoPlayerState extends State<TunTunVideoPlayer> {

  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    });

  }


  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(videoPlayerController),
    );


  }
}
