import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  final nameController = TextEditingController();
  final pnoController = TextEditingController();
  var pno,name;
  var helperText = '';

  Future<void> onSubmit() async{
    setState(() {
      pno = pnoController.text;
      name = nameController.text;
    });
    if (pno == '' || name ==''){
      setState(() {
        helperText = 'Name/ Phone not filled!';
      });
      return null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('data', true);
    prefs.setString('name', name);
    prefs.setString('emergency_contact', pno);
    
    Navigator.pushNamed(context, 'ImageReg');
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(),
      body:Container(
        padding:EdgeInsets.all(30), 
         child:Form(
         autovalidate: true,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          
           children: <Widget>[
              Text('Let\'s start',
              style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.grey[800],
              fontSize: 20,
            ),
          ),
        SizedBox(height: 20,),
              TextFormField(
                controller: nameController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.redAccent),
                      icon: const Icon(Icons.person,color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Enter patients name',
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height:20),
              /*TextFormField(
                    decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.redAccent),
                      icon: const Icon(Icons.calendar_today,color: Colors.redAccent,),
                      hintText: 'Enter patient dob',
                      labelText: 'Dob',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height:20),*/
              TextFormField(
                controller: pnoController,
                    decoration: const InputDecoration(
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      labelStyle: TextStyle(color: Colors.redAccent),
                      icon: const Icon(Icons.phone,color: Colors.redAccent),
                      hintText: 'Enter a patients emergency contact number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
              SizedBox(height:20),
              Container(
                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                    RaisedButton(
                      child: const Text('Next'),
                      color:Colors.redAccent,
                      textColor: Colors.white,
                      onPressed: onSubmit,
                    ),
                    SizedBox(width: 20,),
                    RaisedButton(
                      color: Colors.yellow[600],
                      onPressed: (){
                        Navigator.popAndPushNamed(context,'loginScreen');
                      },
                      child:Text('I\'m not new',style:TextStyle(color:Colors.white))
                    ),
                ]
              )
            ), 
            SizedBox(height:10),
            Text(helperText),
          ],
         ),
        )
      )
      );
    
  }
}