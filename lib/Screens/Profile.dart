import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/app/Services/UserServices.dart';
 import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profileState();
  }
}

class profileState extends State<profile> {
  home h=new home();
  var UserId;
  UserServices userServices=new UserServices();
  Map<String,dynamic>data;
  loadData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.getString("UserId")==null?print(""):data=await userServices.getUserData(prefs.getString("UserId"));
    setState(() {
      UserId=prefs.getString("UserId");
    });
    print(data);
    print("000000000000000");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff0f0f0),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.08,
                width: MediaQuery.of(context).size.width,
                color: Color(h.mainColor),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width*.04,
                  right: MediaQuery.of(context).size.width*.04,

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.menu,color: Colors.white,),
                    Text("الملف الشخصي",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,)
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.023,right:  MediaQuery.of(context).size.width*.04,left:  MediaQuery.of(context).size.width*.04,),
                child: Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.015,bottom: MediaQuery.of(context).size.height*.015,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("images/Photo.png",width: MediaQuery.of(context).size.width*.27,height: MediaQuery.of(context).size.height*.11,),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  InkWell(
                                    child: Text("شرف محمد",style: TextStyle(fontSize: 20,),),
                                    onTap: ()=>{ Navigator.pushNamed(context, '/editProfile')},
                                  ),

                                  Text("01000478589",style: TextStyle(fontSize: 12,),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios_outlined,size: 17),
                      ),


                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.03,right:  MediaQuery.of(context).size.width*.04,left:  MediaQuery.of(context).size.width*.04,),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width*.03,
                          top: MediaQuery.of(context).size.height*.01,
                         // bottom: MediaQuery.of(context).size.height*.01,
                          left: MediaQuery.of(context).size.width*.03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04),
                                          child: Icon(Icons.bookmark_outline_rounded,size: 20,color: Colors.black45)),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: InkWell(
                                          child: Text("المفضلة",style: TextStyle(fontSize: 15,color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black45),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width*.03,
                          top: MediaQuery.of(context).size.height*.01,
                          bottom: MediaQuery.of(context).size.height*.01,
                          left: MediaQuery.of(context).size.width*.03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04),
                                          child: Icon(Icons.access_time,size: 20,color: Colors.black45)),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: InkWell(
                                          child: Text("سجل الطلبات",style: TextStyle(fontSize: 15,color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black45),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width*.03,
                         // top: MediaQuery.of(context).size.height*.01,
                          bottom: MediaQuery.of(context).size.height*.01,
                          left: MediaQuery.of(context).size.width*.03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04),
                                          child:ImageIcon(AssetImage("images/control.png"),size: 20,color: Colors.black45,)),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: InkWell(
                                          child: Text("لوحة التحكم",style: TextStyle(fontSize: 15,color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black45),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.03,right:  MediaQuery.of(context).size.width*.04,left:  MediaQuery.of(context).size.width*.04,),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width*.03,
                          top: MediaQuery.of(context).size.height*.01,
                          bottom: MediaQuery.of(context).size.height*.01,
                          left: MediaQuery.of(context).size.width*.03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04),
                                          child: ImageIcon(AssetImage("images/setting.png"),size: 25,color: Colors.black45,)),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: InkWell(
                                          child: Text("الاعدادات",style: TextStyle(fontSize: 15,color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black45),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width*.03,
                          //top: MediaQuery.of(context).size.height*.01,
                          bottom: MediaQuery.of(context).size.height*.01,
                          left: MediaQuery.of(context).size.width*.03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04),
                                          child: ImageIcon(AssetImage("images/contact.png"),size: 20,color: Colors.black45,)),
                                      SizedBox(width: 10,),
                                      Container(
                                        child: InkWell(
                                          child: Text("تواصل معنا",style: TextStyle(fontSize: 15,color: Colors.black),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black45),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*.03,top:MediaQuery.of(context).size.height*.03,right:  MediaQuery.of(context).size.width*.04,left:  MediaQuery.of(context).size.width*.04,),
                child: Container(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width*.03,
                    top: MediaQuery.of(context).size.height*.01,
                    bottom: MediaQuery.of(context).size.height*.01,
                    left: MediaQuery.of(context).size.width*.03,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.04),
                                      child: Icon(Icons.login,size: 20,color: Colors.black45)),
                                  SizedBox(width: 10,),
                                  Container(
                                    child: InkWell(
                                      child: Text("تسجيل الخروج",style: TextStyle(fontSize: 15,color: Colors.black),),
                                    ),
                                  ),
                                ],
                              ),
                            Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.black45),


                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }






}
