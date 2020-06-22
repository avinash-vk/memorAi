import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/components/Location.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationReg extends StatefulWidget {
  @override
  _LocationRegState createState() => _LocationRegState();
}

class _LocationRegState extends State<LocationReg> {
  //state
  LocationData location;

  Future<void> setLocation() async {
    LocationData loc = await getLocation();
    setState(() {
      location = loc;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(child: Column(
        children: <Widget>[
          Center(
          child:Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child : Text(
              'Let\'s get user location!',
               style: TextStyle(
                 color: Colors.grey[600],
                 letterSpacing: 1.5,
                 fontSize: 20,
               )
          ) 
          )
        ),
        SizedBox(height: 20,),
        Center(
          child:Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child : Text(
              (location==null)?'Let\'s get user location!':location.toString(),
               style: TextStyle(
                 color: Colors.grey[600],
                 letterSpacing: 1.5,
                 fontSize: 20,
               )
          ) 
          )
        ),
        SizedBox(width: 5,),
        RaisedButton(onPressed: setLocation,
          color: Colors.redAccent,
          child: Icon(Icons.photo_camera,color:Colors.white),
        ),
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){Navigator.pushNamed(context, 'home');},
        child: Icon(Icons.navigate_next,color:Colors.white),
      ),
    );
  }
}