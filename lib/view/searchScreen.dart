import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/searchController.dart';
import '../model/user.dart';
import 'Profile _scrn.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchQuery = TextEditingController();

  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(

          title: TextFormField(
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Search Username"
            )
            ,controller: searchQuery , onChanged: (value){
            searchController.searchUser(value);
          },),
          backgroundColor: Colors.black,

        ),
        body:  searchController.searchedUsers.isEmpty ?   Center(
          child: Text("Search Users!"),
        ) :
        ListView.builder(
            itemCount: searchController.searchedUsers.length,
            itemBuilder: (context, index){
              MyUser user = searchController.searchedUsers[index];

              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid.toString() )));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(

                      user.image.toString()

                  ),
                ),

                title: Text(user.name.toString()),

              );
            })
        ,
      );
    }
    );
  }
}
