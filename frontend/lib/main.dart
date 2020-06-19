import 'package:flutter/material.dart';
import 'package:frontend/pages/Login.dart';
import 'package:frontend/pages/Home.dart';
import 'package:frontend/pages/Chat.dart';

void main(){ 
  runApp(
  MaterialApp(
    initialRoute: 'loginScreen',
    routes: {
      'loginScreen': (context) => Login(),
      'home' :(context) => Home(),
      'chat' :(context) => ChatScreen(),
    }
  )
);

}