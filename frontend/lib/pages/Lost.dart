import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/pages/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lost extends StatefulWidget {
  @override
  _LostState createState() => _LostState();
}

class _LostState extends State<Lost> {

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
    return Scaffold(appBar: CustomAppBar(),body: Container(
      color: Colors.redAccent,
      child:(loading==true)?Container():Column(children: <Widget>[
        SizedBox(height: 40,),
        Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(info['patient_dp']),
                radius: 40.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.white,
            ),
            Text(
              'Hello my name is ',
              style: TextStyle(
                color: Colors.white,
                
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              info['patient_name'],
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'and I am lost, please help me.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              'Call my relatives at:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              info['emergency_pno'],
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:40.0),
            Text(
              'And i live here:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child:Text(
              info['address'],
              style: TextStyle(
                color: Colors.black54,
                letterSpacing: 2.0,
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
              ),
            ),),
            SizedBox(height: 10,),
            RaisedButton(
            color: Colors.grey[800],
            
            padding: EdgeInsets.all(15),
            onPressed: (){},
            child: Text('Open in maps',style:TextStyle(color:Colors.white)),
          )

      ],),
       )   );
  }
}