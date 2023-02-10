import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tuntun/constants.dart';
import 'package:tuntun/view/auth_screen/login_screen.dart';
import 'package:tuntun/view/auth_screen/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TunTun',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColour
      ),
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}
