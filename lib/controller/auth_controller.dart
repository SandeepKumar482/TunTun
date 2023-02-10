import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuntun/model/user.dart';
import 'package:tuntun/view/auth_screen/login_screen.dart';
import 'package:tuntun/view/home_scrn.dart';


class Auth_Controller extends GetxController{
static Auth_Controller instance=Get.find();

 Future<String> _uploadProPic(File image) async{
    Reference ref=FirebaseStorage.instance.ref().child("profilePics").child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask=ref.putFile(image);
    TaskSnapshot snapshot=await uploadTask;
    String imgDwnUrl=await snapshot.ref.getDownloadURL();
    return imgDwnUrl;
  }
  File? prpic;
pickImage() async{
  try {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final img= File(image!.path);
    this.prpic=img;
  }catch(e){
    print("error during image pic---------${e}");
  }
}
late Rx<User?> _user;
 User get user => _user.value!;
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user=Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);

  }

 void login(String email, String password)async {
  try{
if(email.isNotEmpty && password.isNotEmpty){
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

}else{
  Get.snackbar("Error login", "Please fill all fields");
}
  }catch(e){
    Get.snackbar("Error Occured", e.toString());
  }
 }
 _setInitialView(User? user) {
   if(user==null){
     Get.offAll(LoginScreen());

   }else{
     Get.offAll(HomeScreen());
   }
 }


  void SignUp(
      String name,
      String email,
      String password,
      File? image)async{
    try{
      if(name.isNotEmpty &&
      email.isNotEmpty &&
          password.isNotEmpty &&
          image!=null){
        UserCredential credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        String dp= await _uploadProPic(image) ;

        MyUser user=MyUser(email: email, uid: credential.user!.uid, name: name, image: dp);
        await FirebaseFirestore.instance.collection('User').doc(credential.user!.uid).set(user.toJson());

      }else{
        Get.snackbar('Error in creating user', 'please fill all blanks');
      }
    }catch(e){
      print(e);
      Get.snackbar("Error Occured", e.toString());
    }

  }

   signOut() {
     FirebaseAuth.instance.signOut();
     Get.offAll(LoginScreen());
   }


}
