import 'package:flutter/material.dart';

class CardComponent extends StatefulWidget {
  CardComponent({Key key, @required this.img, @required this.height, @required this.width}) : super(key: key);

  String img;
  var height,width;

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {

    var Height = MediaQuery.of(context).size.height;
    var Width = MediaQuery.of(context).size.width;

    return Container(
      // height: widget.height,
      // width: widget.width,
      child:Center(
        child: Card(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(15.0)
          // ),
          elevation: 10.0,
          // borderOnForeground: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                widget.img.toString(),
                fit: BoxFit.fill,
                height: widget.height,
                width: widget.width,
              ),
            ],
          ),
        ),
      )
     );
  }
}