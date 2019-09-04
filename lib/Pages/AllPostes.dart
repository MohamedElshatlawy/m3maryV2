import 'dart:convert';
import 'package:m3maryapp/Pages/PagePostes.dart';
import 'package:m3maryapp/Pages/viewimage.dart';
import '../Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../ToolsApp/app_Colors.dart';
import '../ToolsApp/app_tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Components/Drawer_App.dart';
import '../Components/ButtonHeader.dart';
import 'package:http/http.dart' as http;

class AllPostes extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<AllPostes> {
  //===== Function  Poste ========================================
  void Function_Poste() {
    Toast.show("هنا يتم الانتقال الي المقاله  ", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red);
  }

  var isLoading = false;
  //===== Function Button Design ========================================
  void Function_ButtonSearch() {
    Toast.show("Search ", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red);
  }

  List dataSubjects = [];
  void getAllSubjects() {
    setState(() {
      isLoading = true;
    });
    var url = "http://e3mar.vision.com.sa/API/GetAlExemplar.php";
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      isLoading = false;
      setState(() {
        // var extractdata = json.decode(response.body);
        var extractdata = json.decode(response.body);
        print(extractdata['success']);
        print(extractdata);
        if (extractdata['success'] == 1) {
          dataSubjects = extractdata['Exemplar'];
          print(extractdata['Exemplar']);
        } else {
          Toast.show("لا يوجد مقالات ", context,
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
    getAllSubjects();
  }

  Widget appBarTitle = InkWell(
      onTap: () {
        print("Home");
      },
      child: Image.asset("assets/images/logo.png"));
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(fontFamily: "Cairo"),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        //---------AppBar---------------------------------
        appBar: AppBar(
          backgroundColor: anColor1,
          elevation: 0,
          centerTitle: true,
          title: appBarTitle,
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
          //           //  Function_EditingComplete();
          //            },
          //       );
          //     }
          //     else {
          //       this.actionIcon = new Icon(Icons.search);
          //       this.appBarTitle = InkWell( onTap: (){ print("Home"); }, child: Image.asset("assets/images/logo.png"));
          //     }
          //   });
          // }
          // ),
        ),

        //---------endDrawer---------------------------------
        endDrawer: DrawerApp(),

        //---------endDrawer---------------------------------
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ButtonHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: new Text("قائمة النماذج"),
                    ),
                    Flexible(
                      child: new GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: dataSubjects.length,
                          itemBuilder: (BuildContext context, index) {
                            return _buildGestureDetector(

                                // title: "${dataSubjects[index]['Title']}",
                                imag:
                                    "http:\/\/e3mar.vision.com.sa\/uploads\/${dataSubjects[index]['ImgExemplar']}",
                                onTap: () {
                                  print("object");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => 
                                        ViewImage(
                                            dataSubjects[index]
                                                ['ImgExemplar'],
                                                dataSubjects[index]['Title'])),
                                  );
                                });
                          }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  GestureDetector _buildGestureDetector({
    String title = "",
    String imag = "",
    GestureTapCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(3),
        child: GridTile(
          child: Container(
            // child: PhotoView(
            //   imageProvider: NetworkImage(imag),
            // ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey,

              image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imag)
              )
            ),
          ),
          // footer: Container(
          // height: 50,
          // decoration: BoxDecoration(
          // color: Colors.black87.withAlpha(170),
          // borderRadius: BorderRadius.only(bottomRight: Radius.circular(13) , bottomLeft: Radius.circular(13))
          //   ),
          //   child: Align(alignment: Alignment.center,child: Text(title ,style: TextStyle(color: Colors.white , fontSize: 12 ),textAlign: TextAlign.center,),),
          // ),
        ),
      ),
    );
  }
}
