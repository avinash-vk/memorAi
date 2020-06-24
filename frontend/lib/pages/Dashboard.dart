import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';

class Dashboard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(child: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1506794778202-cad84cf45f1d"),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.redAccent,
            ),
            Text(
              'Hello i am',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Drake',
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'and i have a memory score of',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '716',
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'I live here',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '12th baker street oxford.',
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'My emergency contact:',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '+91 394928239',
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            
           SizedBox(height: 50,),
           Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'medicine');
                },
                child: Text('MEDICINES',style:TextStyle(color: Colors.white),),
                color: Colors.redAccent,
              ),
              SizedBox(width: 30,),
              RaisedButton(color: Colors.redAccent,
                onPressed:(){
                  Navigator.pushNamed(context, 'relative');
                },
                child:Text('RELATIVES',style:TextStyle(color: Colors.white),),
              )
            ],
           ),
            SizedBox(height: 50,),
          ],
        ),
      ),
      ),
    );
  }
}