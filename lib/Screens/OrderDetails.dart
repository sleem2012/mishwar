import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CustomAppBar.dart';
import 'CustomText.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import '../main.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../Model/OrderModel.dart';
import 'package:mishwar/lang/app_Localization.dart';
class OrderDetails extends StatefulWidget {
  final OrderDetailModel orderDetail;

  const OrderDetails({Key key, this.orderDetail}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  bool startMove=false;
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
  home h=new home();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeMarker();
    _getPolyline(27.5,25.65);
    if(widget.orderDetail.orderStatusId=="2"){
      _getPolyline(27.5,25.65);
    }
  }

  final Set<Marker> listMarkers = {};
  makeMarker() async{
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        draggable: false,
        onDragEnd:(LatLng) async {
          print(LatLng);
          List<Placemark> newPlace = await placemarkFromCoordinates(LatLng.latitude,LatLng.longitude);
        } ,
        position: LatLng(23.32, 23.323),
        infoWindow: InfoWindow(title: "موقعك الحالي"),
        icon: customIcon
    ));
  }
  BitmapDescriptor customIcon;
  void _getPolyline(double distlat,double distlong) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI",
      // PointLatLng(double.parse(orderDetail.orderAddress.lat),double.parse(orderDetail.orderAddress.lng)),
      PointLatLng(23.323,23.32323),
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
    var totalDistance=0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    setState((){
      _placeDistance = totalDistance.toStringAsFixed(2);
      print('DISTANCE: $_placeDistance km');
    });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Container(
            child: Column(
              children: [
                 CustomAppBar(DemoLocalizations.of(context).title['requestdetails']),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right: MediaQuery.of(context).size.width*.05
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: widget.orderDetail.orderStatusId=="2"?MediaQuery.of(context).size.height*.3:MediaQuery.of(context).size.height*.2,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: GoogleMap(
                            mapType: MapType.normal,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            initialCameraPosition: CameraPosition(
                              // bearing: 30,
                                target: LatLng(23.32,
                                    23.32),
                                //tilt: 45,
                                zoom: 13
                            ),
                            polylines: Set<Polyline>.of(polylines.values),
                            compassEnabled: true,
                            markers: listMarkers,
                          ),


                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.orderDetail.orderAddress.title,style: TextStyle(fontSize: 16),),
                            Text(widget.orderDetail.orderAddress.region,style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),),
                            Text(widget.orderDetail.orderAddress.address,style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),),
                            Text("رقم هاتف :${widget.orderDetail.orderAddress.phone1}",style: TextStyle(fontSize: 11,color: Colors.black87.withOpacity(.6)),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Divider(color: Colors.black12,height: 1,thickness: 1,),
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  width: MediaQuery.of(context).size.width*.9,
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width*.05,
                      right: MediaQuery.of(context).size.width*.05
                  ),
                  child: Row(
                    children: [
                      Text(DemoLocalizations.of(context).title['products'],style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                Expanded(
                    child:   ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: widget.orderDetail.orderDetails.length,
                      padding: EdgeInsets.only(
                        top:  MediaQuery.of(context).size.height*.01,
                      ),
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.only(
                            // left: MediaQuery.of(context).size.width*.02,
                            // right: MediaQuery.of(context).size.width*.02,
                            //top: MediaQuery.of(context).size.height*.005,
                            //bottom: MediaQuery.of(context).size.height*.005
                          ),
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height*.008,
                              bottom: MediaQuery.of(context).size.height*.008,
                              left: MediaQuery.of(context).size.width*.05,
                              right:  MediaQuery.of(context).size.width*.05
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 1.0,color: Colors.black12.withOpacity(.05)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(3, 3), // changes position of shadow
                                ),
                              ]
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Colors.white
                                          ),
                                          width: MediaQuery.of(context).size.width*.25,
                                          height: MediaQuery.of(context).size.height*.08,
                                          margin: EdgeInsets.only(
                                            // left:  MediaQuery.of(context).size.width*.028,
                                            // right:   MediaQuery.of(context).size.width*.028,
                                            //top: MediaQuery.of(context).size.height*.015,
                                            //  bottom: MediaQuery.of(context).size.height*.015,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight: Radius.circular(10)
                                            ),
                                            child:FadeInImage.assetNetwork(
                                              placeholder: "images/prodcut4.png",
                                              image:widget.orderDetail.orderDetails[index].image,
                                              width: MediaQuery.of(context).size.width*.9,
                                              height: MediaQuery.of(context).size.height*.08,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          height: MediaQuery.of(context).size.height*.08,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height:  MediaQuery.of(context).size.height*.008,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*.61,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(widget.orderDetail.orderDetails[index].name,style: TextStyle(height: 1.0,fontSize: 14,color: Color(h.mainColor)),),
                                                  ],),
                                              ),
                                              SizedBox(height:  MediaQuery.of(context).size.height*.00,),
                                              SizedBox(height:  1,),
                                              Container(
                                                width: MediaQuery.of(context).size.width*.61,
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                     Text(widget.orderDetail.orderDetails[index].price2+DemoLocalizations.of(context).title['currency'],style: TextStyle(color: Colors.black,fontSize: 11),),


                                                  ],
                                                ),
                                              ),
                                              SizedBox(height:  MediaQuery.of(context).size.height*.008,),

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
                    )
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width*.05,
                    right: MediaQuery.of(context).size.width*.05,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.black12,width: 1)
                        ),
                        child:Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*.04,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)
                                  ),
                                  color: Color(0xffdedede).withOpacity(.5)
                              ),
                              alignment: Alignment.center,

                              child: Text(DemoLocalizations.of(context).title['requestdetails'],style: TextStyle(fontSize: 12),),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,color: Colors.black12,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*.3-2,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(

                                  ),
                                  alignment: Alignment.center,
                                   child: Text(DemoLocalizations.of(context).title['qunt'],style: TextStyle(fontSize: 12),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.3,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(

                                  ),
                                  alignment: Alignment.center,
                                   child: Text(DemoLocalizations.of(context).title['Tax'] +' 15 % ',style: TextStyle(fontSize: 12),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.3,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(

                                  ),
                                  alignment: Alignment.center,
                                  //Totaldemand
                                  child: Text(DemoLocalizations.of(context).title['Totaldemand'],style: TextStyle(fontSize: 12),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width*.27,color: Colors.black12,
                                ),
                                Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width*.27,color: Colors.black12,
                                ),
                                Container(
                                  height: 1,
                                  width: MediaQuery.of(context).size.width*.27,color: Colors.black12,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*.3-2,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(

                                  ),
                                  alignment: Alignment.center,
                                  child: Text(widget.orderDetail.allQuantity.toString(),style: TextStyle(fontSize: 12),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.3,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(),
                                  alignment: Alignment.center,
                                  child: Text(double.parse(widget.orderDetail.tax).toStringAsFixed(2).toString()+
                                      DemoLocalizations.of(context).title['currency'],style: TextStyle(fontSize: 12),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*.3,
                                  height: MediaQuery.of(context).size.height*.04,
                                  decoration: BoxDecoration(

                                  ),
                                  alignment: Alignment.center,
                                  child: Text(double.parse(widget.orderDetail.totalValue).toStringAsFixed(2).toString()+DemoLocalizations.of(context).title['currency'],style: TextStyle(fontSize: 12),),
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
                      /*  SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
                    ),*/
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
              ],
            ),
          ),

      ),
    );
  }
}


