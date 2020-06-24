import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/components/AddRelative.dart';
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
        title:Container(
          child:Row(children: <Widget>[
            
            CircleAvatar(
                backgroundImage: (relativeName['url'] == null)? NetworkImage("https://images.unsplash.com/photo-1506794778202-cad84cf45f1d"):NetworkImage(relativeName['url']),
                radius: 40.0,
              ),
            SizedBox(width: 50,),
            Text(relativeName['name'],style: TextStyle(color: Colors.white),),

      
          ],)
          
      ))
      
    );
  }

  Widget relativeList(){
    
    return ListView.builder(itemBuilder: (context,idx)
    {

      if (idx<relatives.length){
        print(relatives[idx]);
        return relative(relatives[idx],idx);
      }
    });
  }


  Future<void> addRelative (Map relative) async{
    relatives.add(relative);
    int id = relatives.length;
    setState(() {
      relatives = relatives;
    });
    
    Fluttertoast.showToast(
          msg: "The Relative was added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 20.0);
  
  }


  void buildBottomSheet(double deviceHeight) async {
    var relativeId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return AddRelative(deviceHeight,addRelative);
          
        });

    
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body:relativeList(),
      floatingActionButton: FloatingActionButton(
            backgroundColor:Colors.red,
            onPressed: () {
              buildBottomSheet(deviceHeight);
            },
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            
          ),
    );
  }
}