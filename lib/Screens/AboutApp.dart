import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Screens/myDrawer.dart';
import 'package:mishwar/app/Services/ConfigServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
 import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'CustomAppBar.dart';

class AboutApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return _state();
  }
}
class _state extends State <AboutApp>{
   home h=new home();
  ConfigServices configServices=new ConfigServices();
  Map<String,dynamic>data;
  loadData()async{
    data=await configServices.AboutAppServices();
    setState(() {
    });
    print(data);
    print("ssssssssssssssssss");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(automaticallyImplyLeading: false,elevation: 0.0,
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
                .title['aboutApp'],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,),
          ),
        ],
      ),),
      body: Container(width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(height: MediaQuery.of(context).size.height*.03),
                 Expanded(child: SingleChildScrollView(
                   child: Column(children: [
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
                     data==null? Container(
                       height: MediaQuery.of(context).size.height*5,
                       child: Center(
                         child: CircularProgressIndicator(),
                       ),
                     ):Column(
                       children: [
                         Container(
                           padding: EdgeInsets.only(
                               left: MediaQuery.of(context).size.width*.05,
                               right: MediaQuery.of(context).size.width*.05,
                               top: MediaQuery.of(context).size.height*.02,
                               bottom: MediaQuery.of(context).size.height*.01
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.location_on,color: Color(h.mainColor),size: 17,),
                                   SizedBox(width: 7,),
                                   Text(data["Message"]["address"],style: TextStyle(fontSize: 12,color: Colors.black54),)
                                 ],
                               ),
                               SizedBox(height:5 ,),
                               Row(
                                 children: [
                                   Icon(Icons.markunread,color: Color(h.mainColor),size: 17,),
                                   SizedBox(width: 7,),
                                   Text(data["Message"]["email"],style: TextStyle(fontSize: 12,color: Colors.black54),)
                                 ],
                               ),
                               SizedBox(height:7 ,),
                               Row(
                                 children: [
                                   Icon(Icons.phone,color: Color(h.mainColor),size: 17,),
                                   SizedBox(width: 7,),
                                   Text(data["Message"]["phone"],style: TextStyle(fontSize: 12,color: Colors.black54),)
                                 ],
                               )
                             ],
                           ),
                         ),
                         Container(
                           width: MediaQuery.of(context).size.width,
                           alignment: Alignment.center,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               GestureDetector(
                                   onTap: (){
                                     ShareUrl(data["Message"]["twitter"]);
                                   },
                                   child: ImageIcon(AssetImage("images/icon/twitter.png"),size: 35,)),
                               SizedBox(width: 10,),
                               GestureDetector(
                                 onTap: (){
                                   ShareUrl(data["Message"]["whatsapp"]);
                                 },
                                 child:ImageIcon(AssetImage("images/icon/whats.png"),size: 35,),),
                               SizedBox(width: 10,),
                               GestureDetector(
                                   onTap: (){
                                     ShareUrl(data["Message"]["instagram"]);
                                   },child: ImageIcon(AssetImage("images/icon/inst.png"),size: 35,)),
                               SizedBox(width: 10,),
                               GestureDetector(
                                   onTap: (){
                                     ShareUrl(data["Message"]["snapchat"]);
                                   },
                                   child: ImageIcon(AssetImage("images/icon/snap.png"),size: 35,)),
                               SizedBox(width: 10,),
                               GestureDetector(
                                   onTap: (){
                                     ShareUrl(data["Message"]["facebook"]);
                                   },
                                   child: ImageIcon(AssetImage("images/icon/face.png"),size: 35,)),
                             ],
                           ),
                         ),
                         SizedBox(height:  MediaQuery.of(context).size.height*.01,),
                         Container(
                           width: MediaQuery.of(context).size.width*.9,
                           height: 1,
                           color: Colors.black12,
                         ),
                         Container(
                           padding: EdgeInsets.only(
                               left: MediaQuery.of(context).size.width*.05,
                               right: MediaQuery.of(context).size.width*.05,
                               top: MediaQuery.of(context).size.height*.02,
                               bottom: MediaQuery.of(context).size.height*.02
                           ),
                           child: Text(data["Message"]["text"],
                             style: TextStyle(fontSize: 12,color: Colors.black54),textAlign: TextAlign.center,
                           ),
                         ),
                       ],
                     )
                   ],),
                 ),)


                   /* Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width*.05,
                          right: MediaQuery.of(context).size.width*.05,
                          top: MediaQuery.of(context).size.height*.05,
                          bottom: MediaQuery.of(context).size.height*.1
                      ),
                     width:MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              color: Color(h.mainColor),
                              strokeWidth: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.4,
                                  height: MediaQuery.of(context).size.height*.06,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //  border: Border.all(width: 1.0,color: Colors.black26)
                                  ),
                                  child: Text("دخـول",style: TextStyle(fontSize: 12,color: Color(h.mainColor)),),
                                ),
                              )

                          ),
                          GestureDetector(
                            child: Container(
                              width: MediaQuery.of(context).size.width*.4,
                              height: MediaQuery.of(context).size.height*.06+3,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(h.blueColor)
                                //  border: Border.all(width: 1.0,color: Colors.black26)
                              ),
                              child: Text("اشتراك",style: TextStyle(fontSize: 12,color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    ),*/
                  ],
                ),


      ),


    ));
  }
  ShareUrl(String url)async{
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }
}