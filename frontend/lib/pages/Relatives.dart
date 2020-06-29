import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/components/AddRelative.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/pages/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RelativeItem{
  String name;
  String patient_dp;
  String relation;

  RelativeItem({
    this.name,
    this.patient_dp,
    this.relation,
 });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['patient_dp'] = this.patient_dp;
    data['relation'] = this.relation;
    return data;
  }
 factory RelativeItem.fromJson(Map<String,dynamic> parsedJson){
  return RelativeItem(
    name:parsedJson['name'],
    patient_dp:parsedJson['patient_dp'],
    relation:parsedJson['relation'],
  );
}
}

Future<bool> addRelativeAzure(phoneNumber,relative) async{
    String url = "https://memorai.herokuapp.com/api/add_relative/"+phoneNumber;
    Map<String,String> headers = {"Content-type" : "application/json"};
    Map js = {"data":relative.toJson()}; //ADD OTHER INFO
    var body = jsonEncode(js);
    try{
          var response = await http.post(url,headers:headers,body: body);
          
          int code = response.statusCode;
          print(code);
          if (code<300){
              print('success');
              return true;
          }
          else
            print('error');
            return false;
    }
    catch(Exception){
        print('error');
        return false;
    }
}

class Relative extends StatefulWidget {
  @override
  _RelativeState createState() => _RelativeState();
}

class _RelativeState extends State<Relative> {
  List<RelativeItem> relatives = [];
  bool isLoading = true;
  Widget relative(RelativeItem relativeName,int index){
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
                backgroundImage: (relativeName.patient_dp == null)? NetworkImage("https://images.unsplash.com/photo-1506794778202-cad84cf45f1d"):NetworkImage(relativeName.patient_dp),
                radius: 40.0,
              ),
            SizedBox(width: 50,),
            Text(relativeName.name,style: TextStyle(color: Colors.white),),
            Text(relativeName.relation,style: TextStyle(color: Colors.white),),
      
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
    var ma = RelativeItem(relation: relative['relation'],patient_dp:relative['patient_dp'],name:relative['name']);
    relatives.add(ma);
    int id = relatives.length;
    setState(() {
      relatives = relatives;
    });
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pno = prefs.getString('auth_no');
    bool success = await setRelativesDb(pno,relatives) && await addRelativeAzure(pno,ma);
    Fluttertoast.showToast(
          msg: (success)?"The relative was added!":"Oops error occured",
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

   Future<List<RelativeItem>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pno = prefs.getString('auth_no');
    Map js = await userInfo(pno);
    //print(js);
    var relativesx = js['relatives'];
    List<RelativeItem> temp = (relativesx ==null)?[]:(relativesx as List).map((med) => RelativeItem.fromJson(med)).toList();
    return temp;
    
  }

  @override
  void initState(){

    super.initState();
    getData().then((medicinex){
      setState(() {
        relatives = medicinex;
        isLoading = false;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body:(isLoading)?Text('Loading..'):relativeList(),
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