
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3maryapp/Pages/HomePage.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import '../Components/Drawer_App.dart';
import '../ToolsApp/app_Colors.dart';
import '../ToolsApp/app_tools.dart';
import '../Components/ButtonHeader.dart';
import 'package:http/http.dart' as http;


class PagePostes extends StatefulWidget {
  final String subjectid;
PagePostes(this.subjectid);
  // const PagePostes({Key key, this.subjectid}) : super(key: key);
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<PagePostes> {

  String post = '';
  String imagSubject='';
  String title='';
  var isLoading=false;
List dataSubjects = [];
List simillar=[];
  void getAllSubjects() {
     setState(() {
       isLoading = true;
     });
    var url = "http://e3mar.vision.com.sa/API/GetSubjects.php?id="+widget.subjectid;
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      isLoading=false;
    setState(() {
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata['success']);
      print(extractdata);
      if (extractdata['success'] == 1) {
        dataSubjects = extractdata['Subjects'];
        print(extractdata['Subjects']);
        post=extractdata['Subjects'][0]['Subject'];
        title=extractdata['Subjects'][0]['Title'];
        imagSubject=extractdata['Subjects'][0]['ImgSubject'];

      } else {
        Toast.show("لا يوجد مقالات ", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.red);
      }
    });
     });
  }


  //get list smiller
  void getSimillar() {
    print("id is:");
    print( widget.subjectid);
    var url = "http://e3mar.vision.com.sa/API/GetSimillar.php?id="+widget.subjectid;
   print( url);
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
    setState(() {
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata['success']);
      // print(extractdata);
      if (extractdata['success'] == 1) {
        simillar = extractdata['Subjects'];
        print("daaaaaaaaaata");
        print(simillar);
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
    getSimillar();
    print(widget.subjectid);
  }
  //===== Function Button Cal ===========================================
  void Function_FaceBook(){
    // Toast.show("FaceBook", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }

  //===== Function Button Cal ===========================================
  void Function_pinterest(){
    Toast.show("pinterest", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }

  //===== Function Button Cal ===========================================
  void Function_twitter(){
    Toast.show("twitter", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }

  //===== Function Button Design ========================================
  void Function_ButtonSearch(){
    Toast.show("Search ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }


  //===== Function Button Design ========================================
  // void Function_Poste(int index){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => PagePostes(
  //     title:  title,
  //     imagURL: imagSubject,
  //     description: post,
  //   )),);
  // }

  //===== Function Button Design ========================================
  void Function_EditingComplete(){
    Toast.show("Search ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
  }

  Widget appBarTitle = InkWell( onTap: (){ print("Home"); }, child: Image.asset("assets/images/logo.png"));
  Icon actionIcon = new Icon(Icons.search);


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(fontFamily: "Cairo"),
      home:  new Scaffold(


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
          //         onEditingComplete: (){ Function_EditingComplete();},
          //       );
          //     }
          //     else {
          //       this.actionIcon = new Icon(Icons.search);
          //       this.appBarTitle = InkWell( onTap: (){ print("Home"); }, child: Image.asset("assets/images/logo.png"));
          //     }
          //   });
          // } ,),
      
        ),


        //-----------endDrawer---------------------------------
        endDrawer: new DrawerApp(),


        //-----------body---------------------------------------
        body: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  :ListView(
          children: <Widget>[
            new ButtonHeader(),

            _ContainerPoster(),

            // شارك مع اصدقائك
            Container(
              height: 70,
              margin: EdgeInsets.only(top: 5 , bottom: 5),
              color: Colors.white,
              child: Row(
              children: <Widget>[
                new Expanded(child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                  new IconButton(icon:Icon(FontAwesomeIcons.shareAlt,color: Colors.blue,size: 30,),
                  onPressed: (){ Share.share(title+" هذا عنوان المقال ");}),

                  // new IconButton(icon:Icon(FontAwesomeIcons.share , color: Colors.blue,size: 30,),
                  // onPressed: (){
                  //  Share.share(title+" هذا عنوان المقال ");}),

    //               new IconButton(icon:Icon(FontAwesomeIcons.facebook ,color: Colors.indigo[700], size: 30,),
    //               onPressed: (){
    // Share.share(title+" هذا عنوان المقال ");

    //               }),
                ],))),

                new Expanded(child: Container(child: Text(" شارك المقال مع أصدقائك "),)),
              ],
            ),),


            // مقالات مشابهة ------
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 5 , bottom: 30 , left: 10 , right: 10),
              margin: EdgeInsets.only(top: 5 , bottom: 5),
              child: Column(
                children: <Widget>[

                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                    new Text("مقالات مشابهة"),
                    my_IconInContainer(widget: Image.asset("assets/images/posts.png") ,
                    color2: Colors.grey[200],heightWidth: 60),
                  ],),
                  new Divider(),

                  new Container(
                    height: 410,
                    child:new GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: simillar.length,
                        itemBuilder: (BuildContext context , index){
                          return _buildGestureDetector(
                            title: "${simillar[index]['Title']}",
                            imag: "${simillar[index]['ImgSubject']}",
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: 
  (context) => PagePostes(
      simillar[index]['id']
    )),);
                            }
                          );
                        }
                    ),
                  ),

                ],
              )),
          ],
        ),
      ),
    );
  }

  Container _ContainerPoster() {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10 , bottom: 5),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30 ,left: 10 ,bottom: 10 , top: 10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconButton(icon: Icon(Icons.more_vert ,color: Colors.grey,size: 30,), onPressed: (){}),
                new Text("${title}" ,style: TextStyle(fontSize: 18),),
              ],),
          ),

          Container(
            height: 250,
            decoration: BoxDecoration(
                image:DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("${imagSubject}"))
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(child: Text("${post}" ,textAlign: TextAlign.right,)),
          )

        ],
      ),
    );
  }



  GestureDetector _buildGestureDetector({
    String title  = "",
    String imag ="" ,
    GestureTapCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(3),
        child: GridTile(
          child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blueGrey,
          image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imag))
          ),
        ),
          footer: Container(
          height: 50,
          decoration: BoxDecoration(
          color: Colors.black87.withAlpha(170),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(13) , bottomLeft: Radius.circular(13))
            ),
            child: Align(alignment: Alignment.center,child: Text(title ,style: TextStyle(color: Colors.white , fontSize: 12 ),textAlign: TextAlign.center,),),
          ),
        ),
      ),
    );
  }

}