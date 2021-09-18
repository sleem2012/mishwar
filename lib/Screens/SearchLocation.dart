import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocation/geolocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mishwar/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/AddressModel.dart';
import 'CustomAppBar.dart';
class SearchLocation extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}
class _state extends State<SearchLocation>{
  home h=new home();
  TextEditingController search=new TextEditingController();
  String latitude = '00.00000';
  String longitude = '00.00000';
  List<Placemark> newPlace;
  _getCurrentLocation() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Geolocation.enableLocationServices().then((result) {
    }).catchError((e) {
      // Location Services Enablind Cancelled
      print(e);
      print("44444444444444444444");
    });

    Geolocation.currentLocation(accuracy: LocationAccuracy.best)
        .listen((result) {
      if (result.isSuccessful) {
        setState(() {
          latitude = result.location.latitude.toString();
          longitude = result.location.longitude.toString();
        });
        prefs.setString("lat",latitude);
        prefs.setString("lng",longitude);
        makeMarker(double.parse(latitude),double.parse(longitude));
      }
    });
    print(latitude);
    print(longitude);
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }
  getLocatinResult(String text) async {
    var api_key="AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI";
    var type="(regions)";
    String url="https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request="$url?input=$text&key=$api_key&type=$type";
    Response response=await Dio().get(request);
    print(response);
    print("**********************************");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              child:Column(
                children: [
                 Container(
                   padding: EdgeInsets.only(
                     bottom: 10
                   ),
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height*.2,
                      color: Color(h.mainColor),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width*.05,
                                      right: MediaQuery.of(context).size.width*.05,
                                      top: MediaQuery.of(context).size.height*.02,
                                      bottom: MediaQuery.of(context).size.height*.02
                                    ),
                                    child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,)),
                              )
                            ],
                          ),
                          SizedBox(height:MediaQuery.of(context).size.height*.0),
                          Container(
                            width: MediaQuery.of(context).size.width*.9,
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (value){
                              },
                              onChanged: (value){
                                getLocatinResult(value);
                              },
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),
                                  contentPadding: EdgeInsets.only(right: 15,left: 15,top: 0,bottom: 0),
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color(h.borderColor))
                                  ),
                                  focusedBorder:  new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color(h.FocusBorderColor))
                                  ),
                                  focusedErrorBorder:new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                                  ),
                                  errorBorder:new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Color(h.ErorrBorderColor))
                                  ),
                                  prefixIcon: Icon(Icons.search,size: 30,color: Colors.black45,),
                                  hintText: '  أبحث ',
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black87)
                              ),
                              controller: search,
                            ),
                          ),
                        ],
                      ),
                  ),
                         Expanded(
                          child: GoogleMap(
                            mapType: MapType.normal,
                            onTap: (LatLng){
                              makeMarker(LatLng.latitude,LatLng.longitude);
                              print(LatLng);
                              print("sssssssssssss");
                            },
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            initialCameraPosition: CameraPosition(
                              // bearing: 30,
                                target: LatLng(double.parse(latitude),double.parse(longitude)),
                                //tilt: 45,
                                zoom: 15
                            ),
                            compassEnabled: true,
                            markers: listMarkers,
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width*.9,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.07,
                              right: MediaQuery.of(context).size.width*.07,
                              top: MediaQuery.of(context).size.height*.02,
                              bottom: MediaQuery.of(context).size.height*.02,
                            ),
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width*.05,
                              right: MediaQuery.of(context).size.width*.05,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black38,width: 1),
                              color: Colors.white
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Icon(Icons.check_circle,color: Color(h.mainColor),size: 65,),
                                Container(
                                    width: MediaQuery.of(context).size.width*.5,
                                  child: Text(" ${newPlace[0].country},${newPlace[0].subAdministrativeArea},${newPlace[0].street} ,${newPlace[0].name}",style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),textAlign: TextAlign.right,),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*.9,
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.07,
                        right: MediaQuery.of(context).size.width*.07,
                        top: MediaQuery.of(context).size.height*.01,
                        bottom: MediaQuery.of(context).size.height*.01,
                      ),
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width*.05,
                        right: MediaQuery.of(context).size.width*.05,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black38,width: 1),
                          color: Color(h.blueColor)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle,color: Colors.white,size: 30,),
                           SizedBox(width: 20,),
                           Text("تأكيد",style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
    ) ;
  }

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  makeMarker(double lat,double lng) async{
    newPlace = await placemarkFromCoordinates(lat,lng);
    SharedPreferences prefs=await SharedPreferences.getInstance();
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onDragEnd:(LatLng) async {
          print(LatLng);
          newPlace = await placemarkFromCoordinates(LatLng.latitude,LatLng.longitude);
          prefs.setString("lat",LatLng.latitude.toString());
          prefs.setString("lng",LatLng.longitude.toString());
          ParentPage.address=newPlace[0].country+" "+newPlace[0].street;
          setState(() {
          });
          print(ParentPage.address);
          print("ssssssssss2222222222222222222222222222222222222222222222222222");
        } ,
        position: LatLng(double.parse(this.latitude), double.parse(this.longitude)),
        infoWindow: InfoWindow(title: "موقعك الحالي"),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'images/logo.png')
            .then((onValue) {
          customIcon = onValue;
        })
    ));
  }
  BitmapDescriptor customIcon;
}