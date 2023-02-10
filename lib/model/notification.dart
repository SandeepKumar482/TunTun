import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications{

  String username;
  String msg;
  final datePub;
  String profilePic;
  String uid;
  String id;


  Notifications({
    required this.username,
    required this.msg,
    required this.datePub,
    required this.profilePic,
    required this.uid,
    required this.id

  });


  Map<String, dynamic> toJson()=>{
    'username' : username,
    'msg' : msg,
    'datePub' : datePub,
    'profilePic' : profilePic,
    'uid' : uid,
    'id':id

  };

  static Notifications fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Notifications(
      username : snapshot['username'],
      msg : snapshot['msg'],
      datePub : snapshot['datePub'],
      profilePic : snapshot['profilePic'],
      uid : snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
