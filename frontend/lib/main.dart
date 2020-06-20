import 'package:flutter/material.dart';
import 'package:frontend/pages/Dashboard.dart';
import 'package:frontend/pages/registration/ImageReg.dart';
import 'package:frontend/pages/Login.dart';
import 'package:frontend/pages/Home.dart';
import 'package:frontend/pages/Chat.dart';
import 'package:frontend/pages/registration/Signup.dart';
import 'package:frontend/pages/registration/locationReg.dart';
void main(){ 
  runApp(
  MaterialApp(
    initialRoute: 'loginScreen',
    routes: {
      'loginScreen': (context) => Login(),
      'home' :(context) => Home(),
      'chat' :(context) => ChatScreen(),
      'BasicInfoReg':(context) => SignUp(),
      'ImageReg':(context) => ImageReg(),
      'LocationReg':(context) => LocationReg(),
      'dashboard':(context) => Dashboard()
    }
  )
);

}