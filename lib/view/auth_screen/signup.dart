import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuntun/controller/auth_controller.dart';

import '../widget/glitch.dart';
import '../widget/text_input.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _setPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  final controller = Get.put(Auth_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,

          margin: EdgeInsets.only(top: 100),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(child: const Text("Welcome To TunTun" ,style: TextStyle(fontWeight: FontWeight.w900 , fontSize: 30),)),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  controller.pickImage();
                },
                child: Stack(children: [
                  CircleAvatar(backgroundImage: NetworkImage("http://i.imgur.com/HQ3YU7n.gif"),radius: 50,),
                  Positioned(bottom: 0,right:4,child: Icon(Icons.edit))
                ],),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  myLabelText: "Email",
                  myIcon: Icons.email,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _setPasswordController,
                  myLabelText: "Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _confirmPasswordController,
                  myLabelText: "Confirm Password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _usernameController,
                  myLabelText: "Username",
                  myIcon: Icons.person,
                  toHide: false,
                ),
              ),

              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){

                controller.SignUp(_usernameController.text, _emailController.text, _setPasswordController.text, controller.prpic);

              },
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 10),

                  child: Text("Sign Up")))
            ],
          ),

        ),
      ),
    );
  }
}
