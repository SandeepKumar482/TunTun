import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuntun/controller/notificationController.dart';
import'package:timeago/timeago.dart' as tago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final NotificationController controller=Get.put(NotificationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchNotifications();
  }
  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Obx(() {
          return ListView.builder(shrinkWrap: true,itemCount: controller.notification.length,itemBuilder: (context , index){
            final notification  = controller.notification[index];
            return ListTile(
              leading : CircleAvatar(

                backgroundImage: NetworkImage(notification.profilePic),
              ),
              title: Row(
                children: [
                  Text(notification.username, style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent
                  ),),
                  SizedBox(
                    width: 5,
                  ),
                  Text(notification.msg,  style: TextStyle(
                    fontSize: 13,

                  ),)
                ],
              ),
              subtitle: Row(
                children: [
                  Text(tago.format(notification.datePub.toDate()) , style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                  ),
                  ),

                ],
              ),
              // trailing: InkWell(
              //     onTap: (){
              //       commentController.likeComment(comment.id);
              //     },
              //     child: Icon(Icons.favorite , color : comment.likes.contains(FirebaseAuth.instance.currentUser!.uid) ? Colors.red : Colors.white)),
            );
          });
        }
      ),
    );
  }
}
