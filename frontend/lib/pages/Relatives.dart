import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';

class Relative extends StatefulWidget {
  @override
  _RelativeState createState() => _RelativeState();
}

class _RelativeState extends State<Relative> {
  List<Map> relatives = [];
  
  Widget relative(Map relativeName,int index){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        border: Border.all(
            color: Colors.grey,
            width: 2,
        ),
        //borderRadius: BorderRadius.circular(12),
      ),
      child:ListTile(
        title:Text(relativeName['name'],style: TextStyle(color: Colors.white),),
      )
      
    );
  }

  Widget relativeList(){
    return ListView.builder(itemBuilder: (context,idx){
      if (idx<relatives.length){
        return relative(relatives[idx],idx);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:Container(
      
      )
      
    );
  }
}