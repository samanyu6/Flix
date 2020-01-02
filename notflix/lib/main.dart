import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(

      initialRoute: '/',
      routes: {

          '/': (context)=> SplashScreen()
      },
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 10);
    return new Timer(_duration, display); 
    // navigationPage
    // );
  }
  
  void display(){
    print("done");
  }

  // void navigationPage() {
  //   Navigator.of(context).pushReplacementNamed('/HomeScreen');
  // }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Center(
        child: new Image.asset('logo_icon.png'),
      ),
    );
  }
}