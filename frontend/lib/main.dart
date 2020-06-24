import 'package:flutter/material.dart';
import 'package:frontend/pages/Dashboard.dart';
import 'package:frontend/pages/Medicines.dart';
import 'package:frontend/pages/Relatives.dart';
import 'package:frontend/pages/registration/ImageReg.dart';
import 'package:frontend/pages/Login.dart';
import 'package:frontend/pages/Home.dart';
import 'package:frontend/pages/Chat.dart';
import 'package:frontend/pages/registration/Signup.dart';
import 'package:frontend/pages/registration/locationReg.dart';
import 'package:frontend/pages/MemoryGame.dart';

void main(){ 
  runApp(
  MaterialApp(
    theme: ThemeData(
    // Define the default brightness and colors.
    primaryColor: Colors.redAccent,
    accentColor: Colors.redAccent,),
    initialRoute: 'loginScreen',
    routes: {
      'loginScreen': (context) => Login(),
      'home' :(context) => Home(),
      'chat' :(context) => ChatScreen(),
      'BasicInfoReg':(context) => SignUp(),
      'ImageReg':(context) => ImageReg(),
      'LocationReg':(context) => LocationReg(),
      'dashboard':(context) => Dashboard(),
      'medicine':(context) => Medicine(),
      'relative':(context) => Relative(),
      'memory':(context) => Memory(),
    }
  )
);

}
