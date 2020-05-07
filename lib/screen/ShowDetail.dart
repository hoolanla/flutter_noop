import 'package:flutter/material.dart';

class ShowDetail extends StatefulWidget{
  final String imagePath;
  final String price;
  final String name;
  final String desc;
  ShowDetail({this.imagePath,this.price,this.name,this.desc});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShowDetailState();
  }
  
}
class ShowDetailState extends State<ShowDetail>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[

           Image.network(widget.imagePath),
        Text('Name: ' + widget.name),
         Text('Price: ' + widget.price),

 Text('Description: ' + widget.desc),

        ],
      ),
    );
  }
  
}