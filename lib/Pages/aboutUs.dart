import 'dart:convert';

import '../Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../ToolsApp/app_Colors.dart';
import '../Components/Drawer_App.dart';
import 'package:http/http.dart' as http;

class aboutUs extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<aboutUs> {


  //===== Function Button Design ========================================
  void Function_ButtonSearch(){
    Toast.show("Search ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }

  String textAbout = "";
List dataaboutus = [];
var isLoading = false;
  void getAllSubjects() {
       setState(() {
       isLoading = true;
     });
    var url = "http://e3mar.vision.com.sa/API/AboutUs.php";
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      isLoading = false;
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata['success']);
      // print(extractdata);
      if (extractdata['success'] == 1) {
        setState(() {
        dataaboutus = extractdata['AboutUs'];
        print(extractdata['AboutUs']);
        textAbout=extractdata['AboutUs'][0]['subject'];
        });
      } else {
        Toast.show("لا يوجد مقالات ", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.red);
      }
    });
  }

   @override
  void initState() {
    super.initState();
    getAllSubjects();
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(fontFamily: "Cairo"),
      home:  new Scaffold(


        //---------AppBar---------------------------------
        appBar: AppBar(
          elevation: 0,
          backgroundColor:anColor1,
          centerTitle: true,
          title: GestureDetector( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);},
              child: Image.asset("assets/images/logo.png")),
          // leading: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: (){Function_ButtonSearch();}),
        ),


        //---------endDrawer---------------------------------
        endDrawer: DrawerApp(),


        //---------body---------------------------------
        body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :
        ListView(children: <Widget>[

          new Container(
            padding: EdgeInsets.all(20),
            child: Text(textAbout,textDirection: TextDirection.rtl,),
          )

        ],),




      ),
    );
  }
}