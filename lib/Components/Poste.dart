import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../ToolsApp/app_Colors.dart';
import '../ToolsApp/app_tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Pages/PagePostes.dart';
import 'package:share/share.dart';

class Poste extends StatefulWidget {
  final String textTitle ;
  final String subtitle ;
  final String imageUrl ;
  final String subid;
  const Poste({Key key, this.textTitle, this.subtitle, this.imageUrl, this.subid}) : super(key: key);
  _BirdState createState() => new _BirdState();
}


class _BirdState extends State<Poste> {

  void _FunctionMorePoste(subId){
    Navigator.push(context, MaterialPageRoute(builder: 
  (context) => PagePostes(
      subId
    )),);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[


          //=================================== هنا عنوان المقالة وزر المزيد
          GestureDetector(
            onTap: (){
              // _FunctionMorePoste();
              },
            child: Padding(
              padding: const EdgeInsets.only(right: 20 ,left: 6 , top: 3  , bottom: 3 ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new IconButton(icon: Icon(Icons.more_vert ,color: Colors.grey,size: 20,), onPressed: (){
                    // _FunctionMorePoste();
                    }),
                  new Text("${widget.textTitle}" ,style: TextStyle(fontSize: 18),),
                ],),
            ),
          ),

          //=================================== هنا عنوان صورة المقالة
          Container(
            height: 190,
            decoration: BoxDecoration(
                image:DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.imageUrl))
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: <Widget>[

                new Expanded( flex:3,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(right: BorderSide(color: anColor1.withOpacity(0.3)))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          //=========Button Share=============================
                          GestureDetector( onTap: (){
                            Share.share(widget.textTitle+ " هذا عنوان المقال ");
                          },
                              child: new CircleAvatar(backgroundColor: Colors.grey[200],
                                  child: Icon(Icons.share ,size: 22, color: Colors.blueGrey[400],))
                          ),

                          //=========Button View=============================
                          SizedBox(width: 5) ,
                          GestureDetector( onTap: (){
                            _FunctionMorePoste(widget.subid);
                          },
                              child: new CircleAvatar(backgroundColor: Colors.grey[200],
                                  child: Icon(Icons.remove_red_eye ,size: 22, color: Colors.blueGrey[400],))
                          ),

                          //=========Button Like=============================
                          // SizedBox(width: 5) ,
                          // GestureDetector( onTap: (){},
                          //     child: new CircleAvatar(backgroundColor: Colors.grey[200],
                          //         child: Icon(FontAwesomeIcons.solidThumbsUp ,size: 22, color: Colors.blueGrey[400],))
                          // ),

                        ],),
                    )),
                // ----------------- # تسميات -------------
                new Expanded(flex: 4,
                    child: Container( height: 40,
                        margin: EdgeInsets.only(left: 5 ,right: 5),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[

                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: my_Button(
                            //       onBtnclicked: (){} , radiusButton: 15 , textButton: " تسميات # " ,
                            //       colorButton: Colors.grey[200] ,colorText: Colors.blueGrey ),
                            // ),

                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: my_Button(
                            //       onBtnclicked: (){} , radiusButton: 15 , textButton: " تسميات # " ,
                            //       colorButton: Colors.grey[200] ,colorText: Colors.blueGrey ),
                            // ),

                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: my_Button(
                            //       onBtnclicked: (){} , radiusButton: 15 , textButton: " تسميات # " ,
                            //       colorButton: Colors.grey[200] ,colorText: Colors.blueGrey ),
                            // ),

                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: my_Button(
                            //       onBtnclicked: (){} , radiusButton: 15 , textButton: " تسميات # " ,
                            //       colorButton: Colors.grey[200] ,colorText: Colors.blueGrey ),
                            // ),

                            // Padding(
                            //   padding: const EdgeInsets.only(right: 5),
                            //   child: my_Button(
                            //       onBtnclicked: (){} , radiusButton: 15 , textButton: " تسميات # " ,
                            //       colorButton: Colors.grey[200] ,colorText: Colors.blueGrey ),
                            // ),


                          ],)
                    )),
              
              ],
            ),
          )


        ],
      ),
    );
  }
}