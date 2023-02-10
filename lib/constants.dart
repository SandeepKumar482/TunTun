import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuntun/view/addVideoScreen.dart';
import 'package:tuntun/view/notificationScreen.dart';
import 'package:tuntun/view/searchScreen.dart';

import 'view/Profile _scrn.dart';
import 'view/addVideoScreen.dart';
import 'view/video_display_scrn.dart';

getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];

const bgColour=Colors.black;
var button=Colors.red[400];
const borderColor=Colors.grey;

var uid=FirebaseAuth.instance.currentUser!.uid;

var pageindex = [
  DisplayVideo_Screen(),
  SearchScreen(),
  addVideoScreen(),
  NotificationScreen(),
  ProfileScreen(uid: uid),
];
