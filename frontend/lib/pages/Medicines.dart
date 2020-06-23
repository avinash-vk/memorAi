import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:frontend/components/AddMedicine.dart';
import 'package:frontend/components/notifications.dart';


class Medicine extends StatefulWidget {
  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  List<Map> medicines = [{'name':'paracetamol'},{'name':'paracetamol3'}];
  final NotificationManager notificationManager = NotificationManager();

  Future<void> addMedicine (Map medicine) async{
    await medicines.add(medicine);
    int id = medicines.length;
    setState(() {
      medicines = medicines;
    });
    notificationManager.showNotificationDaily(id, medicine['name'], medicine['dose'], medicine['hour'], medicine['minute']);
    Fluttertoast.showToast(
          msg: "The Medicine was added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 20.0);
  
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

  Widget medicine(Map medicineName,int index){
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
        title:Text(medicineName['name'],style: TextStyle(color: Colors.white),),
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
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body:medicineList(),
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