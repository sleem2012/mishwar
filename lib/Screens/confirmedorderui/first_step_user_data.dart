import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:mishwar/Screens/mainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mishwar/Screens/shared/button_ui.dart';
import 'package:mishwar/Screens/confirmedorderui/second_step_address.dart';
import 'package:mishwar/Screens/HomePage.dart';

class FirstStepUserData extends StatefulWidget {
  @override
  _FirstStepUserDataState createState() => _FirstStepUserDataState();
}

class _FirstStepUserDataState extends State<FirstStepUserData> {
  home h = new home();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);

      return true;
    },

      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Color(0xffD4252F),
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: DemoLocalizations.of(context).locale == Locale("en")
                      ? Icon(Icons.arrow_back_ios_rounded,
                          size: 25, color: Colors.white)
                      : Icon(Icons.arrow_forward_ios_rounded,
                          size: 25, color: Colors.white)),
              Expanded(
                child: Text(
                  DemoLocalizations.of(context)
                      .title['followupwiththeorder'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.width * 0.05
          ),
          child: Column(
            children: [
               Container(
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05,
                bottom: MediaQuery.of(context).size.width * 0.05,
                left: MediaQuery.of(context).size.width * 0.025,
                right: MediaQuery.of(context).size.width * 0.025),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: Icon(Icons.person,color: Colors.white,
                              size: 25.0,),width: 40.0,height: 40.0,decoration: BoxDecoration(
                                color:Theme.of(context).primaryColor,shape:BoxShape.circle),),
                            SizedBox(height: 5.0,),
                            Text(DemoLocalizations.of(context)
                                .title['username']
                                ,
                                style: Theme.of(context).textTheme.headline2.copyWith(fontSize:11.0,
                                    fontWeight: FontWeight.w600,color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,lineThickness: 2.0 ,
                                dashGapLength: 1.50,dashRadius:1.0,
                              ),
                              SizedBox(height:15.0,)
                            ],
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: Icon(FontAwesomeIcons.mapMarkerAlt,color: Colors.white,
                              size: 20,),width:40.0,height: 40.0,decoration: BoxDecoration(
                                color:Colors.grey,shape:BoxShape.circle),),    SizedBox(height: 5.0,),
                            Text(DemoLocalizations.of(context)
                                .title['address'],
                                style: Theme.of(context).textTheme.headline2.copyWith(fontSize:11.0,
                                    fontWeight: FontWeight.w600,color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,lineThickness: 2.0 ,
                                dashGapLength: 1.50,dashRadius:1.0,
                              ),
                              SizedBox(height:15.0,)
                            ],
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: Icon(Icons.local_shipping_rounded,color: Colors.white,
                              size: 20.0,),width: 40.0,height: 40.0,decoration: BoxDecoration(
                                color:Colors.grey,shape:BoxShape.circle),),    SizedBox(height: 5.0,),
                            Text(DemoLocalizations.of(context)
                                .title['Delivery'],
                                style:Theme.of(context).textTheme.headline2.copyWith(fontSize:11.0,
                                    fontWeight: FontWeight.w600,color: Colors.black),
                                textAlign: TextAlign.right),
                          ],
                        ),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,lineThickness: 2.0 ,
                                dashGapLength: 1.50,dashRadius:1.0,
                              ),
                              SizedBox(height:15.0,)
                            ],
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: Icon(Icons.payment,color: Colors.white,
                              size: 20.0,),width: 40.0,height: 40.0,decoration: BoxDecoration(
                                color:Colors.grey,shape:BoxShape.circle),),   SizedBox(height: 5.0,),
                            Text(DemoLocalizations.of(context)
                                .title['payment'],
                                style: Theme.of(context).textTheme.headline2.copyWith(fontSize:11.0,
                                    fontWeight: FontWeight.w600,color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,lineThickness: 2.0 ,
                                dashGapLength: 1.50,dashRadius:1.0,
                              ),
                              SizedBox(height:15.0,)
                            ],
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(child: Icon(Icons.check,color: Colors.white,
                              size: 25.0,),width:40.0,height: 40.0,decoration: BoxDecoration(
                                color:Colors.grey,shape:BoxShape.circle),),    SizedBox(height: 5.0,),
                            Text(DemoLocalizations.of(context)
                                .title['confirm'],
                                style: Theme.of(context).textTheme.headline2.copyWith(fontSize:11.0,
                                    fontWeight: FontWeight.w600,color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.width * .075,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  border: Border.all(color: Color(h.blueColor), width: 3),
                ),
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5000)),
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/Photo.png",
                    image: home.userImag == null ? "" : home.userImag,
                    width: MediaQuery.of(context).size.width * .22,
                    height: MediaQuery.of(context).size.width * .22,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
        SizedBox(
          height: MediaQuery.of(context).size.width * .075,
        ),
              Divider(
                color: Colors.black26,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .065,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.black12.withOpacity(.05), width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.05),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text(
                        DemoLocalizations.of(context)
                            .title['name']
                        ,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(home.username, style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .065,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.black12.withOpacity(.05), width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.05),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text( DemoLocalizations.of(context)
                          .title['phone'], style: TextStyle(fontSize: 12)),
                    ),
                    Text(home.phone,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .065,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.black12.withOpacity(.05), width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.05),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Text(DemoLocalizations.of(context)
                          .title['email'],
                          style: TextStyle(fontSize: 12)),
                    ),
                    Text(home.email, style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 0.0,
                ),
              ),
              ButtonUi(
                widget: Text(
                  DemoLocalizations.of(context).title['next'],
                  style: TextStyle(color: Colors.white),
                ),
                backColor: Theme.of(context).accentColor,
                function: () {
                  //                 Navigator.pushReplacement(
//                     context, MaterialPageRoute(builder: (BuildContext context) => AddressPageStepPageUI()),);

                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          SecondStepAddress(),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                doubleValue: MediaQuery.of(context).size.width -20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
