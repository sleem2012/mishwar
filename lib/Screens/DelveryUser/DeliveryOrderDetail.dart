import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar/Model/OrderDeliveryModel.dart';
import 'package:mishwar/app/Services/OrderServices.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocation/geolocation.dart';
import '../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mishwar/lang/app_Localization.dart';

import 'dart:math' show cos, sqrt, asin;

class DeliveryOrderDetails extends StatefulWidget {
  DeliveryOrderDetail order;

  DeliveryOrderDetails(DeliveryOrderDetail order) {
    this.order = order;
  }

  @override
  State<StatefulWidget> createState() {
    return _state(this.order);
  }
}

class _state extends State<DeliveryOrderDetails> {
  DeliveryOrderDetail orderdetails;

  _state(DeliveryOrderDetail order) {
    this.orderdetails = order;
  }

  double currentlatitude;

  double currentlongitude;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController reason = new TextEditingController();
  home h = new home();
  OrderServices orderServices = new OrderServices();
  double _originLatitude = 30.55;
  double _originLongitude = 31.183;
  Map<MarkerId, Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  bool startMove = false;

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  var _placeDistance;

  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();

  // Configure map position and zoom
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
        /*double.parse(orderdetails.orderAddress.lat)*/
        30.20,
        30.12 /*double.parse(orderdetails.orderAddress.lat)*/),
    zoom: 9,
  );
  var driver_id;

  loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      driver_id = pref.getString("driver_id");
    });
    if (orderdetails.orderStatusId == "2") {
      _getCurrentLocation();
      _getPolyline(currentlatitude, currentlongitude);
      setState(() {
        _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(orderdetails.orderAddress.lat),
              double.parse(orderdetails.orderAddress.lng)),
          zoom: 9,
        );
      });
      map(markers, _kGooglePlex);
      setState(() {
        startMove = true;
      });
      Timer(Duration(seconds: 1), () {
        _getPolyline(currentlatitude, currentlongitude);
        setState(() {
          _kGooglePlex = CameraPosition(
            target: LatLng(double.parse(orderdetails.orderAddress.lat),
                double.parse(orderdetails.orderAddress.lng)),
            zoom: 9,
          );
        });
        map(markers, _kGooglePlex);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addMarker(
      LatLng(double.parse(orderdetails.orderAddress.lat),
          double.parse(orderdetails.orderAddress.lng)),
      "destination",
      BitmapDescriptor.defaultMarker,
    );
    _getCurrentLocation();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .07,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .07,
                    width: MediaQuery.of(context).size.width,
                    color: Color(h.mainColor),
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05,
                      right: MediaQuery.of(context).size.width * .05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: DemoLocalizations.of(context).locale ==
                                    Locale("en")
                                ? Icon(Icons.arrow_back_ios_rounded,
                                    size: 25, color: Colors.white)
                                : Icon(Icons.arrow_forward_ios_rounded,
                                    size: 25, color: Colors.white)),
                        Expanded(
                          child: Text(
                            DemoLocalizations.of(context)
                                .title['requestdetails'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Color(h.mainColor),
                              size: 25,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                orderdetails.orderStatusId == "1" ||
                        orderdetails.orderStatusId == "7"
                    ? Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (!startMove) {
                                  _getCurrentLocation();
                                  _getPolyline(
                                      currentlatitude, currentlongitude);
                                  setState(() {
                                    startMove = true;
                                    _kGooglePlex = CameraPosition(
                                      target: LatLng(
                                          double.parse(
                                              orderdetails.orderAddress.lat),
                                          double.parse(
                                              orderdetails.orderAddress.lng)),
                                      zoom: 9,
                                    );
                                  });
                                  map(markers, _kGooglePlex);
                                  Map<String, dynamic> responce =
                                      await orderServices.StartOrder(
                                          driver_id, orderdetails.id);
                                  print(responce);
                                  print(
                                      "ssssssssssssssssssssssssssssssssssssssssss");
                                  Timer(Duration(seconds: 1), () {
                                    _getCurrentLocation();
                                    _getPolyline(
                                        currentlatitude, currentlongitude);
                                    setState(() {
                                      _kGooglePlex = CameraPosition(
                                        target: LatLng(
                                            double.parse(
                                                orderdetails.orderAddress.lat),
                                            double.parse(
                                                orderdetails.orderAddress.lng)),
                                        zoom: 9,
                                      );
                                    });
                                    map(markers, _kGooglePlex);
                                  });
                                } else {
                                  endOrder(context);
                                }
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .055,
                                width: MediaQuery.of(context).size.width * .42,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: startMove
                                        ? Color(0xffffc107)
                                        : Color(h.blueColor)),
                                alignment: Alignment.center,
                                //checkout
                                child: Text(
                                  startMove
                                      ? DemoLocalizations.of(context)
                                          .title['checkout']
                                      : DemoLocalizations.of(context)
                                          .title['startorder'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                cancelOrder(context);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .055,
                                width: MediaQuery.of(context).size.width * .42,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(h.mainColor)),
                                alignment: Alignment.center,
                                child: Text(
                                  DemoLocalizations.of(context)
                                      .title['cancell'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                orderdetails.orderStatusId == "1" ||
                        orderdetails.orderStatusId == "7"
                    ? Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .00,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .05,
                                    right: MediaQuery.of(context).size.width *
                                        .05),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Text(
                                        DemoLocalizations.of(context)
                                            .title['customername'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Text(
                                        orderdetails.orderUser.name,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .05,
                                    right: MediaQuery.of(context).size.width *
                                        .05),
                                width: MediaQuery.of(context).size.width * .9,
                                color: Colors.black12,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .05,
                                    right: MediaQuery.of(context).size.width *
                                        .05),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Text(
                                        DemoLocalizations.of(context)
                                            .title['phone'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderdetails.orderUser.phone,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .05,
                                    right: MediaQuery.of(context).size.width *
                                        .05),
                                width: MediaQuery.of(context).size.width * .9,
                                color: Colors.black12,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .05,
                                    right: MediaQuery.of(context).size.width *
                                        .05),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Text(
                                        DemoLocalizations.of(context)
                                            .title['email'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: Text(
                                        orderdetails.orderUser.email,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          DemoLocalizations.of(context).locale ==
                              Locale("en")?  Positioned(
                            right: MediaQuery.of(context).size.width * .07,


                            top: 27.5,
                            child: GestureDetector(
                              onTap: () {
                                _makingPhoneCall();
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    color: Color(0xff55b866)),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ):
                          Positioned(
                            left: MediaQuery.of(context).size.width * .07,


                            top: 27.5,
                            child: GestureDetector(
                              onTap: () {
                                _makingPhoneCall();
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                    color: Color(0xff55b866)),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .005,
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05),
                        width: MediaQuery.of(context).size.width * .9,
                        color: Colors.black12,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            Container(
                                height: startMove
                                    ? MediaQuery.of(context).size.height * .4
                                    : MediaQuery.of(context).size.height * .2,
                                width: MediaQuery.of(context).size.width,
                                child: map(markers, _kGooglePlex)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            _placeDistance != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DemoLocalizations.of(
                                            context)
                                            .title[
                                        'distance']
                                        +" ${_placeDistance} "+DemoLocalizations.of(
                                            context)
                                            .title[
                                        'km']
                                        ,
                                        style: TextStyle(
                                            color: Color(h.blueColor)),
                                      ),
                                      Text(
                                          DemoLocalizations.of(
                                              context)
                                              .title[
                                          'Waitingtime']
                                              +" ${(double.parse(_placeDistance) / 1.5).round()}"+DemoLocalizations.of(
                                              context)
                                              .title[
                                          'minute']
                                          ,
                                          style: TextStyle(
                                              color: Color(h.mainColor)))
                                    ],
                                  )
                                : SizedBox(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderdetails.orderAddress.title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    orderdetails.orderAddress.region,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87.withOpacity(.6)),
                                  ),
                                  Text(
                                    orderdetails.orderAddress.address,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87.withOpacity(.6)),
                                  ),
                                  Text(
                                      DemoLocalizations.of(
                                            context)
                                            .title[
                                        'phone']
                                    +" : "+orderdetails.orderAddress.phone1,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black87.withOpacity(.6)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .05,
                          right: MediaQuery.of(context).size.width * .05,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      color: Colors.black12, width: 1)),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .04,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                        color:
                                            Color(0xffdedede).withOpacity(.5)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      DemoLocalizations.of(
                                          context)
                                          .title[
                                      'requestdetails']
                                      ,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black12,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    .3 -
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        decoration: BoxDecoration(),
                                        alignment: Alignment.center,
                                        child: Text(
                                          DemoLocalizations.of(
                                              context)
                                              .title[
                                          'qunt']
                                          ,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        decoration: BoxDecoration(),
                                        alignment: Alignment.center,
                                        child: Text(
                                          DemoLocalizations.of(
                                              context)
                                              .title[
                                          'Tax']
                                          +"  15 %",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        decoration: BoxDecoration(),
                                        alignment: Alignment.center,
                                        child: Text(
                                          DemoLocalizations.of(
                                              context)
                                              .title[
                                          'totalorder']
                                          ,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .27,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .27,
                                        color: Colors.black12,
                                      ),
                                      Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .27,
                                        color: Colors.black12,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    .3 -
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        decoration: BoxDecoration(),
                                        alignment: Alignment.center,
                                        child: Text(
                                          orderdetails.allQuantity.toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        decoration: BoxDecoration(),
                                        alignment: Alignment.center,
                                        child: Text(
                                          double.parse(orderdetails.tax)
                                                  .toStringAsFixed(2) +
                                              DemoLocalizations.of(
                                                  context)
                                                  .title[
                                              'currency']
                                          ,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        decoration: BoxDecoration(),
                                        alignment: Alignment.center,
                                        child: Text(
                                          double.parse(orderdetails.totalValue)
                                                  .toStringAsFixed(2) +
                                              DemoLocalizations.of(
                                                  context)
                                                  .title[
                                              'currency']
                                          ,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            /*        Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("تفاصيل الفاتورة ",style: TextStyle(fontSize: 12,color:Colors.black),)                      ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Divider(color: Colors.black26,height: 1,),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("مجموع الطلبات ",style: TextStyle(fontSize: 12,color:Colors.black),),
                                Text((allPrice-tax).toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Divider(color: Colors.black26,height: 1,),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("اجمالي الكمية ",style: TextStyle(fontSize: 12,color:Colors.black),),
                                Text(totalquantity.toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Divider(color: Colors.black26,height: 1,),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الضريبة 15% ",style: TextStyle(fontSize: 12,color:Colors.black),),
                                Text(tax.toString(),style: TextStyle(fontSize: 12,color:Colors.black),)
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Divider(color: Colors.black26,height: 1,),
                            SizedBox(height: MediaQuery.of(context).size.height*.005,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الاجمالي ",style: TextStyle(fontSize: 12,color: Color(h.mainColor),),),
                                Text((allPrice).toString(),style: TextStyle(fontSize: 12,color: Color(h.mainColor)),)
                              ],
                            ),*/
                            /*  */ /*  SizedBox(height: MediaQuery.of(context).size.height*.02,),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                              //right:  MediaQuery.of(context).size.width*.2,
                              //left:  MediaQuery.of(context).size.width*.2
                            ),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(h.blueColor),
                            ),
                            height: MediaQuery.of(context).size.height*.06,
                            //  width: MediaQuery.of(context).size.width*.8,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.07,
                              right: MediaQuery.of(context).size.width*.07,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("الاجمالي"+" "+"451"+" "+"ر.س",style: TextStyle(color:Colors.white,fontSize: 12)),
                              ],
                            ),

                          ),
                          onTap: () async {
                          },
                        ),*/ /*
                        SizedBox(height: MediaQuery.of(context).size.height*.02,),*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .05,
                            right: MediaQuery.of(context).size.width * .05),
                        child: Row(
                          children: [
                            Text(
                             // "المنتجات",و,
                            DemoLocalizations.of(
                            context)
                            .title[
                        'products'],

                          style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: orderdetails.orderDetails.length,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .01,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                // left: MediaQuery.of(context).size.width*.02,
                                // right: MediaQuery.of(context).size.width*.02,
                                //top: MediaQuery.of(context).size.height*.005,
                                //bottom: MediaQuery.of(context).size.height*.005
                                ),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .008,
                                bottom:
                                    MediaQuery.of(context).size.height * .008,
                                left: MediaQuery.of(context).size.width * .05,
                                right: MediaQuery.of(context).size.width * .05),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    width: 1.0,
                                    color: Colors.black12.withOpacity(.05)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          //  top: MediaQuery.of(context).size.height*.003
                                          ),
                                      child: Row(
                                        children: [
                                          Container(
                                            // margin: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.white),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .08,
                                            margin: EdgeInsets.only(
                                                // left:  MediaQuery.of(context).size.width*.028,
                                                // right:   MediaQuery.of(context).size.width*.028,
                                                //top: MediaQuery.of(context).size.height*.015,
                                                //  bottom: MediaQuery.of(context).size.height*.015,
                                                ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "images/no-img.jpg",
                                                image: orderdetails
                                                    .orderDetails[index].image,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .9,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .08,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .08,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .008,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .61,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        orderdetails
                                                            .orderDetails[index]
                                                            .name,
                                                        style: TextStyle(
                                                            height: 1.0,
                                                            fontSize: 14,
                                                            color: Color(
                                                                h.mainColor)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .00,
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .61,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        orderdetails
                                                                .orderDetails[
                                                                    index]
                                                                .price2 +
                                                            DemoLocalizations.of(
                                                                context)
                                                                .title[
                                                            'currency']
                                                        ,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .008,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    setState(() {
      markers[markerId] = marker;
    });
    map(markers, _kGooglePlex);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline(double distlat, double distlong) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI",
      PointLatLng(double.parse(orderdetails.orderAddress.lat),
          double.parse(orderdetails.orderAddress.lng)),
      PointLatLng(distlat, distlong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
    var totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    setState(() {
      _placeDistance = totalDistance.toStringAsFixed(2);
      print('DISTANCE: $_placeDistance km');
    });
  }

  List<Placemark> newPlace;

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
    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(double.parse(orderdetails.orderAddress.lat),
            double.parse(orderdetails.orderAddress.lng)),
        zoom: 9,
      );
    });
  }

  Widget map(Map<MarkerId, Marker> markers, CameraPosition _kGooglePlex) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
      compassEnabled: true,
      zoomControlsEnabled: true,
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  _makingPhoneCall() async {
    var url = 'tel:${orderdetails.orderUser.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  endOrder(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 150.0,
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
                                Image.asset(
                                  "images/icon/about.png",
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DemoLocalizations.of(
                                      context)
                                      .title[
                                  'Confirmationofdeliveryoftheordertothecustomer']
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
                          height: 20,
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
                                    DemoLocalizations.of(
                                        context)
                                        .title[
                                    'cancell']
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
                                    DemoLocalizations.of(
                                        context)
                                        .title[
                                    'confirm']
                                    ,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                                onTap: () async {
                                  Map<String, dynamic> responce =
                                      await orderServices.EndOrder(
                                          driver_id, orderdetails.id);
                                  print(responce);
                                  print(
                                      "ssssssssssssssssssssssssssssssssssssssssss");
                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      "/DeleverMain", (route) => false);
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

  cancelOrder(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 215.0,
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
                                Image.asset(
                                  "images/icon/about.png",
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DemoLocalizations.of(
                                      context)
                                      .title[
                                  'Confirmordercancellation']
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
                          height: 5,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              maxLines: 3,
                              minLines: 2,
                              //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    right: 15, left: 15, top: 0, bottom: 0),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color(h.borderColor))),
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color(h.FocusBorderColor))),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color(h.ErorrBorderColor))),
                                errorBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Color(h.ErorrBorderColor))),
                                hintText: DemoLocalizations.of(
                                    context)
                                    .title[
                                'Reasonforcancelingtherequest']
                                ,
                                errorStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              controller: reason,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                                    DemoLocalizations.of(
                                        context)
                                        .title[
                                    'cancell']
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
                                    DemoLocalizations.of(
                                        context)
                                        .title[
                                    'confirm']
                                    ,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                                onTap: () async {
                                  if (startMove) {
                                    Map<String, dynamic> responce =
                                        await orderServices
                                            .CancelDeliveryAfterConfirm(
                                                driver_id,
                                                orderdetails.id,
                                                reason.text);
                                    print(responce);
                                    print("sssssssssssssssss");
                                  } else {
                                    Map<String, dynamic> responce =
                                        await orderServices.CancelOrder(
                                            driver_id,
                                            orderdetails.id,
                                            reason.text);
                                    print(responce);
                                    print("sssssssssssssssss");
                                  }
                                  Navigator.pop(context);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      "/DeleverMain", (route) => false);
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
}
