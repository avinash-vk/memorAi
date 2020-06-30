import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/pages/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map info;
  bool loading = true;
  Future<Map> start() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pno = prefs.getString('auth_no');
    Map js = await userInfo(pno);
    return js;
  }

  @override
  void initState() {
    super.initState();
    start().then((js){
      setState(() {
        info = js;
        loading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: (loading ==true) ? Container() :Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(info['patient_dp']),
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
              info['patient_name'],
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Contact no.',
              style: TextStyle(
                color: Colors.redAccent[400],
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              info['emergency_pno'],
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
                  'joe@medicallifestyle.com',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
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
    );
  }
}