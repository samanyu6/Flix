import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.black,
       child: Center(
         child: Text("Search", style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold
         ),),
       )
    );
  }
}