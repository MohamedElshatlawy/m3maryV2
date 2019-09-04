import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m3maryapp/Pages/HomePage.dart';
import 'package:toast/toast.dart';
import '../ToolsApp/app_Colors.dart';
import '../ToolsApp/app_tools.dart';
import '../Components/Drawer_App.dart';
import 'package:http/http.dart' as http;


class ContactUs extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<ContactUs> {

  //===== Function Button Design ========================================
  void Function_ButtonSend(){
    Toast.show(" send message  ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.grey);
  }

  
  List datacontactus = [];
  void getAllSubjects() {
    var url = 'http://e3mar.vision.com.sa/API/Contactus.php?Name='+'${_ControllerName.text}'+'&Email='+'${_ControllerEmail.text}'+'&Mobile='+'${457878}'+'&Message='+'${_ControllerText.text}';
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata['success']);
       print(extractdata);
      if (extractdata['success'] == 1) {
        setState(() {
        datacontactus = extractdata['Subjects'];
        print(extractdata['message']);
         Toast.show("تم الإرسال بنجاح", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.red);
        });
         Navigator.push(context, MaterialPageRoute(builder: 
            (context) => HomePage()),);
            Function_ButtonSend();
      } else {
        // Toast.show(extractdata['message'], context,
        //     duration: Toast.LENGTH_LONG,
        //     gravity: Toast.CENTER,
        //     backgroundColor: Colors.red);
      }
    });
  }


  //===== Function Button Design ========================================
  void Function_ButtonSearch(){
    Toast.show(" Search ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }

  TextEditingController _ControllerName = TextEditingController();
  TextEditingController _ControllerEmail = TextEditingController();
  TextEditingController _Controllerphone = TextEditingController();
  TextEditingController _ControllerText = TextEditingController();

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


        //---------body---------------------------------------
        body: ListView(children: <Widget>[
          Directionality(textDirection: TextDirection.rtl,
            child: new Container(
              padding: EdgeInsets.all(30),
              child: Column(children: <Widget>[

                my_TextField(Radius: 5 ,labelText: "الاسم " , TextInput: TextInputType.text , controllers: _ControllerName),
                SizedBox(height: 10),

                my_TextField(Radius: 5 ,labelText: "البريد الاكتروني " , TextInput: TextInputType.emailAddress , controllers: _ControllerEmail),
                SizedBox(height: 10),

                  my_TextField(Radius: 5 ,labelText: "رقم التلفون " , TextInput: TextInputType.emailAddress , controllers: _Controllerphone),
                SizedBox(height: 10),

                SizedBox(height: 10),
                my_TextField(Radius: 5 , labelText: "الرسالة"  , maxLines: 8 , controllers: _ControllerText , TextInput: TextInputType.text),

                SizedBox(height: 20),
                my_Button(onBtnclicked: (){
                getAllSubjects();} , radiusButton: 5 ,textButton: "ارسال "  , colorButton: anColor2)
              ],
            ),),
          )

        ],),






      ),
    );
  }
}