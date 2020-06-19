
import 'package:flutter/material.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
    CustomAppBar({Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

    @override
    final Size preferredSize; // default is 56.0

    @override
    _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

    @override
    Widget build(BuildContext context) {
        return AppBar(
          backgroundColor: Colors.redAccent,
            title: Text(
              'MemorAi',
              style:TextStyle(
                fontSize:30,
                letterSpacing: 2.0,
              ),
            ),
            centerTitle: true,
        );
    }
}
