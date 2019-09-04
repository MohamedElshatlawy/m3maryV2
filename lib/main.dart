import 'package:flutter/material.dart';
import './Pages/HomePage.dart';
import './Pages/PagePostes.dart';
import './Pages/PageCalculator.dart';
import './Pages/AllPostes.dart';
import './Pages/aboutUs.dart';
import './Pages/ContactUs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}


class _BirdState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      home: HomePage(),

    );
  }
}