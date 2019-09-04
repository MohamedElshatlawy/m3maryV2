import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m3maryapp/Pages/HomePage.dart';
import 'package:m3maryapp/Pages/departmentExample.dart';
import 'package:m3maryapp/Pages/galary.dart';
import '../ToolsApp/app_Colors.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../Pages/PageCalculator.dart';
import '../Pages/AllPostes.dart';
import '../Pages/PagePostes.dart';

class ButtonHeader extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<ButtonHeader> {
  //===== Function Button Design ========================================
  void Function_Buttondesign() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllPostes()),
    );
  }

  //===== Function Button Posts =========================================
  void Function_ButtonPosts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  //===== Function Button Cal ===========================================
  void Function_ButtonCal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageCalculator()),
    );
  }

  //===== Function Button Cal ===========================================
  void Function_ButtonDecor() {
    // Toast.show("ديكورات", context,
    // duration: Toast.LENGTH_LONG, gravity:
    //   Toast.CENTER , backgroundColor: Colors.grey);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DepartmentExample(Constants.DecorID)),
    );
  }

  //===== Function Button Cal ===========================================
  void Function_ButtonBishop() {
    // Toast.show("اسقف ديكور", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER , backgroundColor: Colors.grey);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DepartmentExample(Constants.WallsID)),
    );
  }

  //===== Function Button Cal ===========================================
  void Function_ButtonWalls() {
    // Toast.show("جدران وجهات", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER , backgroundColor: Colors.grey);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DepartmentExample(Constants.BishopID)),
    );
  }
///////////////////////////////////buttom example
  //===== Function Button Cal ===========================================
  void Function_ButtonDecorExample() {
    // Toast.show("ديكورات", context,
    // duration: Toast.LENGTH_LONG, gravity:
    //   Toast.CENTER , backgroundColor: Colors.grey);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Galary(ConstantsExample.DecorExampleID,ConstantsExample.DecorExample)),
    );
  }

  //===== Function Button Cal ===========================================
  void Function_ButtonBishopExample() {
    // Toast.show("اسقف ديكور", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER , backgroundColor: Colors.grey);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Galary(ConstantsExample.BishopExampleID,ConstantsExample.BishopExample)),
    );
  }

///
  List department;
  void getdepartment() {
    var url = "http://e3mar.vision.com.sa/API/GetAllSections.php";
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      setState(() {
        // var extractdata = json.decode(response.body);
        var extractdata = json.decode(response.body);
        print(extractdata['success']);
        print("deeeeeeeeeeeeeeeeepaaaaaaaaaartment");

        if (extractdata['success'] == 1) {
          department = extractdata['Sections'];
          print(extractdata['Sections']);
          Constants.Decor = department[0]['NameAr'];
          Constants.Bishop = department[1]['NameAr'];
          Constants.Walls = department[2]['NameAr'];
          Constants.DecorID = department[0]['id'];
          Constants.BishopID = department[1]['id'];
          Constants.WallsID = department[2]['id'];
          print(Constants.DecorID);
        } else {
          Toast.show("لا يوجد أقسام ", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.red);
        }
      });
    });
  }

  List example;
  void getexample() {
    var url = "http://e3mar.vision.com.sa/API/GetAllFormsSection.php";
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      setState(() {
        // var extractdata = json.decode(response.body);
        var extractdata = json.decode(response.body);
        print(extractdata['success']);
        print("deeeeeeeeeeeeeeeeepaaaaaaaaaartment");

        if (extractdata['success'] == 1) {
          department = extractdata['FormsSection'];
          print(extractdata['FormsSection']);
          ConstantsExample.DecorExample = department[0]['NameAr'];
          ConstantsExample.BishopExample = department[1]['NameAr'];
          // ConstantsExample.Walls=department[2]['NameAr'];
          ConstantsExample.DecorExampleID = department[0]['id'];
          ConstantsExample.BishopExampleID = department[1]['id'];
          // ConstantsExample.WallsID=department[2]['id'];
          print(ConstantsExample.DecorExampleID);
        } else {
          Toast.show("لا يوجد أقسام ", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.red);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getdepartment();
    getexample();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Decor) {
      Function_ButtonDecor();
    } else if (choice == Constants.Bishop) {
      Function_ButtonBishop();
    } else if (choice == Constants.Walls) {
      Function_ButtonWalls();
    }
  }


  void choiceActionExample(String choice) {
    if (choice == ConstantsExample.DecorExample) {
      Function_ButtonDecorExample();
    } else if (choice == ConstantsExample.BishopExample) {
      Function_ButtonBishopExample();
    } else if (choice == ConstantsExample.WallsExample) {
      // Function_ButtonWalls();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: anColor1.withOpacity(0.2)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _ExpandedButton2(
              onTap: () {
                Function_ButtonCal();
              },
              nameButton: "حسابة تكلفة البناء",
              imageURL: "assets/images/cal.png"),
          _ExpandedButton(
              nameButton: "المقلات", imageURL: "assets/images/posts.png"),
          _ExpandedButtondecore(
              nameButton: "تصاميم", imageURL: "assets/images/design.png"),
        ],
      ),
    );
  }

  Expanded _ExpandedButtondecore({
    String nameButton = " name Button ",
    String imageURL = "assets/images/design.png",
    GestureTapCallback onTap,
  }) {
    return Expanded(
        flex: 0,
        child: Container(
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              border:
                  Border(left: BorderSide(color: anColor1.withOpacity(0.1)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new PopupMenuButton<String>(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      nameButton,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Container(height: 45, child: Image.asset(imageURL)),
                  ],
                ),
                onSelected: choiceActionExample,
                itemBuilder: (BuildContext content) {
                  return ConstantsExample.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(choice)),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ));
  }

  Expanded _ExpandedButton({
    String nameButton = " name Button ",
    String imageURL = "assets/images/design.png",
    GestureTapCallback onTap,
  }) {
    return Expanded(
        flex: 0,
        child: Container(
          padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              border:
                  Border(left: BorderSide(color: anColor1.withOpacity(0.1)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new PopupMenuButton<String>(
                child: new Row(
                  children: <Widget>[
                    new Text(
                      nameButton,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Container(height: 45, child: Image.asset(imageURL)),
                  ],
                ),
                onSelected: choiceAction,
                itemBuilder: (BuildContext content) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(choice)),
                    );
                  }).toList();
                },
              ),
              // Container( height: 45, child: Image.asset(imageURL)),
            ],
          ),
        ));
  }

  Expanded _ExpandedButton3({
    String nameButton = " name Button ",
    String imageURL = "assets/images/design.png",
    GestureTapCallback onTap,
  }) {
    return Expanded(
        flex: 0,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(left: BorderSide(color: anColor1.withOpacity(0.1)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        nameButton,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Container(height: 45, child: Image.asset(imageURL)),
                    ],
                  ),
                ),
                // Container( height: 45, child: Image.asset(imageURL)),
              ],
            ),
          ),
        ));
  }

  Expanded _ExpandedButton2({
    String nameButton = " name Button ",
    String imageURL = "assets/images/design.png",
    GestureTapCallback onTap,
  }) {
    return Expanded(
        flex: 0,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: new Row(
                    children: <Widget>[
                      new Text(
                        nameButton,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Container(height: 45, child: Image.asset(imageURL)),
                    ],
                  ),
                ),
                // Container( height: 45, child: Image.asset(imageURL)),
              ],
            ),
          ),
        ));
  }
}

class Constants {
  static String Decor = "";
  static String Bishop = "";
  static String Walls = "";
  static String DecorID;
  static String BishopID;
  static String WallsID;
  static List<String> choices = <String>[
    Decor,
    Bishop,
    Walls,
  ];
}

class ConstantsExample {
  static String DecorExample = "";
  static String BishopExample = "";
  static String WallsExample = "";
  static String DecorExampleID;
  static String BishopExampleID;
  static String WallsExampleID;
  static List<String> choices = <String>[
    DecorExample,
    BishopExample,
    // Walls,
  ];
}
