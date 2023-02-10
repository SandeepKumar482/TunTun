
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../model/notification.dart';

class NotificationController extends GetxController{

  Rx<List<Notifications>> _notification=Rx<List<Notifications>>([]);
  List<Notifications> get notification => _notification.value;

  fetchNotifications() async{
     _notification.bindStream(FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection('notification').snapshots().map((QuerySnapshot query){
      List<Notifications> retVal = [];
      for (var element in query.docs){
        retVal.add(Notifications.fromSnap(element));
      }
      return retVal;
    }));
  }

  likeNotification(String vid) async{

Get.snackbar("liking", "");
try{

    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('videos').doc(vid).get();

    DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid.toString()).get();

    var notColl= await FirebaseFirestore.instance.collection('User').doc((doc.data() as dynamic)["uid"]).collection('notification').get();


      Get.snackbar("liking5", "");
      Notifications noti=Notifications(
          username: (userdoc.data() as dynamic)['name'],
          msg: "liked your video",
          datePub: DateTime.now(),
          profilePic:(userdoc.data() as dynamic)['ProfilePic'] ,
          uid: FirebaseAuth.instance.currentUser!.uid.toString(),
          id: 'notif ${notColl.docs.length}');
    Get.snackbar("liking6", "");
      await FirebaseFirestore.instance.collection('User').doc((doc.data() as dynamic)["uid"]).collection('notification').doc('notif ${notColl.docs.length +1}').set(noti.toJson());
        Get.snackbar("liked", "");

}catch(e){
  print('notification Error===================${e}');
}
}
}
