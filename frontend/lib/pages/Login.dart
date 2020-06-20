import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber = "";
  String password = "";
  String text = "Logged out";
  bool isLoading = false;
  final pnoController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(),
      body:Padding(
        padding: EdgeInsets.all(40),
        child: Column(children: <Widget>[
        SizedBox(height:42),
        
        TextField(
          controller: pnoController,
          decoration: InputDecoration(
               border: InputBorder.none,
               hintText: 'Phone number',
          ),
        ),
        TextField(
          controller: passController,
          decoration: InputDecoration(
               border: InputBorder.none,
               hintText: 'Password',
          ),
        ),
       SizedBox(height:30),
        RaisedButton(onPressed:()
        {
            Navigator.pushNamed(context, 'home');
        },
          color:Colors.redAccent,
          child:Text(
            'LOGIN',
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          )
        ),
        SizedBox(height:14),
        Container(
          child: isLoading == true ? Text('Loading..') : Text('Nope')
        ),
        SizedBox(height: 20,),
        Text(
          text,
          style:TextStyle(
            fontSize: 20,
          )
        ),
        SizedBox(height: 10,),
        RaisedButton(
          onPressed: (){
            Navigator.pushNamed(context,'BasicInfoReg');
          },
          child:Text('I\'m new',style:TextStyle(backgroundColor: Colors.yellow,color:Colors.black))
        )
      ],
      )
      )
    );
  }
}