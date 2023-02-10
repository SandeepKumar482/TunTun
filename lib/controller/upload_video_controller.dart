
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../model/video.dart';
import '../view/home_scrn.dart';

class VideoUploadControlller extends GetxController{


var uuid= Uuid();
  uploadVideo(String videoPath, String song, String caption) async{
  try{
 String uid=FirebaseAuth.instance.currentUser!.uid;

 DocumentSnapshot documentSnapshot=await FirebaseFirestore.instance.collection("User").doc(uid).get();
 String id= uuid.v1();


 String videolink=await _uploadVideoToStorage(videoPath,id) ;
 String thumbLink=await _uploadThumbToStorage(id, videoPath) ;

 Video video = Video(
     uid: uid,
     username: (documentSnapshot.data()! as Map<String , dynamic>)['name'],
     videoUrl: videolink,
     thumbnail: thumbLink,
     songName: song,
     shareCount: 0,
     commentsCount: 0,
     likes: [],
     profilePic: (documentSnapshot.data()! as Map<String , dynamic>)['ProfilePic'],
     caption: caption,
     id: id
 );
 await FirebaseFirestore.instance.collection("videos").doc(id).set(video.toJson());
 Get.snackbar("Video Uploaded Successfully", "Thank You Sharing Your Content");
 Get.to(HomeScreen());
  }catch(e){
    print("==========$e");
    Get.snackbar('Error Uploading Video', e.toString());}

  }

  Future<String> _uploadVideoToStorage(String videoPath, String id) async {
    Reference reference=FirebaseStorage.instance.ref().child('videos').child(id);
    UploadTask uploadTask=reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot= await uploadTask;
    String dwnlink=await snapshot.ref.getDownloadURL();
    return dwnlink;

  }

  _compressVideo(String videoPath) async {
    final compressVideo=await VideoCompress.compressVideo(videoPath,quality: VideoQuality.MediumQuality);
    return compressVideo?.file;

  }

  Future<String> _uploadThumbToStorage(String id, String videoPath) async {
    Reference reference=FirebaseStorage.instance.ref().child('thumb').child(id);
    UploadTask uploadTask=reference.putFile(await _getthumb(videoPath));
    TaskSnapshot snapshot=await uploadTask;
    String dwnlink=await snapshot.ref.getDownloadURL();
    return dwnlink;
  }

  Future<File>_getthumb(String videoPath) async {
    final thumbnail= await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
}
