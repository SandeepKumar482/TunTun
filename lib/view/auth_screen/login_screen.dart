import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../widget/glitch.dart';
import '../widget/text_input.dart';
import 'signup.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final controller = Get.put(Auth_Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,

        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(child: const Text("TunTun" ,style: TextStyle(fontWeight: FontWeight.w900 , fontSize: 30),)),
            SizedBox(height: 25,),
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
                controller: _passwordController,
                myLabelText: "Password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              controller.login(_emailController.text, _passwordController.text);

            }, child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50 , vertical: 10),

                child: Text("Login"))),
            TextButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
            }, child: Text("New User ? Click Here"))

          ],
        ),

      ),
    );
  }
}
