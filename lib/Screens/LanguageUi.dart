import 'package:flutter/material.dart';
import 'package:mishwar/Screens/HomePage.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';

import 'CustomText.dart';

// ignore: must_be_immutable
class LanguageUi extends StatelessWidget {
  home h=new home();

  @override
  Widget build(BuildContext context) {
     return SafeArea(
        child: Scaffold(backgroundColor: Colors.white,
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/logo.png",
            height: MediaQuery.of(context).size.height*.25,
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
          Center(
            child: GestureDetector(
              onTap: ()async{

                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/slider'
                    //userType=="2"?"/DeleverMain":"/mainPage",
                    ,(Route<dynamic> route) => false);
                appConfig.cApp.changeLanguage(Locale('ar'),context);
                appConfig.prefs.setString('chooselang', 'yes');

              },
              child: Container(
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(h.mainColor)
                ),
                height: MediaQuery.of(context).size.height*.065,
                width: MediaQuery.of(context).size.width*.8,
                alignment: Alignment.center,
                child:CustomText.BtnText(DemoLocalizations.of(context).title['language_arabic']),

              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.025,),
          Center(
            child: GestureDetector(
              onTap: ()async{
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                    '/slider'
                    //userType=="2"?"/DeleverMain":"/mainPage",
                    ,(Route<dynamic> route) => false);
                appConfig.cApp.changeLanguage(Locale('en'),context);
                appConfig.prefs.setString('chooselang', 'yes');

              },
              child: Container(
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(h.mainColor)
                ),
                height: MediaQuery.of(context).size.height*.065,
                width: MediaQuery.of(context).size.width*.8,
                alignment: Alignment.center,
                child:CustomText.BtnText(DemoLocalizations.of(context).title['language_english']),

              ),
            ),
          ),
        ],
      ),
    ));
  }
}
