import 'package:flutter/material.dart';
import 'package:frontend/components/Appbar.dart';

class initialLoading extends StatefulWidget {
  @override
  _initialLoadingState createState() => _initialLoadingState();
}

class _initialLoadingState extends State<initialLoading> {
  var loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:Container(
        
      )
    );
  }
}