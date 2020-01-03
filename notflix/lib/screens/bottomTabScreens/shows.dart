import 'package:flutter/material.dart';

class Shows extends StatefulWidget {
  Shows({Key key}) : super(key: key);

  @override
  _ShowsState createState() => _ShowsState();
}

class _ShowsState extends State<Shows> {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.black,
       child: Center(
         child: Text("Shows", style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold
         ),),
       )
    );
  }
}