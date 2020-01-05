import 'dart:async';
import 'package:flutter/material.dart';
import './screens/bottomTab.dart';    //Bottom Navigation Bar + appBar
import './components/cardComponent.dart';

void main() => runApp(MaterialApp(

      initialRoute: '/',
      routes: {

          '/': (context)=> SplashScreen(),
          '/home' : (context) => appBar(),
          // '/card' : (context) => CardComponent()

      },
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage); 
  }
  
  void display(){
    print("done");
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.black,
      child: new Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            Image.asset('logo_text_black.png'),
            Image.asset('logo_icon_black.png'),
            Spacer()
          ],
        )
      ),
    );
  }
}