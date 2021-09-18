import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mishwar/app/Services/OrderServices.dart';
import 'package:mishwar/main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../dbHelper.dart';
import '../GlobalFunction.dart';
import 'package:geolocation/geolocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/HomeDeliveryOrderModel.dart';
import 'DeliveryOrderHomeDetails.dart';
import 'package:mishwar/lang/app_Localization.dart';

class DeleveryMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<DeleveryMainPage> {
  DbHelper dbHelper = new DbHelper();
  TextEditingController message = new TextEditingController();
  home h = new home();
  List<HomeDeliveryOrderDetail> orders;
  OrderServices orderServices = new OrderServices();
  bool loadedData=true;

  loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    orders = await orderServices.GetDeliveryHome(
        sharedPreferences.getString("driver_id"));
    print(sharedPreferences.getString("driver_id"));
    loadedData=false;
    print(orders.length);
    print("ssssssssssssssssssssssssssssssssssssssssssssssssss");
    setState(() {});
  }

  var i = 0;
  String SelectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        confirmCloseApp(context);
        return true;
      },
      child: Expanded(
        // color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .28,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "images/1599519080-mishwar menus.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * .75,
                  top: MediaQuery.of(context).size.height * .175,
                  child: GestureDetector(
                    onTap: () {
                      _makingPhoneCall();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Color(0xff55b866)),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * .35,
                  top: MediaQuery.of(context).size.height * .125,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .14,
                    width: MediaQuery.of(context).size.width * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // border: Border.all(color: Colors.white,width: 1),
                      color: Color.fromRGBO(255, 255, 255, 0.67),
                      //color:Color(0xffffffab).withOpacity(.02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.05),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .15 - 10,
                        width: MediaQuery.of(context).size.width * .3 - 10,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // border: Border.all(color: Colors.black12.withOpacity(.05),width: 5),
                            color: Colors.white),
                        child: Image.asset("images/logo.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            loadedData
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : orders.length > 0
                    ? Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .0,
                                bottom:
                                    MediaQuery.of(context).size.height * .04),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      GlobalFunction.route(
                                          DeliveryOrderHomeDetails(
                                              orders[index])));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .01,
                                    right:
                                        MediaQuery.of(context).size.width * .05,
                                    left:
                                        MediaQuery.of(context).size.width * .05,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        color: Colors.black12.withOpacity(.08),
                                        width: 1),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12.withOpacity(0.03),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.only(
                                              right: 10,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .015,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .01,
                                              left: 0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        "images/logo.png",
                                                        //width:  MediaQuery.of(context).size.width*.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .12,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            //requestnumber
                                                            Text(
                                                              DemoLocalizations.of(
                                                                              context)
                                                                          .title[
                                                                      'requestnumber']+' ' +
                                                                  orders[index]
                                                                      .orderNumber,
                                                              style: TextStyle(
                                                                  height: 1.5,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(h
                                                                      .mainColor)),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            //numberofproducts
                                                            Text(
                                                                DemoLocalizations.of(
                                                                    context)
                                                                    .title[
                                                                'numberofproducts']+"  ${orders[index].allQuantity}",
                                                                style: TextStyle(
                                                                    height: 1.5,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      .64 -
                                                                  10,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    DemoLocalizations.of(context)
                                                                        .title['Total']
                                                                        +' '+"${double.parse(orders[index].totalValue).toStringAsFixed(2)} "+DemoLocalizations.of(context)
                                                                        .title['currency']
                                                                    ,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "${orders[index].orderStatusName}",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Color(h.mainColor)),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                /* Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                  ],
                                ),
                                   Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [



                                    ],),
                                  ),*/
                                                /* Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(" الاجمالي  ${orders[index].totalValue}"),
                                    ],
                                  )*/
                                                /*  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Container(
                                    width:MediaQuery.of(context).size.width*.9,
                                    padding: EdgeInsets.only(

                                      top: MediaQuery.of(context).size.height*.01,
                                      // bottom: MediaQuery.of(context).size.height*.01,

                                    ),
                                    child: ListView.builder(
                                        itemCount: orders[index].orderDetails.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder: (context,i){
                                          return Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.85,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                       child:FadeInImage.assetNetwork(
                                                          placeholder: "images/prodcut4.png",
                                                          image:orders[index].orderDetails[i].image==null?"":orders[index].orderDetails[i].image,
                                                          height: MediaQuery.of(context).size.height*.06,
                                                          width:  MediaQuery.of(context).size.height*.07,
                                                          fit: BoxFit.cover,
                                                          ),
                                                      ),
                                                        SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                           Text(orders[index].orderDetails[i].name,style: TextStyle(fontSize: 12,color: Colors.black54)),
                                                         Text("${orders[index].orderDetails[i].price2} ريال ",style: TextStyle(fontSize: 12,color: Color(h.mainColor),),)
                                                       ],
                                                      )

                                                      ],
                                                    ),
                                                    */ /*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*/ /*
                                                   Row(
                                                     children: [
                                                       Icon(Icons.clear,size: 17,color: Colors.black54),
                                                        SizedBox(width: 2),
                                                       Text("${orders[index].orderDetails[i].details.quantity}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                                                       SizedBox(width: 10),
                                                       Icon(Icons.arrow_back_ios_outlined,color: Colors.black54,size: 16,)

                                                     ],
                                                   )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                             Container(
                                              color: Colors.black12,
                                               width: MediaQuery.of(context).size.width*.85,
                                               height: 1,
                                             ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                              i==orders[index].orderDetails.length-1?Column(
                                                children: [
                                                 // Divider(color: Colors.black38,thickness: 1,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*.8,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("أجمالي الطلب",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                        */ /*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*/ /*
                                                        Text("${orders[index].totalValue} ريال",style: TextStyle(fontSize: 12,color: Color(h.mainColor),fontWeight: FontWeight.bold),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ):SizedBox()
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.005,),*/
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                                /*Container(
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*.01,right:  MediaQuery.of(context).size.width*.05,left:  MediaQuery.of(context).size.width*.05,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black12.withOpacity(.08),width: 1),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.03),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width*.05,
                              top: MediaQuery.of(context).size.height*.015,
                              bottom: MediaQuery.of(context).size.height*.01,
                              left: MediaQuery.of(context).size.width*.05,
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(" طلب رقم "+orders[index].orderNumber,style: TextStyle(height: .8,fontSize: 16,fontWeight: FontWeight.bold,color: Color(h.mainColor)),),

                                      Text(" الاجمالي  ${orders[index].totalValue}")
                                    ],),
                                ),
                                */ /*  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                  Container(
                                    width:MediaQuery.of(context).size.width*.9,
                                    padding: EdgeInsets.only(

                                      top: MediaQuery.of(context).size.height*.01,
                                      // bottom: MediaQuery.of(context).size.height*.01,

                                    ),
                                    child: ListView.builder(
                                        itemCount: orders[index].orderDetails.length,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemBuilder: (context,i){
                                          return Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width*.85,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                                       child:FadeInImage.assetNetwork(
                                                          placeholder: "images/prodcut4.png",
                                                          image:orders[index].orderDetails[i].image==null?"":orders[index].orderDetails[i].image,
                                                          height: MediaQuery.of(context).size.height*.06,
                                                          width:  MediaQuery.of(context).size.height*.07,
                                                          fit: BoxFit.cover,
                                                          ),
                                                      ),
                                                        SizedBox(width: 10,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                           Text(orders[index].orderDetails[i].name,style: TextStyle(fontSize: 12,color: Colors.black54)),
                                                         Text("${orders[index].orderDetails[i].price2} ريال ",style: TextStyle(fontSize: 12,color: Color(h.mainColor),),)
                                                       ],
                                                      )

                                                      ],
                                                    ),
                                                    */ /**/ /*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*/ /**/ /*
                                                   Row(
                                                     children: [
                                                       Icon(Icons.clear,size: 17,color: Colors.black54),
                                                        SizedBox(width: 2),
                                                       Text("${orders[index].orderDetails[i].details.quantity}",style: TextStyle(fontSize: 12,color: Colors.black54),),
                                                       SizedBox(width: 10),
                                                       Icon(Icons.arrow_back_ios_outlined,color: Colors.black54,size: 16,)

                                                     ],
                                                   )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                             Container(
                                              color: Colors.black12,
                                               width: MediaQuery.of(context).size.width*.85,
                                               height: 1,
                                             ),
                                              SizedBox(height: MediaQuery.of(context).size.height*.01,),
                                              i==orders[index].orderDetails.length-1?Column(
                                                children: [
                                                 // Divider(color: Colors.black38,thickness: 1,),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*.8,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("أجمالي الطلب",style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),),
                                                        */ /**/ /*   Row(
                                                      children: [
                                                        Icon(Icons.delete,size: 17,color: Colors.black54),
                                                        SizedBox(width: 5,),
                                                        Icon(Icons.edit_rounded,size: 17,color: Colors.black54),
                                                      ],
                                                    ),*/ /**/ /*
                                                        Text("${orders[index].totalValue} ريال",style: TextStyle(fontSize: 12,color: Color(h.mainColor),fontWeight: FontWeight.bold),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ):SizedBox()
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*.005,),*/ /*
                              ],)
                        ),
                      ],
                    ),

                  ),
                  )*/
                                ,
                              );
                            }))
                    : Expanded(
                        child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .1),
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/orders.png",
                                    color: Colors.black26,
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .035,
                                  ),
                                  Text(
                                    DemoLocalizations.of(context)
                                        .title['nologdata']
                                    ,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black26),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .035,
                                  ),
                                ],
                              ),
                            )),
                      )
          ],
        ),
      ),
    );
  }

  _makingPhoneCall() async {
    const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  confirmCloseApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 130.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    border: Border.all(color: Colors.black12, width: 2.0),
                    color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  DemoLocalizations.of(context)
                                      .title['logoutdescription']
                                  ,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                // Text("${title}",textAlign: TextAlign.center,)
                              ],
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.black38, width: 1.0),
                                      color: Colors.white),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .title['cancell']
                                    ,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(h.mainColor)),
                                  height:
                                      MediaQuery.of(context).size.height * .045,
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  alignment: Alignment.center,
                                  child: Text(
                                    DemoLocalizations.of(context)
                                        .title['confirm']
                                    ,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                                onTap: () async {
                                  SystemNavigator.pop();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  double currentlatitude;

  double currentlongitude;

  _getCurrentLocation() async {
    Geolocation.enableLocationServices().then((result) {}).catchError((e) {
      // Location Services Enablind Cancelled
      print(e);
      print("44444444444444444444");
    });

    Geolocation.currentLocation(accuracy: LocationAccuracy.best)
        .listen((result) {
      if (result.isSuccessful) {
        setState(() {
          currentlatitude = result.location.latitude;
          currentlongitude = result.location.longitude;
        });
      }
    });
    print(currentlatitude);
    print(currentlongitude);
    print("+++++++++++++++++++++++++++++++++++++");
    /*  _addMarker(
      LatLng(currentlatitude, currentlatitude),
      "Your Location",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );*/
    setState(() {});
  }
}
