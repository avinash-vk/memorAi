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
      body:SingleChildScrollView(
         child:Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 40, 40),
          child: Column(children: <Widget>[
            Text(
              'Hello fellow person\n',
              style: TextStyle(
                color: Colors.grey[800],
                letterSpacing: 2.0,
                fontSize: 24
              ),
            ),
            Text(
              'be safe, be aware, and memoraize. I know times are hard, feel free to chat with me, i promise to help you out in any situation.\n',
              style: TextStyle(
                color: Colors.grey[800],
                letterSpacing: 2.0,
                fontSize: 16
              ),
            ),
            Divider(
              height: 40,
              color: Colors.grey,
            ),
           

            Text(
              'I\'m lost',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
                fontSize: 24
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(onPressed: (){
             Navigator.pushNamed(context, 'lost');
            },
          
              color: Colors.redAccent,
              child : Text(
                'Help me',
                style:TextStyle(color:Colors.white)
              ),
            ),
            SizedBox(height: 100,),
            Image(image: AssetImage('images/spaceman.png'),height:250,width:250),
            SizedBox(height: 60,),
            Row(children: <Widget>[
            SizedBox(width: 175,),
            Text('chat with me >',
              style:TextStyle(
                fontSize: 20,
                color: Colors.grey,
              )
            ),
            ],),
        ],),
      ),),
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