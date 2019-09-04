import 'package:flutter/material.dart';
import '../ToolsApp/app_Colors.dart';
import '../Pages/AllPostes.dart';
import '../Pages/HomePage.dart';
import '../Pages/PageCalculator.dart';
import '../Pages/PagePostes.dart';
import '../Pages/ContactUs.dart';
import '../Pages/aboutUs.dart';

class DrawerApp extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<DrawerApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: new Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Image.asset("assets/images/logo.png")),
              decoration: BoxDecoration(
                color: anColor1
              ),
            ),

            new ListTile(
              title: Text("المدونة "),
              leading: CircleAvatar(backgroundColor: Colors.grey[100] , child: Image.asset("assets/images/posts.png")),
              onTap: (){
                Navigator.push(context, MaterialPageRoute
                (builder: (context) => HomePage()),);
                },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            new Divider(),
             new ListTile(
              title: Text("النماذج "),
              leading: CircleAvatar(backgroundColor: Colors.grey[100] , child: Image.asset("assets/images/posts.png")),
              onTap: (){
                Navigator.push(context, MaterialPageRoute
                (builder: (context) => AllPostes()),);
                },
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            new Divider(),

            new ListTile(
              title: Text("حساب تكلفة البناء "),
              leading: CircleAvatar(backgroundColor: Colors.grey[100] , child: Image.asset("assets/images/money.png")),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PageCalculator()),);},
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            new Divider(),

            new ListTile(
              title: Text("من نحن"),
              leading: CircleAvatar(backgroundColor: Colors.grey[100] , child: Image.asset("assets/images/about.png")),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => aboutUs()),);},
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            new Divider(),


            new ListTile(
              title: Text("الاتصال بنا"),
              leading: CircleAvatar(backgroundColor: Colors.grey[100] , child: Image.asset("assets/images/callus.png")),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()),);},
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            new Divider(),


          ],
        ),
      ),
    );
  }
}