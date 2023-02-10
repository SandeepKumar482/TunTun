import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuntun/controller/upload_video_controller.dart';
import 'package:tuntun/view/addVideoScreen.dart';
import 'package:tuntun/view/widget/text_input.dart';
import 'package:video_player/video_player.dart';
import '../constants.dart';


class AddCaption extends StatefulWidget {

  File videoFile;
  String videoPath;

   AddCaption({Key? key, required this.videoFile,required this.videoPath }) : super(key: key);





  @override
  State<AddCaption> createState() => _AddCaptionState();
}

class _AddCaptionState extends State<AddCaption> {

  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = new TextEditingController();
  TextEditingController captionController = new TextEditingController();

  final videoController=Get.put(VideoUploadControlller());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState((){
      videoPlayerController=VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.9);

  }

  Widget UploadContent = Text("Upload");

  uploadVid(){
    UploadContent = Text("Please Wait..");
    setState(() {

    });
  }

  @override
  void dispose() {

    super.dispose();
    videoPlayerController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputField(controller: songNameController,
                      myIcon: Icons.music_note,
                      myLabelText: "Song Name"),
                  SizedBox(height: 20,),
                  TextInputField(controller: captionController,
                      myIcon: Icons.closed_caption,
                      myLabelText: "Caption"),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    uploadVid();
                      videoController.uploadVideo(widget.videoPath, songNameController.text, captionController.text);
                      //
                      // Get.back();
                      // Get.snackbar("Video Uploaded Successfully", "Thank You Sharing Your Content");

                  }, child: UploadContent , style: ElevatedButton.styleFrom(primary: button),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
