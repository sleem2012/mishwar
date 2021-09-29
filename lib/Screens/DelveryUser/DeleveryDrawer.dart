import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Screens/AboutApp.dart';
import 'package:mishwar/Screens/ContactUs.dart';
import 'package:mishwar/Screens/DelveryUser/DeliveryOrders.dart';
import 'package:mishwar/Screens/Polices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../EditProfile.dart';
import '../../main.dart';
import '../GlobalFunction.dart';
import 'package:mishwar/app/AppConfig.dart';
import '../Slider.dart';
import '../Condition.dart';
import 'package:mishwar/lang/app_Localization.dart';

class DeleveryDrawer extends StatefulWidget {
  int index;

  DeleveryDrawer(int index) {
    this.index = index;
  }

  @override
  State<StatefulWidget> createState() {
    return _state(this.index);
  }
}

class _state extends State<DeleveryDrawer> {
  int index;

  _state(int index) {
    this.index = index;
  }

  home h = new home();
  String UserId;

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserId = prefs.getString("UserId");
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
    return  Container(
        width: MediaQuery.of(context).size.width * .85,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              alignment: Alignment.center,
              child: Image.asset("images/logo.png",
                  height: MediaQuery.of(context).size.height * .16),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, GlobalFunction.route(EditProfile()));
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .04,
                  left: MediaQuery.of(context).size.width * .04,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: Colors.black12.withOpacity(.05), width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.02),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(padding: appConfig.cApp.appLocale == Locale("ar")?
    EdgeInsets.only(left:MediaQuery.of(context).size.width * .03)
        :EdgeInsets.only(right:MediaQuery.of(context).size.width * .03),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .015,
                    bottom: MediaQuery.of(context).size.height * .015,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .2,
                              height: MediaQuery.of(context).size.height * .08,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "images/Photo.png",
                                  image: home.userImag == null
                                      ? ""
                                      : home.userImag,
                                  width: MediaQuery.of(context).size.width * .2,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Text(
                                      home.username,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onTap: () => {
                                      Navigator.pushNamed(
                                          context, '/editProfile')
                                    },
                                  ),
                                  Text(
                                    home.phone,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      arrowUi(),
                     ],
                  ),
                ),
              ),
            ),
//            Container(
//              margin: EdgeInsets.only(
//                top: MediaQuery.of(context).size.height * .02,
//                right: MediaQuery.of(context).size.width * .04,
//                left: MediaQuery.of(context).size.width * .04,
//              ),
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.all(Radius.circular(10)),
//                border: Border.all(
//                    color: Colors.black12.withOpacity(.08), width: 1),
//                color: Colors.white,
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.black12.withOpacity(0.03),
//                    spreadRadius: 4,
//                    blurRadius: 4,
//                    offset: Offset(0, 3), // changes position of shadow
//                  ),
//                ],
//              ),
//              child: Container(
//                alignment: Alignment.center,
//                child: Column(
//                  children: [
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * .007,
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                      child: Container(
//                        padding: EdgeInsets.only(
//                          right: MediaQuery.of(context).size.width * .03,
//                          top: MediaQuery.of(context).size.height * .005,
//                          bottom: MediaQuery.of(context).size.height * .005,
//                          left: MediaQuery.of(context).size.width * .03,
//                        ),
//                        child: Column(
//                          children: [
//                            Container(
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Row(
//                                    children: [
//                                      Container(
//                                          child: ImageIcon(
//                                        AssetImage("images/icon/home.png"),
//                                        color: Colors.black45,
//                                        size: 20,
//                                      )),
//                                      SizedBox(
//                                        width: 7,
//                                      ),
//                                      Container(
//                                        child: InkWell(
//                                          child: Text(
//                                            DemoLocalizations.of(context)
//                                                .title['main']
//                                            ,
//                                            style: TextStyle(
//                                                fontSize: 12,
//                                                color: Colors.black),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  arrowUi(),
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.push(context, GlobalFunction.route(DeliveryOrders()));
//
//                      },
//                      child: Container(
//                        padding: EdgeInsets.only(
//                          right: MediaQuery.of(context).size.width * .03,
//                          top: MediaQuery.of(context).size.height * .005,
//                          bottom: MediaQuery.of(context).size.height * .005,
//                          left: MediaQuery.of(context).size.width * .03,
//                        ),
//                        child: Column(
//                          children: [
//                            Container(
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Row(
//                                    children: [
//                                      Container(
//                                          child: ImageIcon(
//                                        AssetImage("images/icon/order.png"),
//                                        color: Colors.black45,
//                                        size: 20,
//                                      )),
//                                      SizedBox(
//                                        width: 7,
//                                      ),
//                                      Container(
//                                        child: InkWell(
//                                          child: Text(
//                                            DemoLocalizations.of(context)
//                                                .title['orderbook']
//                                            ,
//                                            style: TextStyle(
//                                                fontSize: 12,
//                                                color: Colors.black),
//                                          ),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                 arrowUi(),
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                    SizedBox(
//                      height: MediaQuery.of(context).size.height * .007,
//                    ),
//                  ],
//                ),
//              ),
//            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .03,
                right: MediaQuery.of(context).size.width * .04,
                left: MediaQuery.of(context).size.width * .04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: Colors.black12.withOpacity(.08), width: 1),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.03),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .005,
                          bottom: MediaQuery.of(context).size.height * .005,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: ImageIcon(
                                            AssetImage("images/icon/home.png"),
                                            color: Colors.black45,
                                            size: 20,
                                          )),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .title['main']
                                            ,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  arrowUi(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                    GestureDetector(
                      onTap: () {
                        this.index == 5
                            ? print("s")
                            : Navigator.push(
                                context, GlobalFunction.route(AboutApp()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .005,
                          bottom: MediaQuery.of(context).size.height * .005,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: ImageIcon(
                                        AssetImage("images/icon/about.png"),
                                        size: 20,
                                        color: Colors.black45,
                                      )),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .title['aboutApp']
                                            ,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  arrowUi(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                                context, GlobalFunction.route(Polices()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .005,
                          bottom: MediaQuery.of(context).size.height * .005,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: ImageIcon(
                                        AssetImage("images/icon/polices.png"),
                                        size: 20,
                                        color: Colors.black45,
                                      )),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: Text(
                                            //policy
                                            DemoLocalizations.of(context)
                                                .title['policy']
                                            ,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  arrowUi(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context, GlobalFunction.route(Condition()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .005,
                          bottom: MediaQuery.of(context).size.height * .005,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: ImageIcon(
                                        AssetImage("images/icon/polices.png"),
                                        size: 20,
                                        color: Colors.black45,
                                      )),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .title['conditions']
                                            ,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  arrowUi()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                                context, GlobalFunction.route(ContactUs()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .005,
                          bottom: MediaQuery.of(context).size.height * .005,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: ImageIcon(
                                        AssetImage("images/icon/contact.png"),
                                        size: 20,
                                        color: Colors.black45,
                                      )),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: Text(
                                          DemoLocalizations.of(context)
                                              .title['contact_us']
                                          ,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                 arrowUi(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .005,
                          bottom: MediaQuery.of(context).size.height * .005,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                appConfig.cApp.changeLanguage(
                                    appConfig.prefs.getString('lang') == 'ar'
                                        ? Locale('en')
                                        : Locale('ar'),context);
                                print('${appConfig.cApp.appLocale},,,,,from inial');
                                print('${appConfig.prefs.getString('lang')},,,,,from shared pref');
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            child: Icon(Icons.settings,
                                                size: 20,
                                                color: Colors.black45)),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          DemoLocalizations.of(context)
                                              .title['lang'],
                                        ),
                                      ],
                                    ),
                                    arrowUi()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                  ],
                ),
              ),
            ),
            UserId != null
                ? Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .03,
                      right: MediaQuery.of(context).size.width * .04,
                      left: MediaQuery.of(context).size.width * .04,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color: Colors.black12.withOpacity(.08), width: 1),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.03),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        clearData();
                        Navigator.push(context, GlobalFunction.route(slider()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03,
                          top: MediaQuery.of(context).size.height * .01,
                          bottom: MediaQuery.of(context).size.height * .01,
                          left: MediaQuery.of(context).size.width * .03,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          child: Icon(Icons.login,
                                              size: 20, color: Colors.black45)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .title['logout']
                                            ,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                arrowUi(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),

          ],
        ),
      )
     ;
  }

  clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("UserId");
  }

  Widget arrowUi() {
    return appConfig.cApp.appLocale == Locale("ar")
        ? Icon(Icons.arrow_back_ios_rounded, size: 15, color: Colors.black45)
        : Icon(Icons.arrow_forward_ios_rounded,
        size: 15, color: Colors.black45);
  }
}
