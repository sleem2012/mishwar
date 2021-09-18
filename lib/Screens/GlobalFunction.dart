import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GlobalFunction{
  static  Route route(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  static  Route routeBottom(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  static  Route routeBottomLeft(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  static setData(key,value,type,valu) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString(key, value);
    prefs.setString(type, valu);
  }
  static SuccessThenRetunHome(BuildContext context,String Message) {
    Timer(Duration(seconds: 2), (){
      Navigator.pushNamedAndRemoveUntil(context, "/HomePage", (route) => false);
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            width: MediaQuery.of(context).size.width*.4,
            height: 160,
            decoration: BoxDecoration(color: Color(0xff258C29),
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Color(0xffffC82d),width: 2.0)
            )
            ,padding: EdgeInsets.only(
            top:  MediaQuery.of(context).size.height*0.01,
            bottom: MediaQuery.of(context).size.height*0.01,
            left: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.05,
          ),

            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle,color: Color(0xffffC82d),size: 60,),
                Text(Message,style: TextStyle(color:Colors.white),)
              ],
            ),

          ),
        ));
  }
  static   SuccessThenPop(BuildContext context,String Message) {
    Timer(Duration(seconds: 2), (){
      Navigator.pop(context);
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child:  Container(
            width: MediaQuery.of(context).size.width*.4,
            height: 160,
            decoration: BoxDecoration(color: Color(0xff258C29),
                borderRadius: BorderRadius.all(Radius.circular(0)),
                border: Border.all(color: Color(0xffffC82d),width: 2.0)
            )
            ,padding: EdgeInsets.only(
            top:  MediaQuery.of(context).size.height*0.01,
            bottom: MediaQuery.of(context).size.height*0.01,
            left: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.05,
          ),

            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle,color: Color(0xffffC82d),size: 60,),
                Text(Message,style: TextStyle(color:Colors.white),)
              ],
            ),

          ),
        ));
  }

  static   logout(BuildContext context) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, "/HomePage", (route) => false);
  }
}
