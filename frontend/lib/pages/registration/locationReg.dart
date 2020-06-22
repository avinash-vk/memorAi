import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/components/Location.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationReg extends StatefulWidget {
  @override
  _LocationRegState createState() => _LocationRegState();
}

class _LocationRegState extends State<LocationReg> {
  //state
  LocationData location;
  var loading = false;
  var helperText = '';

  Future<void> setLocation() async {
    LocationData loc = await getLocation();
    setState(() {
      location = loc;
    });
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('location', location.toString());
  */}

  Future<void> onPress() async{
    setState(() {
      loading=true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    var pno = prefs.getString('emergency_contact');
    var imageUrl = prefs.getString('image_url');
    var loc = location;

    String url = "https://memorai.herokuapp.com/api/createUser";
    Map<String,String> headers = {"Content-type" : "application/json"};
    Map js = {"emergency_pno":pno,"patient_name":name,"patient_location":{'loc':loc.latitude,'lat':loc.longitude},'patient_dp':imageUrl}; //ADD OTHER INFO
    var body = json.encode(js);

    try{
          var response = await http.post(url,headers:headers,body: body);
          
          int code = response.statusCode;
          print(code);
          if (code<300){
            setState(() {
              helperText = "SUCCESS";
            });
            Navigator.popAndPushNamed(context, 'home');  
          }
          else
            setState(() {
              helperText = "Some error occured";
            });
    }
    catch(Exception){
        helperText  = "NO INTERNET";
    }
    setState(() {
            loading=false;
            helperText = helperText;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Scaffold(appBar: CustomAppBar(),
        body:Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('LOADING...')
        ],
        )
      );
    }
    else{
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
          child: Icon(Icons.location_on,color:Colors.white),
        ),
        Text(helperText),
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed:onPress,
        child: Icon(Icons.check,color:Colors.white),
      ),
    );
  }}
}