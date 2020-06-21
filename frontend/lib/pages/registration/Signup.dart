import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:Container(
         child:Form(
         autovalidate: true,
         child: ListView(
           padding: EdgeInsets.all(30),
           children: <Widget>[
              TextFormField(
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.redAccent),
                      icon: const Icon(Icons.person,color: Colors.redAccent),
                      hintText: 'Enter patients name',
                      labelText: 'Name',
                    ),
                  ),
              TextFormField(
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.redAccent),
                      icon: const Icon(Icons.calendar_today,color: Colors.redAccent,),
                      hintText: 'Enter patient dob',
                      labelText: 'Dob',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
              TextFormField(
                    decoration: const InputDecoration(
                       
                      labelStyle: TextStyle(color: Colors.redAccent),
                      icon: const Icon(Icons.phone,color: Colors.redAccent),
                      hintText: 'Enter a patients emergency contact number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
              
              Container(
                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  child:Column(
                    children:<Widget>[
                    RaisedButton(
                      child: const Text('Next'),
                      color:Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.pushNamed(context, 'ImageReg');
                      },
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      onPressed: (){
                        Navigator.popAndPushNamed(context,'loginScreen');
                      },
                      child:Text('I\'m not new',style:TextStyle(color:Colors.black))
                    ),
                ]
              )
            ),   
          ],
         ),
        )
      )
    );
  }
}