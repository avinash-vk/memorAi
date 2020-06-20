import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';

class IdCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("https://images.unsplash.com/photo-1506794778202-cad84cf45f1d"),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.redAccent,
            ),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Prats',
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Ninja Level',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Crystal',
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text(
                  'prats@ninja.com',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text('qr code comes here if needed'),
          ],
        ),
      ),
    );
  }
}