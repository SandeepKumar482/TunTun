
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser{
  String? name;
  String? email;
  String? uid;
  String? image;

  MyUser({
    required this.email,
    required this.uid,
    required this.name,
    required this.image
});
  Map<String, dynamic> toJson()=>{
    "name": name,
    "email":email,
    "uid": uid,
    "ProfilePic": image
  };

  static MyUser fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<dynamic,String>;
    return MyUser(
        email: snapshot['email'],
        uid: snapshot['uid'],
        name: snapshot['name'],
        image: snapshot['ProfilePic']
    );
  }

}
