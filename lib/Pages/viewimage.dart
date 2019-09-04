import 'package:flutter/material.dart';
import 'package:m3maryapp/ToolsApp/app_Colors.dart';

class ViewImage extends StatefulWidget {
  final String image;
  final String title;

  const ViewImage(this.image, this.title);
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
            child:new Scaffold(
        //---------AppBar---------------------------------
        appBar: AppBar(
          backgroundColor: anColor1,
          title: new Text(widget.title),
          ),
          body:Container(
       decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          color: Colors.blueGrey,
          
          image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage('http:\/\/e3mar.vision.com.sa\/uploads\/'+widget.image)
          )
          ),
    )));
  }
}