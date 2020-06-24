import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  //const Login({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:  CustomAppBar(),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text(
                'MemorAi',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              )
            ),
            ListTile(leading: Icon(Icons.account_circle),
                title:Text('Dashboard'),
                onTap: () {
                  Navigator.pushNamed(context, 'dashboard');
                  
                },
            
            ),
            ListTile(leading: Icon(Icons.videogame_asset),
              title: Text('Memory Game'),
              onTap: () {
                Navigator.pushNamed(context, 'memory');
              },
            ),
             ListTile(leading: Icon(Icons.notifications),
                title:Text('SOS'),
                onTap: () {
                },
            ),
             ListTile(leading: Icon(Icons.close),
                title:Text('Log out'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance(); 
                  prefs.setBool('auth', false);
                  Navigator.popAndPushNamed(context, 'loginScreen');
                },
            ),

          ]
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 40, 40),
          child: Column(children: <Widget>[
            Text(
              'Hello fellow person, be safe, be aware, and memorize.',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            Divider(
              height: 86,
              color: Colors.grey,
            ),
            Text(
              'Test:',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
              Navigator.pushNamed(context, 'memory');
            },
              color: Colors.redAccent,
              child : Text(
                'Memorize',
                style:TextStyle(color:Colors.white)
              ),
            ), 

            Divider(
              height: 85,
              color: Colors.grey,
            ),

            Text(
              'Who\'s this?',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
            },
              color: Colors.redAccent,
              child : Text(
                'open cam',
                style:TextStyle(color:Colors.white)
              ),
            ), 

            Divider(
              height: 85,
              color: Colors.grey,
            ),

            Text(
              'I\'m lost',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
             
            },
              color: Colors.redAccent,
              child : Text(
                'HeLp me lol',
                style:TextStyle(color:Colors.white)
              ),
            ),

          ],)  
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: (){
          Navigator.pushNamed(context, 'chat');
        },
        child:Icon(Icons.message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}