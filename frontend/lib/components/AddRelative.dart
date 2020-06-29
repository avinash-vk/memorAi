import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/components/firebaseImageUpload.dart';
import 'package:image_picker/image_picker.dart';

class AddRelative extends StatefulWidget {
  final double height;
  final Function addRelative;
  AddRelative(this.height,this.addRelative);

  @override
  _AddRelativeState createState() => _AddRelativeState();
}

class _AddRelativeState extends State<AddRelative> {
  static final _formKey = new GlobalKey<FormState>();
  String _name;
  String _relation;
  File _image;
  String helperText='';
  String url='';

  final picker = ImagePicker();
  Future getImageFromCamera() async {
    final cameraFile = await picker.getImage(source: ImageSource.camera);
    
    if (cameraFile != null){
    setState(() {
      _image = File(cameraFile.path);
    });
  }}

  Future<void> imageUpload() async{
    if (_image == null){
      setState(() {
        helperText = 'No image found!';
      });
      return null;
    }
    setState(() {
      helperText = 'Uploading';
    });
    String urlx = await firebaseUpload(_image);
    print(urlx);
    setState(() {
      url = urlx;
    });
    setState(() {
      helperText = 'Uploaded';
    });
  }

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
                  'Add Relative',
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
        
            SizedBox(height: 20,),
           Center(
          child:Container(
          height:100,
          width:100,
          decoration:BoxDecoration(borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: _image == null
            ? Center(child:Text('No image selected.'))
            : Image.file(_image),
          ),  
          
        ),SizedBox(height: 20,),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        RaisedButton(onPressed: getImageFromCamera,
        color: Colors.redAccent,
                textColor: Colors.white,
        child: Icon(Icons.camera_alt),      
          
        ),
        SizedBox(width: 20,),
        RaisedButton(onPressed: imageUpload,
        color: Colors.redAccent,
                textColor: Colors.white,
        child: Icon(Icons.file_upload),  
        ),
        ]),

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
                  'Add Relative'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(helperText)
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
              labelText: 'relation',
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length > 50) ? 'Input is long' : null,
            onSaved: (input) => _relation = input,
          ),

          
        ],
      ),
    );
  }
  void _submit() async {
    if (_formKey.currentState.validate()) {
      // form is validated
      _formKey.currentState.save();
      print(_name);
      print(_relation);
      //show the time picker dialog
      print(url);
      Map relative = {"name":_name,"relation":_relation,"patient_dp":url};
      setState(() {
        helperText = 'Loading';
      });
      widget.addRelative(relative);
      setState(() {
        helperText = '';
      });
    }
  }
}