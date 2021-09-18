import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'package:mishwar/app/Services/ConfigServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
 import '../main.dart';
import 'CustomAppBar.dart';

class Condition extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State <Condition>{
  home h=new home();
  ConfigServices configServices=new ConfigServices();
  Map<String,dynamic>data;
  loadData()async{
    data=await configServices.GetTermsServices();
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
   @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar:  AppBar(automaticallyImplyLeading: false,elevation: 0.0,
      backgroundColor: Color(0xffD4252F),title: Row(
        children: [
          GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:DemoLocalizations.of(context).locale == Locale("en")
                  ? Icon(Icons.arrow_back_ios_rounded, size: 25, color:Colors.white)
                  : Icon(Icons.arrow_forward_ios_rounded,
                  size:25, color:Colors.white)),
          Expanded(
            child: Text(DemoLocalizations.of(context)
                .title['rulesandconditions'],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,),
          ),
        ],
      ),),
       // endDrawer: MyDrawer(6),
      body:  Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(height: MediaQuery.of(context).size.height*.03),
                Container(
                  child: Image.asset("images/logo.png",
                    height: MediaQuery.of(context).size.height*.2,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  height: 1,
                  color: Colors.black12,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02),
                data==null?  Expanded(child: Center(child: CircularProgressIndicator(),),):
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.05,
                          right: MediaQuery.of(context).size.width*.05,
                          top: MediaQuery.of(context).size.height*.025,
                          bottom: MediaQuery.of(context).size.height*.02
                      ),
                      child:Html(data: data["Message"]["text"],  ) /*Text(data["Message"]["text"],
                        style: TextStyle(fontSize: 12,color: Colors.black54),textAlign: TextAlign.center,
                      ),*/
                    ),
                  ),
                ),
              ],
            ),
          ),


    ));
  }
}