import 'package:dotted_border/dotted_border.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Screens/AboutApp.dart';
import 'package:mishwar/Screens/sidemenuui/branch_side_menu_ui.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mishwar/Screens/ContactUs.dart';
import 'package:mishwar/Screens/Orders.dart';
import 'package:mishwar/Screens/Polices.dart';
import 'package:mishwar/Screens/login.dart';
import 'package:mishwar/Screens/sidemenuui/favorite_side_menu_ui.dart';
import 'package:mishwar/app/AppConfig.dart';
import 'package:mishwar/app/Services/UserServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditProfile.dart';
import '../main.dart';
import 'Addreses.dart';
import 'GlobalFunction.dart';
import 'package:mishwar/Screens/HomePage.dart';
import 'package:mishwar/Screens/sidemenuui/cart_side_menu_ui.dart';
 import 'Register.dart';
import 'package:mishwar/Screens/sidemenuui/offers_side_menu_ui.dart';
import 'Condition.dart';

class MyDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<MyDrawer> {


  home h = new home();

  UserServices userServices = new UserServices();
  Map<String, dynamic> data;

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("UserId") == null
        ? print("")
        : data = await userServices.getUserData(prefs.getString("UserId"));
    setState(() {});
    print(home.userImag);
    print("000000000000000000000000000000000000000000");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePage.UserId == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
            Container(
              width: MediaQuery.of(context).size.width * .85,
              alignment: Alignment.center,
              child: Image.asset("images/logo.png",
                  height: HomePage.UserId == null
                      ? MediaQuery.of(context).size.height * .16
                      : MediaQuery.of(context).size.height * .15),
            ),
            HomePage.UserId == null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * .0,
                  ),
            HomePage.UserId != null
                ? home.username == null
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, GlobalFunction.route(EditProfile()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * .04,
                            left: MediaQuery.of(context).size.width * .04,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.black12.withOpacity(.05),
                                width: 1),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.02),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .01,
                              bottom: MediaQuery.of(context).size.height * .01,
                            ),

                            padding: appConfig.cApp.appLocale == Locale("ar")?
                            EdgeInsets.only(left:MediaQuery.of(context).size.width * .03)
                                :EdgeInsets.only(right:MediaQuery.of(context).size.width * .03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .08,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "images/Photo.png",
                                            image: home.userImag == null
                                                ? ""
                                                : home.userImag,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .08,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              textDirection: TextDirection.ltr,
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
                      )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .05,
                        right: MediaQuery.of(context).size.width * .05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                GlobalFunction.routeBottom(login("home")));
                          },
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              color: Color(h.mainColor),
                              strokeWidth: 1.5,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  height:
                                      MediaQuery.of(context).size.height * .05,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    //  border: Border.all(width: 1.0,color: Colors.black26)
                                  ),
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .title['btn_login'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(h.mainColor)),
                                  ),
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                GlobalFunction.routeBottom(Register()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .35,
                            height:
                                MediaQuery.of(context).size.height * .05 + 3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(h.blueColor)
                                //  border: Border.all(width: 1.0,color: Colors.black26)
                                ),
                            child: Text(
                              DemoLocalizations.of(context).title['signUp'],
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(
                top: HomePage.UserId == null
                    ? MediaQuery.of(context).size.height * .02
                    : MediaQuery.of(context).size.height * .01,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                    GestureDetector(
                      onTap: () {
                     Navigator.of(context).pop();
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
                                                .title['main'],
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
                     //go to favorite
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavoriteSideMenu()),
                        );
                        //CartSideMenu
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .03 - 2,
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
                                          child: Icon(Icons.star_outline,
                                              color: Colors.black45, size: 25)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        child: InkWell(
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .title['favorite'],
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
                          context,
                          MaterialPageRoute(builder: (context) => CartSideMenu()),
                        );
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
                                        AssetImage("images/icon/cart_bar.png"),
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
                                                .title['cart'],
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
                          context,
                          MaterialPageRoute(builder: (context) => BranchesSide()),
                        );

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
                                        AssetImage("images/icon/location.png"),
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
                                                .title['branches'],
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
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OffersSideMenu()),
                        );
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
                                        AssetImage("images/offerIcon.png"),
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
                                                .title['Offers'],
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
                    HomePage.UserId == null
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () {



                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Orders()),
                                );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * .03,
                                top: MediaQuery.of(context).size.height * .005,
                                bottom:
                                    MediaQuery.of(context).size.height * .005,
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
                                              AssetImage(
                                                  "images/icon/order.png"),
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
                                                      .title['OrderHistory'],
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
                    HomePage.UserId == null
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () {



                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => Adresses()),
                           );
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * .03,
                                top: MediaQuery.of(context).size.height * .005,
                                bottom:
                                    MediaQuery.of(context).size.height * .005,
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
                                              AssetImage(
                                                  "images/icon/location.png"),
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
                                                      .title['listaddresses'],
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
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: HomePage.UserId == null
                    ? MediaQuery.of(context).size.height * .03
                    : MediaQuery.of(context).size.height * .01,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                    GestureDetector(
                      onTap: () {


                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutApp()),
                        );
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
                                                .title['aboutApp'],
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
                          context,
                          MaterialPageRoute(builder: (context) => Polices()),
                        );

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
                                                .title['policy'],
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
                          context,
                          MaterialPageRoute(builder: (context) => Condition()),
                        );

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
                                                .title['conditions'],
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
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                  top: HomePage.UserId == null
                      ? MediaQuery.of(context).size.height * .03
                      : MediaQuery.of(context).size.height * .01,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),
                        );

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
                                              .title['contact_us'],
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
                    GestureDetector(
                      onTap: () {                                share();
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
                                            child: Icon(Icons.share_outlined,
                                                size: 20,
                                                color: Colors.black45)),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Container(
                                          child: Text(
                                            DemoLocalizations.of(context)
                                                .title['share_app'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
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
                     Container(
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
                                        : Locale('ar'));
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

                    SizedBox(
                      height: MediaQuery.of(context).size.height * .007,
                    ),
                  ],
                )),
            HomePage.UserId != null
                ? Container(
                    margin: EdgeInsets.only(
                      top: HomePage.UserId == null
                          ? MediaQuery.of(context).size.height * .03
                          : MediaQuery.of(context).size.height * .01,
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
                        Navigator.push(
                            context, GlobalFunction.route(HomePage()));
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
                                            "تسجيل الخروج",
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
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
          ],
        ),
      ),
    );
  }

  clearData() async {
  //  appConfig.prefs.remove('chooselang');
    appConfig.prefs.remove("UserId");
    appConfig.prefs.remove('delmethodtext');
    appConfig.prefs.remove('delcost');//delmethodvalue
    appConfig.prefs.remove('delmethodvalue');
    appConfig.prefs.remove('paymethodtext');
    //paymethodvalue
    appConfig.prefs.remove('paymethodvalue');
   }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Mishwar',
        text: 'Mishwar',
        linkUrl:
            'google play   https://play.google.com/store/apps/details?id=com.app.mishwar   apple https://apps.apple.com/us/app/mishwar/id1577637116',
        chooserTitle: 'Example Chooser Title');
  }

  Widget arrowUi() {
    return appConfig.cApp.appLocale == Locale("ar")
        ? Icon(Icons.arrow_back_ios_rounded, size: 15, color: Colors.black45)
        : Icon(Icons.arrow_forward_ios_rounded,
            size: 15, color: Colors.black45);
  }
}
