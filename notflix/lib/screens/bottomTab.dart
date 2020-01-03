import 'package:flutter/material.dart';
import './bottomTabScreens/movies.dart';
import './bottomTabScreens/search.dart';
import './bottomTabScreens/shows.dart';
import 'dart:async';

class appBar extends StatefulWidget {
  appBar({Key key}) : super(key: key);

  @override
  _appBarState createState() => _appBarState();
}

class _appBarState extends State<appBar> {
 
  List<Widget> _screens= [
    Movies(),
    Shows(),
    Search()
  ];

  int _currentIndex=0;

  void onTabChange(int index){
    setState((){
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: <Widget>[
              Image.asset('logo_text_black.png', height: 250, width: 250),
              Spacer(),
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(  
            padding: EdgeInsets.all(50),
            children: <Widget>[
              ListTile(
                title: Text('Account', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                ),
                onTap: ()=>{

                }),
              ListTile(
              title: Text('Account', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              ),
              onTap: ()=>{

              }),
            ],
          ),
        ),
      ),
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        currentIndex: this._currentIndex,
        onTap: onTabChange,
        items : const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie, color: Colors.white54),
            activeIcon: Icon(Icons.movie, color: Colors.white),
            title: Text(" ", style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold
              )
            )
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.tv, color: Colors.white54),
            activeIcon: Icon(Icons.tv, color: Colors.white),
            title: Text(" ", style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search, color:Colors.white54),
            activeIcon: Icon(Icons.search, color: Colors.white),
            title: Text(" ", style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class appBar extends StatelessWidget {
//   const appBar({Key key}) : super(key: key);

 
// }