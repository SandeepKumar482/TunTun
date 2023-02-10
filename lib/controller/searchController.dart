import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuntun/model/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{
  final Rx<List<MyUser>> _searchUsers = Rx<List<MyUser>>([]);

  List<MyUser> get searchedUsers => _searchUsers.value;

  searchUser(String query) async{
    _searchUsers.bindStream(
        FirebaseFirestore.instance.collection("User").where("name" , isGreaterThanOrEqualTo: query).snapshots().map((QuerySnapshot queryRes){
          List<MyUser> retVal = [];
          for(var element in queryRes.docs ){
            retVal.add( MyUser(email: element['email'], uid:element['uid'], name: element['name'], image: element['ProfilePic']));
          }
          return retVal;

        })
    );
  }
}
