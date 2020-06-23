import 'package:flutter/material.dart';

class AddMedicine extends StatefulWidget {
  final double height;
  final Function addMedicine;
  AddMedicine(this.height,this.addMedicine);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  static final _formKey = new GlobalKey<FormState>();
  String _name;
  String _dose;
  

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(25, 120, 25, 20),
        height: widget.height * .8,
        child: Column(
        
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add New Medicine',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // back to main screen
                    Navigator.pop(context, null);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color:Colors.redAccent,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            _buildForm(),
        
            
           

            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                onPressed: (){
                  _submit();
                },
                color: Colors.redAccent,
                textColor: Colors.white,
                
                child: Text(
                  'Add Medicine'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }


  Form _buildForm() {
    TextStyle labelsStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 25);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length < 5) ? 'Name is short' : null,
            onSaved: (input) => _name = input,
          ),
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Dose',
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length > 50) ? 'Dose is long' : null,
            onSaved: (input) => _dose = input,
          )
        ],
      ),
    );
  }
  void _submit() async {
    if (_formKey.currentState.validate()) {
      // form is validated
      _formKey.currentState.save();
      print(_name);
      print(_dose);
      //show the time picker dialog
      showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      ).then((selectedTime) async {
        int hour = selectedTime.hour;
        int minute = selectedTime.minute;
        print(selectedTime);
        Map med = {"name":_name,"dose":_dose,"hour":hour,"minute":minute};
        widget.addMedicine(med);
      });
    }
  }
}