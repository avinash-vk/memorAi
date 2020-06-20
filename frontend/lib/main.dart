import 'package:flutter/material.dart';
import 'package:frontend/pages/ImageReg.dart';
import 'package:frontend/pages/Login.dart';
import 'package:frontend/pages/Home.dart';
import 'package:frontend/pages/Chat.dart';
import 'package:frontend/pages/Signup.dart';
import 'package:frontend/pages/locationReg.dart';
void main(){ 
  runApp(
  MaterialApp(
    initialRoute: 'ImageReg',
    routes: {
      'loginScreen': (context) => Login(),
      'home' :(context) => Home(),
      'chat' :(context) => ChatScreen(),
      'BasicInfoReg':(context) => SignUp(),
      'ImageReg':(context) => ImageReg(),
      'LocationReg':(context) => LocationReg()
    }
  )
);

}