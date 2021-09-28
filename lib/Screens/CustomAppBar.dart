import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/main.dart';
import 'package:mishwar/Screens/Notifications.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'package:mishwar/lang/app_Localization.dart';

class CustomAppBar extends StatefulWidget{
  String Title;
   CustomAppBar(String Title ){
    this.Title=Title;
   }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }


}
class _state extends State<CustomAppBar>{
  String Title;
  GlobalKey<ScaffoldState> scaffoldKey ;
  home h=new home();
  _state(String Title, GlobalKey<ScaffoldState> _scaffoldKey ){
    this.Title=Title;
    this.scaffoldKey=_scaffoldKey;
  }
  @override
  Widget build(BuildContext context) {
    return   Container(
        height: MediaQuery.of(context).size.height*.07,
        child:  Container(
            height: MediaQuery.of(context).size.height*.07,
            width: MediaQuery.of(context).size.width,
            color: Color(h.mainColor),
            padding: EdgeInsets.only(
              left:MediaQuery.of(context).size.width*.05,
              right: MediaQuery.of(context).size.width*.05,

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:DemoLocalizations.of(context).locale == Locale("en")
                        ? Icon(Icons.arrow_back_ios_rounded, size: 25, color:Colors.white)
                        : Icon(Icons.arrow_forward_ios_rounded,
                        size:25, color:Colors.white)),
                Text(this.Title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),

              ],
            ),
          ),

      )
    ;
  }
}