import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  Movies({Key key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.black,
       child: Center(
         child: Text("Movies", style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold
         ),),
       ),
    );
  }
}