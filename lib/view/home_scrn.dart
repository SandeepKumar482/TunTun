import 'package:flutter/material.dart';
import 'package:tuntun/constants.dart';

import 'widget/addCustomubutton.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgColour,
        onTap: (index){
          setState(() {
            pageIdx = index;
          });
        },
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25),
              label: 'Home'

          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 25),
              label: 'Search'

          ),

          BottomNavigationBarItem(
              icon: customAddIcon(),
              label: ''

          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 25),
              label: 'Notifications'

          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25),
              label: 'Profile'

          ),
        ],
      ),
      body: Center(
        child: pageindex[pageIdx],
      ),
    );
  }
}
