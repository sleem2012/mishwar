import 'package:flutter/cupertino.dart';
import 'package:mishwar/Screens/LanguageUi.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
 import '../main.dart';

class Splash extends StatefulWidget{
  static void RefreshUser(){

  }
  @override
  State<StatefulWidget> createState() {
    return splashState();
  }
}
class  splashState extends State<Splash>{
var first;
home h=new home();
Map<String,dynamic>data;
UserServices userServices =new UserServices();
String userType='';
 loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    !prefs.containsKey("UserId")==null?print(""):data=await userServices.getUserData(prefs.getString("UserId"));
    setState(() {
      home.userImag=data["Message"]["image"];
      home.phone=data["Message"]["phone"];
      home.username=data["Message"]["name"];
      home.email=data["Message"]["email"];
      userType=prefs.getString("UserType");
    });
    setState(() {
      first=prefs.getString("first");
    });
    print('${userType},,,,,,,,userType');
    print("_________________________________________________________________________________________________");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
  Timer(Duration(seconds: 3), (){
    print('${appConfig.prefs.getString('chooselang')},,,,datatata');
    if(appConfig.prefs.getString('chooselang')=='yes')
      { Navigator.of(context)
          .pushNamedAndRemoveUntil(
          '/slider'
           ,(Route<dynamic> route) => false);}
    else if(appConfig.prefs.containsKey('chooselang'))
      {
        if(userType=="2")
          {        Navigator.of(context)
              .pushNamedAndRemoveUntil(
              '/DeleverMain'
              //userType=="2"?"/DeleverMain":"/mainPage", DeleverMain mainPage
              ,(Route<dynamic> route) => false);}
        else
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/mainPage'
                //userType=="2"?"/DeleverMain":"/mainPage",
                ,(Route<dynamic> route) => false);
          }
      }

//    else if(appConfig.prefs.getString('chooselang')=='first' &&userType=="1" )
//      {
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil(
//             '/mainPage'
//            //userType=="2"?"/DeleverMain":"/mainPage",
//            ,(Route<dynamic> route) => false);
//      }else if(appConfig.prefs.getString('chooselang')=='first' &&userType=="2" )
//        {
//          Navigator.of(context)
//              .pushNamedAndRemoveUntil(
//              '/DeleverMain'
//              //userType=="2"?"/DeleverMain":"/mainPage",
//              ,(Route<dynamic> route) => false);
//        }
    else
      {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(
            '/LanguageUi'
            //userType=="2"?"/DeleverMain":"/mainPage",
            ,(Route<dynamic> route) => false);
      }


    });

    return Container(
      decoration: new BoxDecoration(
      /*  image: new DecorationImage(
          image: new ExactAssetImage('images/Splash.png'),
          fit: BoxFit.cover,
        ),*/
        color: Color(h.mainColor)
      ),
     child: Column(
       children: [
         SizedBox(height: MediaQuery.of(context).size.height*.35),
         Image.asset("images/logo.png",height: MediaQuery.of(context).size.height*.25,),
         Expanded(child: SizedBox()),

         Text("من فضلك انتظر تحميل التطبيق",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 13,color: Colors.white),),
         SizedBox(height: 3,),
        Text("Please Waite For Application Loading",style: TextStyle(fontFamily: "mishwarfont",decoration: TextDecoration.none,fontSize: 13,color: Colors.white),),
SizedBox(height: MediaQuery.of(context).size.height*.1,)
       ],
     )
    );
  }
}