import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/components/firebaseImageUpload.dart';

class ImageReg extends StatefulWidget {
  @override
  _ImageRegState createState() => _ImageRegState();
}

class _ImageRegState extends State<ImageReg> {
  //state
  File _image;
  String url = '';
  String helperText = '';

  /// Starts an upload task
  Future<void> onSubmit() async{
    if (_image == null){
      setState(() {
        helperText = 'No image found!';
      });
      return null;
    }
    setState(() {
      helperText = 'Uploading';
    });
    String url = await firebaseUpload(_image);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image_url', url);
    setState(() {
      helperText = 'Uploaded';
    });
  }

  final picker = ImagePicker();
  Future getImageFromCamera() async {
    final cameraFile = await picker.getImage(source: ImageSource.camera);
    
    if (cameraFile != null){
    setState(() {
      _image = File(cameraFile.path);
    });
  }}
  Future getImageFromGallery() async{
    final galleryFile = await picker.getImage(source:ImageSource.gallery);
    if (galleryFile != null){
    setState(() {
      _image = File(galleryFile.path);
    });}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(children: <Widget>[
        Center(
          child:Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child : Text(
              'Let\'s proceed to click a nice picture of the patient.\nMake sure the background is well lit :D',
               style: TextStyle(
                 color: Colors.grey[600],
                 letterSpacing: 1.5,
                 fontSize: 20,
               )
          ) 
          )
        ),
        Center(
          child:Container(
          color:Colors.grey[200],
          height:350,
          width:250,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: _image == null
            ? Center(child:Text('No image selected.'))
            : Image.file(_image),
          ),  
          
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
          onPressed: getImageFromGallery,
          color: Colors.redAccent,
          child: Icon(Icons.photo_size_select_actual,color:Colors.white),
        ),
        SizedBox(width: 20,),
        RaisedButton(onPressed: getImageFromCamera,
          color: Colors.redAccent,
          child: Icon(Icons.photo_camera,color:Colors.white),
        ),
          ],
        ),
        
        RaisedButton(
          onPressed: onSubmit,
          color: Colors.redAccent,
          child:Text('UPLOAD',style: TextStyle(color:Colors.white),),
        ),
        Text(helperText),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){Navigator.pushNamed(context, 'LocationReg');},
        child: Icon(Icons.navigate_next,color:Colors.white),
      ),
    );
  }
}