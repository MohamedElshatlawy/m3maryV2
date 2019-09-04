import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m3maryapp/Pages/HomePage.dart';
import 'package:toast/toast.dart';
import '../Components/Drawer_App.dart';
import '../ToolsApp/app_Colors.dart';
import '../ToolsApp/app_tools.dart';
import '../Components/ButtonHeader.dart';
import 'package:http/http.dart' as http;

class PageCalculator extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<PageCalculator> {

  TextEditingController _textEditingController1 = new TextEditingController();
  TextEditingController _textEditingController2 = new TextEditingController() ;
  TextEditingController _textEditingController3 = new TextEditingController();
  TextEditingController _textEditingController4 = new TextEditingController() ;
  TextEditingController _textEditingController5  = new TextEditingController();
 var isLoading=false;
   dynamic priceone,pricetwo,pricethree;
  List flatoutput = [];
  dynamic price1,price2,price3;
  dynamic cost=0.0;
  void getAllSubjects() {
    var url = "http://e3mar.vision.com.sa/API/price.php";
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      isLoading=false;
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata);
      // print(extractdata);
      if (extractdata['success'] == 1) {
        setState(() {
        flatoutput = extractdata['Flat'];
         price1=flatoutput[0]['price1'];
         price2=flatoutput[0]['price2'];
         price3=flatoutput[0]['price3'];
         
        print(price1);
        });
      } else {
        Toast.show("لا يوجد اسعار ", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.red);
      }
    });
  }

calculatecost(){
  var x=0;
  var xx=0;
  // print(int.parse(_textEditingController1.text));
//   print(_textEditingController1.text);
// if(_textEditingController1.text!='' &&
//   _textEditingController2.text!='' &&
//   _textEditingController3.text!='' &&
//   _textEditingController4.text!='' &&
//   _textEditingController5.text !='' &&
//   priceone!=null
// )

if(_textEditingController1.text ==''){
  _textEditingController1.text = x.toString();
  print(_textEditingController1.text);
}
if(_textEditingController2.text ==''){
  _textEditingController2.text = x.toString();
  print(_textEditingController2.text);

}
if(_textEditingController3.text ==''){
  _textEditingController3.text = x.toString();
  print(_textEditingController3.text);

}
if(_textEditingController4.text ==''){
  _textEditingController4.text = x.toString();
  print(_textEditingController4.text);

}
if(_textEditingController5.text  ==''){
  _textEditingController5.text = x.toString();
  print(_textEditingController5.text);

}
print(x.toString());
  print("_textEditingController1.text");
  print(_textEditingController1.text);
  dynamic totledistance=int.parse(_textEditingController1.text) +
  int.parse(_textEditingController2.text)+
  int.parse(_textEditingController3.text)+
  int.parse(_textEditingController4.text)+
  int.parse(_textEditingController5.text);
  print(totledistance);
  print(priceone);
  print("priceone");
  //  print(double.parse(priceone));
   if(priceone==null)
   {
     print(price1);
     priceone= price1;
   }
  // else if(priceone!=null){
    setState(() {
  cost=totledistance * double.parse(priceone);
  print(cost);    
    });
  // }

  // else{
  //   Toast.show("يجب ان تكون المدخلات اكبر من الصفر", context,
  //           duration: Toast.LENGTH_LONG,
  //           gravity: Toast.CENTER,
  //           backgroundColor: Colors.red);
  // } 
}
  // هذا الدالة التي تقوم بتفريغ البيانات (اعادة الحسبة)
  void _ClearData(){
    setState(() {
      _textEditingController1.clear();
      _textEditingController2.clear();
      _textEditingController3.clear();
      _textEditingController4.clear();
      _textEditingController5.clear();
    });
  }

  int radioGroup = 1;
  void _radioEventHandler(int radioValue){
    setState(() {
      radioGroup = radioValue;
      switch(radioGroup)
      {
        case 1: priceone= price1 ;print(priceone);// print(price1);
         break;
        case 2: priceone=price2;
         break;
        case 3: priceone=price3;
      }
    });
  }

    @override
  void initState() {
    super.initState();
    getAllSubjects();
  }

  //===== Function Button Design ========================================
  void Function_ButtonSearch(){
    Toast.show("Search ", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER ,backgroundColor: Colors.red);
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
        endDrawer: new DrawerApp(),


        //---------body---------------------------------------
        body:isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
          children: <Widget>[

            // // هنا الكونتير الخاص القائمة العلوية - تصاميم - المقالات - حسابة تكلفة البناء
            new ButtonHeader(),

            Container(
//              height: 80,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
              color: Colors.white,
              child: Text("حاسبة تقريبية لتكلفة بناء العظم والتشطيب",
              style: TextStyle(fontSize: 17 , color: Colors.grey), textAlign: TextAlign.center,),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 10),
              color: Colors.grey[200],
              child: Row(children: <Widget>[

                Expanded(flex: 3,child: Container(
                child:  Text(" إترك قيمة المسطح الذي لا ترغب صفر واستخدم الارقام الإنجليزية " ,
                style: TextStyle(fontSize: 15), textAlign: TextAlign.center,),)),

                Expanded(child: Center(
                  child: my_IconInContainer(
                    color1: Colors.white ,
                    heightWidth: 70,
                    widget: Icon(FontAwesomeIcons.exclamationTriangle,size: 35, color: Colors.amber,)
                  ), )),
              ],)
            ),

            new Container(
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
              color: Colors.white,
              child: Row(children: <Widget>[
                //======== مسطح الدور الأول ( الأرضي )====
                Expanded(child: Column(children: <Widget>[
                  new Text("مسطح الدور الأول ( الأرضي )" ,style: TextStyle(color: Colors.grey , fontSize: 12),),
                  SizedBox(height: 10),
                  my_TextField(hintText: "0" , Radius: 1 ,TextInput: TextInputType.number ,controllers: _textEditingController1),

                  //========= مسطح الملحق===========
                  SizedBox(height: 20),
                  new Text("مسطح الملحق" ,style: TextStyle(color: Colors.grey ,fontSize: 13),),
                  SizedBox(height: 10),
                  my_TextField(hintText: "0" , Radius: 1 ,TextInput: TextInputType.number , controllers: _textEditingController2),
                ],)),

                //========= مساحة الارض ( غير مهم ) ===========
                SizedBox(width: 30),
                Expanded(child: Column(children: <Widget>[
                  new Text("مساحة الارض ( غير مهم )" ,style: TextStyle(color: Colors.grey ,fontSize: 13),),
                  SizedBox(height: 10),
                  my_TextField(hintText: "0" , Radius: 1 ,TextInput: TextInputType.number ,controllers: _textEditingController3),

                  //========= مسطح الدور الثاني ===========
                  SizedBox(height: 20),
                  new Text("مسطح الدور الثاني" ,style: TextStyle(color: Colors.grey , fontSize: 13),),
                  SizedBox(height: 10),
                  my_TextField(hintText: "0" , Radius: 1 ,TextInput: TextInputType.number , controllers: _textEditingController4),
                ],)),
              ],),
            ),

            //========= مسطح الملاحق الأرضية ===========
            new Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                new Text("مسطح الملاحق الأرضية " ,style: TextStyle(color: Colors.grey),),
                SizedBox(height: 10),
                my_TextField(hintText: "0" , Radius: 1 ,TextInput: TextInputType.number , controllers: _textEditingController5)
              ],),
            ),

            Directionality(textDirection: TextDirection.rtl,
              child: new Container(
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new RadioListTile(value: 1, groupValue: radioGroup, onChanged: _radioEventHandler ,title: Text("عظم فقط" ,style: TextStyle(fontSize: 15),),),
                    new RadioListTile(value: 2, groupValue: radioGroup, onChanged: _radioEventHandler ,title: Text("عظم وتشطيب عادي" ,style: TextStyle(fontSize: 15),),),
                    new RadioListTile(value: 3, groupValue: radioGroup, onChanged: _radioEventHandler ,title: Text("عظم وتشطيب متوسط" ,style: TextStyle(fontSize: 15),),),
                    //====== Row Arabic Language =================
                  ],
                ),),
            ),


            //==== هنا زر عرض السعر وزر اعادة الحسبة
            new Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
              child: Row(children: <Widget>[
              Expanded(child: my_Button(textButton: "إعادة الحسبة" , colorButton: anColor2 , onBtnclicked: (){calculatecost();})),
              SizedBox(width: 10),
              Expanded(child: my_Button(textButton: "عرض السعر" , colorButton: anColor2 , onBtnclicked: (){calculatecost();})),
            ],),),

            //==== هنا جزء التكلفة
            new Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 30),
              child: Row(children: <Widget>[
              Expanded(flex: 2,
                child: Container( color: Colors.grey[100],
                child: Center(child: Text(cost.toString(),style: TextStyle(fontSize: 28),)),)),
              SizedBox(width: 10),
                Expanded(child: Center(child: Text("التكلفة" ,style: TextStyle(fontSize: 20),)))
            ],),)




          ],
        ),







      ),
    );
  }
}