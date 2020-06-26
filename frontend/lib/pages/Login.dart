import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/pages/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber = "";
  String infoText = "";
  String helperText="";
  bool isLoading = false;
  final pnoController = TextEditingController();
  
  Future<void> signIn () async{
    setState(() {
      phoneNumber = pnoController.text;
      helperText="Loading";
    });
    Map js = await userInfo(phoneNumber);
    if(js == null){
      setState(() {
        helperText="inValid creds";
      });
    }
    else{
      setState(() {
        helperText="success";
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true );
      prefs.setString('auth_no', phoneNumber);
      print("Done");
      Navigator.popAndPushNamed(context, 'home');
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(),
      body:Padding(
        padding: EdgeInsets.all(40),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[
          
          Text(
            'Hello friend! I am memorAi and i will help you remember things faster.\n\nLogin to continue',
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.grey[800],
              fontSize: 20,
            ),
          ),
        SizedBox(height: 20,),
        TextField(
          controller: pnoController,
          decoration: InputDecoration(
               focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                ),
               hintText: 'Phone number',
          ),
        ),
        
      SizedBox(height:30),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        
         RaisedButton(onPressed:()
          {
            signIn();  
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
        
        
        SizedBox(width: 20,),
        RaisedButton(
          color: Colors.yellow[600],
          onPressed: (){
            Navigator.popAndPushNamed(context,'BasicInfoReg');
          },
          child:Text('I\'M NEW',style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.white,
            ),)
        )
      ],),
       SizedBox(height:14),
        Container(
          child: Text(infoText)
        ),
        Text(helperText),
      ],
      )
      )
    );
  }
}