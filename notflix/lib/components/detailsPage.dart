import 'package:flutter/material.dart';
import '../components/cardComponent.dart';
import 'dart:ui';

class detailPage extends StatefulWidget {
  detailPage({Key key, this.img ,@required this.title, @required this.link}) : super(key: key);

  String link,img,title;

  @override
  _detailPageState createState() => _detailPageState();
}

// FetchMovieData() async {
  
// }

class _detailPageState extends State<detailPage> {

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   var Height = MediaQuery.of(context).size.height;
   var Width = MediaQuery.of(context).size.width;

    return Container(
       child: Column(
         children: <Widget>[

          // Image on top
          Container(
                height: Height*0.36,
                width: Width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.img),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect( // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                      child: Image.network(widget.img)
                    ),
                  ),
                ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: RaisedButton(
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(10),
                  onPressed: (){},
                  child: Text(
                    "Watch "+ widget.title+" now",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                ),
            ),
            
            // Container(
            //   padding: EdgeInsets.all(10),
            //   child:Center(
            //     child: Text(
            //       widget.title,
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold
            //       ),
            //     ),
            //   )
            // ),

            Container(
              padding: EdgeInsets.only(top:5,left: 25,right: 25,bottom: 10),
              child: Center(
                child: Text(
                  "The Pittsburgh basketball team is hopeless. Maybe with the aid of an astrologer, and some new astrologically compatible players, they can become winners.",
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                )
              )
            ),

            Row(
             children: <Widget>[
               Padding(padding: EdgeInsets.only(top: Height*0.1, left: 10)),
               Text("Recommended for you",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
             ],
           ),
           
           Container(
             padding: EdgeInsets.only(left: 0.5,right: 0.5),
             height: Height*0.33,
              child: GridView.builder(
              itemBuilder: (context, index) {
                  return CardComponent(img: 'abs', height: Height*0.22, width: Width*0.4,);
                },
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              )
           )

          ],
        )
      );
  }
}