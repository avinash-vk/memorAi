import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';



Future<String> firebaseUpload(File image) async {
  FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://memorai-920f7.appspot.com');
  StorageUploadTask _uploadTask;

    /// Unique file name for the file
  String filePath = 'images/${DateTime.now()}.png';
  
  final ref = _storage.ref().child(filePath);
  _uploadTask = ref.putFile(image);
  return await (await _uploadTask.onComplete).ref.getDownloadURL();
  
} 

