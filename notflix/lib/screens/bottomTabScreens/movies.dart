import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../components/cardComponent.dart';

FetchTopMovies() async{
    var resp = await http.get('http://localhost:9000/top-movies', headers: {"Accept":"application/json"});

    if(resp.statusCode==200){
      var movies =  resp.body;
      var movie =  json.decode(movies);
      return movie;
    }
    else{
      FetchTopMovies();
    }  
}

FetchPopMovies() async{
   var resp = await http.get('http://localhost:9000/pop-movies', headers: {"Accept":"application/json"});

    if(resp.statusCode==200){
      var movies =  resp.body;
      var movie =  json.decode(movies);
      return movie;
    }
    else{
      FetchPopMovies();
    } 
}

class Movies extends StatefulWidget {
  Movies({Key key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  
  Map topMovies,popMovies;
  List keys, popkeys;
  
  @override
  void initState() { 
    super.initState();

    FetchTopMovies()
    .then((resp){
        var key = resp.keys.toList();
        setState(() {
          topMovies = resp;
          keys = key;
        });
    });

    FetchPopMovies()
    .then((resp){
        var key = resp.keys.toList();
        setState(() {
          popMovies = resp;
          popkeys = key;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;

    return Container(
       color: Colors.black,
       child: Column(
         children: <Widget>[

           Row(
             children: <Widget>[
               Padding(padding: EdgeInsets.only(top: Height*0.1, left: 10)),
               Text("Trending Movies",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
             ],
           ),

           Container(
             color: Colors.black,
              // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              height: Height*0.25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: keys.length, itemBuilder: (context, index) {
                     return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[ 
                          CardComponent(img: topMovies[keys[index]]['img'].toString(), height: Height*0.24, width: Width*0.4),
                        ]
                    );
               }),
            ),

           Row(
             children: <Widget>[
               Padding(padding: EdgeInsets.only(top: Height*0.1, left: 10)),
               Text("Most Viewed Movies",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
             ],
           ),

           Container(
             height: Height*0.32,
              child: GridView.builder(
              itemBuilder: (context, index) {
                  return CardComponent(img: popMovies[popkeys[index]]['img'].toString(), height: Height*0.22, width: Width*0.4,);
                },
                itemCount: popkeys.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              )
           )
          ],
       )
    );
  }
}

 