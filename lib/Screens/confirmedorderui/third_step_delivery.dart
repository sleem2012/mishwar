import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:mishwar/Screens/shared/button_ui.dart';
import 'package:mishwar/Screens/confirmedorderui/fourth_step_payment.dart';
import 'package:mishwar/Screens/HomePage.dart';
import 'package:mishwar/app/AppConfig.dart';

class ThirdStepDelivery extends StatefulWidget {
  @override
  _ThirdStepDeliveryState createState() => _ThirdStepDeliveryState();
}

class _ThirdStepDeliveryState extends State<ThirdStepDelivery> {
  home h = new home();
  String delevery;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                  DemoLocalizations.of(context).title['followupwiththeorder'],
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.025,
                    right: MediaQuery.of(context).size.width * 0.025),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                                DemoLocalizations.of(context).title['username'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(DemoLocalizations.of(context).title['address'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(
                                Icons.local_shipping_rounded,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                                DemoLocalizations.of(context).title['Delivery'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.right),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(
                                Icons.payment,
                                color: Colors.white,
                                size: 20.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(DemoLocalizations.of(context).title['payment'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DottedLine(
                                dashColor: Colors.black87,
                                lineThickness: 2.0,
                                dashGapLength: 1.50,
                                dashRadius: 1.0,
                              ),
                              SizedBox(
                                height: 15.0,
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(DemoLocalizations.of(context).title['confirm'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
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
                height: MediaQuery.of(context).size.height * .02,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.width * .25,
                    child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1000)),
                            border:
                                Border.all(color: Color(h.blueColor), width: 3),
                            color: Colors.white),
                        padding: EdgeInsets.all(15),
                        child: ImageIcon(
                          AssetImage("images/inWay.png"),
                          size: 35,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .0005,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .01,
                        bottom: MediaQuery.of(context).size.height * .01,
                        left: MediaQuery.of(context).size.width * .05,
                        right: MediaQuery.of(context).size.width * .05),

                    alignment: Alignment.center,
                    //Deliverymethod
                    child: Text(
                      DemoLocalizations.of(context).title['Deliverymethod'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .9,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            color: Colors.black12.withOpacity(.1), width: 1),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * .02,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, GlobalFunction.route(PaymentMethod()));
                              setState(() {
                                delevery = "delivery1";
                              });
                              appConfig.prefs.setString('delmethodtext', DemoLocalizations.of(context)
                                  .title['Receiptfromthebranch']);
                              appConfig.prefs.setString('delcost', '0');
                              appConfig.prefs.setInt('delmethodvalue', 1);
                            },
                            child: Container(
                                height: 30,
                                // color: Colors.red,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      activeColor: Color(h.mainColor),
                                      value: "delivery1",
                                      groupValue: delevery,
                                      onChanged: (String value) {
                                        setState(() {
                                          delevery = value;
                                        });
                                        appConfig.prefs.setString('delmethodtext', DemoLocalizations.of(context)
                                            .title['Receiptfromthebranch']);
                                        appConfig.prefs.setString('delcost', '0');
                                        appConfig.prefs.setInt('delmethodvalue', 1);
                                      },
                                      //Receiptfromthebranch
                                    ),
                                    Text(
                                        DemoLocalizations.of(context)
                                            .title['Receiptfromthebranch'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            height: 1,
                                            color: Colors.black,
                                            fontSize: 12)),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Divider(
                            color: Colors.black12.withOpacity(.1),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(context, GlobalFunction.route(SearchLocation()));
                              setState(() {
                                delevery = "delivery2";
                              });
                              appConfig.prefs.setString('delmethodtext', DemoLocalizations.of(context)
                                  .title['Deliveryfromthebranch']);
                              appConfig.prefs.setInt('delmethodvalue', 2);
                              appConfig.prefs.setString('delcost', '0');

                            },
                            child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Radio(
                                      activeColor: Color(h.mainColor),
                                      value: "delivery2",
                                      groupValue: delevery,
                                      onChanged: (String value) {
                                        setState(() {
                                          delevery = value;
                                        });
                                        appConfig.prefs.setString('delmethodtext', DemoLocalizations.of(context)
                                            .title['Deliveryfromthebranch']);
                                        appConfig.prefs.setInt('delmethodvalue', 2);
                                        appConfig.prefs.setString('delcost', '0');

                                      },
                                    ),
                                    Text(
                                        DemoLocalizations.of(context)
                                            .title['Deliveryfromthebranch'],
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      )),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 0.0,
                ),
              ),
              ButtonUi(
                widget: Text(
                  DemoLocalizations.of(context).title['next'],
                  style: TextStyle(color: Colors.white),
                ),
                backColor: Theme.of(context).accentColor,
                function: () {
                  if (delevery == null) {
                    Toast.show(
                        //Pleasechooseadeliverymethod
                        DemoLocalizations.of(context)
                            .title['Pleasechooseadeliverymethod'],
                        context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            FourthStepPayment(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  }
                },
                doubleValue: MediaQuery.of(context).size.width - 20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
