
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:m3maryapp/Pages/HomePage.dart';
import 'package:toast/toast.dart';
import '../ToolsApp/app_Colors.dart';
import '../Components/Drawer_App.dart';
import '../Components/ButtonHeader.dart';
import '../Components/Poste.dart';
import 'package:http/http.dart' as http;


class DepartmentExample extends StatefulWidget {
  final String depId;
  DepartmentExample(this.depId);
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<DepartmentExample> {

  //===== Function Button Design ========================================
  void Function_ButtonSearch(){
    // Toast.show("Search ", context,
    //  duration: Toast.LENGTH_LONG, gravity:
    //    Toast.CENTER ,backgroundColor: Colors.red);
  }


 var isLoading=false;
List dataSubjects = [];

  void getAllSubjects() {
   setState(() {
       isLoading = true;
     });
  print(widget.depId);
    var url = "http://e3mar.vision.com.sa/API/GetAllCatTopics.php?SecID="+widget.depId.toString();
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      isLoading=false;
    setState(() {
      
   
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata['success']);
      // print(extractdata);
      if (extractdata['success'] == 1) {
        dataSubjects = extractdata['Subjects'];
        print(extractdata['Subjects']);
      } else {
        Toast.show("لا يوجد مقالات ", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.grey);
      }
    });
     });
  }

  @override
  void initState() {
    super.initState();
    getAllSubjects();
    print(widget.depId);  }


  Widget appBarTitle = InkWell( onTap: (){}, child: Image.asset("assets/images/logo.png"));
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(fontFamily: "Cairo"),
      home:  new Scaffold(
        backgroundColor: Colors.grey[100],


        //---------AppBar---------------------------------
        appBar: AppBar(
          backgroundColor:anColor1,
          elevation: 0,
          centerTitle: true,
          title:appBarTitle,
          // leading:IconButton(icon: actionIcon,onPressed:(){
          //   setState(() {
          //     if ( this.actionIcon.icon == Icons.search){
          //       this.actionIcon = new Icon(Icons.close);
          //       this.appBarTitle = new TextField(
          //         style: new TextStyle(color: Colors.white),
          //         decoration: new InputDecoration(
          //           prefixIcon: new Icon(Icons.search,color: Colors.white),
          //           hintText: "ابحث هنا",
          //           hintStyle: new TextStyle(color: Colors.grey),
          //         ),
          //         textAlign: TextAlign.center,
          //         cursorColor: Colors.amber,
          //         textInputAction: TextInputAction.search,
          //         onEditingComplete: (){ 
          //           // Function_EditingComplete();
          //           },
          //       );
          //     }
          //     else {
          //       this.actionIcon = new Icon(Icons.search);
          //       this.appBarTitle = InkWell( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);},
          //           child: Image.asset("assets/images/logo.png"));
          //     }
          //   });
          // } ,),
        
        ),



        //---------endDrawer---------------------------------
        endDrawer: new DrawerApp(),



        //---------body---------------------------------
        body:isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
          children: <Widget>[
            //   // هنا الكونتير الخاص القائمة العلوية - تصاميم - المقالات - حسابة تكلفة البناء
            new ButtonHeader(),

            //-- هنا الجزء الخاص بصور الاعلانات
            Padding(
              padding: const EdgeInsets.only(top: 15 ,bottom: 10),
              child: new Container(
                height: 110,
//                color: Colors.grey,
                decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.fill,
                        image: AssetImage("assets/images/banner.png"))
                ),
              ),
            ),


            new Expanded(
                child: ListView.builder(
                    itemCount: dataSubjects.length,
                    itemBuilder: (BuildContext context , i){
                      return Poste(
                        // dataSubjects[i]['Title'],
//             // dataSubjects[i]['ImgSubject'],
//             // dataSubjects[i]['id'],
                        textTitle: "${dataSubjects[i]['Title']}",
                        subtitle: "${dataSubjects[i]['ImgSubject']}",
                        imageUrl: "${dataSubjects[i]['ImgSubject']}",
                        subid:"${dataSubjects[i]['id']}",
                      );
                    }
                )
            )

          ],
        ),



      ),
    );
  }


}