import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/components/AddMedicine.dart';
import 'package:frontend/components/notifications.dart';
import 'package:frontend/pages/userInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MedicineItem{
  String name;
  int hour;
  int min;
  String dose;

   
  MedicineItem({
    this.name,
    this.hour,
    this.min,
    this.dose
 });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hour'] = this.hour;
    data['min'] = this.min;
    data['dose'] = this.dose;
    return data;
  }
 factory MedicineItem.fromJson(Map<String,dynamic> parsedJson){
  return MedicineItem(
    name:parsedJson['name'],
    hour:parsedJson['hour'],
    min:parsedJson['min'],
    dose:parsedJson['dose'],
  );
}
}

class Medicine extends StatefulWidget {
  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  List<MedicineItem> medicines = [];
  bool isLoading = true;
  
  final NotificationManager notificationManager = NotificationManager();

  Future<void> addMedicine (Map medicine) async{
    var ma = MedicineItem(dose: medicine['dose'],hour:medicine['hour'],min:medicine['min'],name:medicine['name']);
    medicines.add(ma);
    int id = medicines.length;
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pno = prefs.getString('auth_no');
    
    bool success = await setMedicinesDb(pno, medicines);
    Fluttertoast.showToast(
          msg: (success)?"The Medicine was added!":"Oops error occured",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 20.0);
    setState(() {
      medicines = medicines;
    });
    notificationManager.showNotificationDaily(id, medicine['name'], medicine['dose'], medicine['hour'], medicine['minute']);
  }
  void buildBottomSheet(double deviceHeight) async {
    var medicineId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return AddMedicine(deviceHeight,addMedicine);
          
        });  
  }

  Widget medicine(MedicineItem medicineName,int index){
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
        title:Text('hello'+medicineName.name,style: TextStyle(color: Colors.white),),
      )
      
    );
  }

  Widget medicineList(){
      
      return ListView.builder(itemBuilder: (context,idx){
      if (idx<medicines.length){
        return medicine(medicines[idx],idx);
      }
    });
    
    
  }

  Future<List<MedicineItem>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var pno = prefs.getString('auth_no');
    Map js = await userInfo(pno);
    //print(js);
    var medicines = js['medicines'];
    List<MedicineItem> temp = (medicines ==null)?[]:(medicines as List).map((med) => MedicineItem.fromJson(med)).toList();
    return temp;
    
  }

  @override
  void initState(){
    
    
    super.initState();
    getData().then((medicinex){
      setState(() {
        medicines = medicinex;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body:(isLoading)?Text('loading...'):medicineList(),
      floatingActionButton: FloatingActionButton(
            backgroundColor:Colors.red,
            onPressed: () {
              print(medicines);
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