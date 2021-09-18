import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:mishwar/app/Services/AddressServices.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:mishwar/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'GlobalFunction.dart';
import '../Model/RegionModel.dart';
import 'ConfirmOrder3.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Screens/Addreses.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'SearchLocation.dart';

class AddAddress extends StatefulWidget{
  String type;
  AddAddress(String type){
    this.type=type;
  }
  @override
  State<StatefulWidget> createState() {
    return _state(this.type);
  }
}
class _state extends State<AddAddress> {
  String type;

  _state(String type) {
    this.type = type;
  }
 TextEditingController searchzone=new TextEditingController();
  PickResult  _pickedLocation;

  home h = new home();
  bool locationScreen = false;
  var key = "+966";
  var key2="+966";
  //homeaddress workaddress other
  List<String>addresstype =[];
  List<RegionDetail>RegionList = [];
  List<RegionDetail>RegionList0 = [];
  AddressServices addressServices = new AddressServices();
  loadData() async {
    RegionList0 = await addressServices.GetRegions();
     setState(() {
      RegionList=RegionList0;
    });
  }
  String SelectedRegion;
  String SelectedRegionId='';
  TextEditingController phone = new TextEditingController();
  TextEditingController search = new TextEditingController();
  TextEditingController phone2 = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController zone = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController street = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController mark = new TextEditingController();
  FocusNode zoneNode = new FocusNode();
  FocusNode phone2Node = new FocusNode();
  FocusNode streetNode = new FocusNode();
  FocusNode locationNode = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  FocusNode markNode = new FocusNode();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String latitude = '00.00000';
  String longitude = '00.00000';
  List<Placemark> newPlace;
  CameraPosition c;
  bool isError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    setState(() {
      phone.text=home.phone.substring(3);
      key=home.phone.substring(0,3);
    });
   }
  @override
  Widget build(BuildContext context) {
    addresstype = [DemoLocalizations.of(context)
        .title['homeaddress']
      , DemoLocalizations.of(context)
          .title['workaddress'], DemoLocalizations.of(context)
          .title['other']];
    return
     // !locationScreen ?
    SafeArea(
      child: Scaffold(
        key: _scaffoldKey,appBar: AppBar(automaticallyImplyLeading: false,elevation: 0.0,
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
                  .title['addnewadrress'],style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,),
            ),
          ],
        ),),
        resizeToAvoidBottomInset: false,
        //endDrawer: MyDrawer(-1),
        body:RegionList0.length == 0 ?  Center(child: CircularProgressIndicator(),) :
                 Container(height: MediaQuery.of(context).size.height,
                     width:MediaQuery.of(context).size.width ,
                   child: SingleChildScrollView(
                     child: Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery
                                .of(context)
                                .size
                                .width * .05,
                            right: MediaQuery
                                .of(context)
                                .size
                                .width * .05
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 15,),
                            InkWell(
                              onTap: () {
                                SelectRegion(context);
                              },
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .065,
                                padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      color: isError && SelectedRegion == null
                                          ? Colors.red
                                          : Color(h.borderColor), width: 1),
                                  color: Colors.white,
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(SelectedRegion == null
                                    //ChooseRegion
                                        ? DemoLocalizations.of(context)
                                        .title['ChooseRegion']

                                        : SelectedRegion,
                                      style: TextStyle(color: Colors.black45),),
                                    Icon(Icons.keyboard_arrow_down_outlined,
                                        color: Colors.black45)
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),

                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                focusNode: zoneNode,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(streetNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 0, bottom: 0),
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.borderColor))
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.FocusBorderColor))
                                  ),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))
                                  ),
                                  hintText: DemoLocalizations.of(context)
                                      .title['addressName']
                                  ,
                                  errorStyle: TextStyle(fontSize: 0),
                                  hintStyle: TextStyle(color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                controller: title,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),

                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                focusNode: streetNode,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(markNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 0, bottom: 0),
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.borderColor))
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.FocusBorderColor))
                                  ),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))
                                  ),
                                  hintText: DemoLocalizations.of(context)
                                      .title['street']
                                  ,
                                  errorStyle: TextStyle(fontSize: 0),
                                  hintStyle: TextStyle(color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                controller: street,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),

                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                focusNode: markNode,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(phoneNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      right: 15, left: 15, top: 0, bottom: 0),
                                  enabledBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.borderColor))
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.FocusBorderColor))
                                  ),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color(h.ErorrBorderColor))
                                  ),
                                  hintText: DemoLocalizations.of(context)
                                      .title['landmark']
                                  ,
                                  errorStyle: TextStyle(fontSize: 0),
                                  hintStyle: TextStyle(color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                controller: mark,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .22,
                                    height: 47,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(width: 1,
                                          color: isError
                                              ? Color(h.ErorrBorderColor)
                                              : Color(h.borderColor)),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .01, right: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .01
                                    ),
                                    child: /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("996+",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black45),),
                                  SizedBox(width: 3,),
                                  Image.asset("images/ar.png",height: 17,width: MediaQuery.of(context).size.width*.065,fit: BoxFit.fill,),
                                ],
                              )*/

                                    Container(
                                      //width: MediaQuery.of(context).size.width*.22,
                                      alignment: Alignment.center,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: CountryCodePicker(
                                          alignLeft: false,
                                          flagWidth: 35,
                                          padding: EdgeInsets.zero,
                                          onChanged: (v) {
                                            setState(() {
                                              key = v.toString();
                                            });
                                            print(key);
                                          },
                                          dialogTextStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          hideMainText: false,
                                          showFlagMain: true,
                                          showFlag: true,
                                          initialSelection: key,
                                          hideSearch: false,
                                          textStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          favorite: ["EG", "SA"],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                  ),

                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    focusNode: phoneNode,
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                          phone2Node);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          right: 15, left: 15, top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.borderColor))
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))
                                      ),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))
                                      ),
                                      hintText: DemoLocalizations.of(context)
                                          .title['phone']
                                      ,
                                      errorStyle: TextStyle(fontSize: 0),
                                      hintStyle: TextStyle(color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    controller: phone,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .22,
                                    height: 47,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(width: 1,
                                          color: isError
                                              ? Color(h.ErorrBorderColor)
                                              : Color(h.borderColor)),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: MediaQuery
                                            .of(context)
                                            .size
                                            .width * .01, right: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .01
                                    ),
                                    child: /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("996+",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black45),),
                                  SizedBox(width: 3,),
                                  Image.asset("images/ar.png",height: 17,width: MediaQuery.of(context).size.width*.065,fit: BoxFit.fill,),
                                ],
                              )*/

                                    Container(
                                      //width: MediaQuery.of(context).size.width*.22,
                                      alignment: Alignment.center,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: CountryCodePicker(
                                          alignLeft: false,
                                          flagWidth: 35,
                                          padding: EdgeInsets.zero,
                                          onChanged: (v) {
                                            setState(() {
                                              key2 = v.toString();
                                            });
                                            print(key2);
                                          },
                                          dialogTextStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          hideMainText: false,
                                          showFlagMain: true,
                                          showFlag: true,
                                          initialSelection: key2,
                                          hideSearch: false,
                                          textStyle: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          favorite: ["EG", "SA"],
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.white,
                                  ),

                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    focusNode: phone2Node,
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context).requestFocus(
                                          FocusNode());
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return null;
                                      }
                                      return null;
                                    },
                                    //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          right: 15, left: 15, top: 0, bottom: 0),
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.borderColor))
                                      ),
                                      focusedBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.FocusBorderColor))
                                      ),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))
                                      ),
                                      errorBorder: new OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(h.ErorrBorderColor))
                                      ),
                                      hintText: DemoLocalizations.of(context)
                                          .title['Alternativephonenumber']
                                      ,
                                      errorStyle: TextStyle(fontSize: 0),
                                      hintStyle: TextStyle(color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                    controller: phone2,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 15,),
  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlacePicker(
                                            apiKey: 'AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI',   // Put YOUR OWN KEY here.
                                            onPlacePicked: (result) {
                                              //_pickedLocation = result;
                                              print('${result.geometry.location},,,,,,,,resultltltl');
                                              Navigator.of(context).pop();
                                            },
                                            // initialPosition: HomePage.kInitialPosition,
                                            useCurrentLocation: true,
                                          ),
                                        ),
                                      );
                                    },

//                                    LocationResult result = await showLocationPicker(
//                                        context,
//                                        'AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI',
//                                        myLocationButtonEnabled: true,resultCardConfirmIcon: Icon(Icons.done),
//                                        appBarColor: Theme.of(context).accentColor,requiredGPS: true,automaticallyAnimateToCurrentLocation:true,
//
//                                        layersButtonEnabled: true,hintText: DemoLocalizations.of(context)
//                                        .title['Searchonthemap']
//                                    );
//
//                                    setState((){
//                                      _pickedLocation = result;
//                                        print("${_pickedLocation},,,,,,,,resultlocation");
//                                      // print('${_pickedLocation.latLng.toString()},,,,,,');
//                                    });


//                                     Navigator.push(context, GlobalFunction.route(SearchLocation()));
//                                    setState(() {
//                                      locationScreen = true;
//                                    });
//                                 await   _getCurrentLocation();

                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .23,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: isError ? Colors.red : Color(
                                                h.borderColor), width: 1),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: ImageIcon(
                                        AssetImage("images/mapLocator.png"), size: 20,
                                        color: Color(h.mainColor),),
                                    ),
                                  ),
                                  GestureDetector(

                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .64,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            color: isError ? Colors.red : Color(
                                                h.borderColor), width: 1),
                                        color: Colors.white,
                                      ),

                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              FocusNode());
                                        },
                                        enabled: false,
                                        //textDirection: lang=="ar"?TextDirection.rtl:TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              right: 15, left: 15, top: 0, bottom: 0),
                                          disabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(h.borderColor))
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(h.FocusBorderColor))
                                          ),
                                          focusedErrorBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(h.ErorrBorderColor))
                                          ),
                                          errorBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(h.ErorrBorderColor))
                                          ),
                                          hintText: newPlace == null
                                              ? DemoLocalizations.of(context)
                                              .title['locationonmap']
                                              : "${newPlace[0].country},${newPlace[0]
                                              .subAdministrativeArea},${newPlace[0]
                                              .street} ",
                                          errorStyle: TextStyle(fontSize: 0),
                                          hintStyle: TextStyle(color: Colors.black45,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        controller: location,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            /*     SizedBox(height: 15,),
                           ClipRRect(
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                             child: Image.asset("images/map.png",
                               width: MediaQuery.of(context).size.width*.9,
                               height: MediaQuery.of(context).size.height*.2,
                               fit: BoxFit.fill,
                             ),
                           ),*/
                            SizedBox(height: 15,),
                            InkWell(
                              onTap: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                if(SelectedRegionId=='')
                                {
                                  Toast.show(
                                      DemoLocalizations.of(context).title['regionrequired'],
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                                else
                                  { if (formKey.currentState.validate()) {
                                    if(phone.text.substring(0,1)=="0"){
                                      setState(() {
                                        phone.text=phone.text.substring(1);
                                      });
                                    }
                                    if(phone2.text!=""){
                                      print(phone2.text);
                                      print("ssssssssssssssssssssssssssssssssssssssssssss");
                                      if(phone2.text.substring(0,1)=="0"){
                                        setState(() {
                                          phone2.text=phone2.text.substring(1);
                                        });
                                      }
                                    }
                                    Map<String,dynamic>responce = await addressServices.addAddressService(
                                        prefs.getString("UserId"),
                                        title.text,
                                        street.text,
                                        mark.text,
                                       '34.3434','23.2323',
                                       // _pickedLocation.adrAddress.. .toString(),
                                        //prefs.getString("lat"),
                                      //  _pickedLocation.latLng.longitude.toString(),
                                        phone.text,
                                        phone2.text,
                                        SelectedRegionId);
                                    if (responce["StatusCode"] == 200) {
                                      setState(() {
                                        ParentPage.address = null;
                                      });
                                      //  Navigator.pushNamedAndRemoveUntil(context, "/Adresses", (route) => false);
                                      //Navigator.pop(context);
                                      if (type == "confirm")
                                        Navigator.push(context,
                                            GlobalFunction.routeBottom(
                                                ConfirmOrder3(1)));
                                      else
                                        Navigator.of(context)
                                            .pop();

                                      Toast.show(
                                        //addaddressdone
                                          DemoLocalizations.of(context)
                                              .title['addaddressdone']
                                          , context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                    }
                                    else {
                                      Toast.show(
                                          "${responce["Message"]}", context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                    }

                                  }
                                  else {
                                    setState(() {
                                      isError = true;
                                    });
                                  }}


                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(h.blueColor),),
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .065,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .9,
                                alignment: Alignment.center,
                                child: Text(DemoLocalizations.of(context)
                                    .title['confirm']
                                  , style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),),
                              ),
                            ),
                            SizedBox(height: 30,),
                          ],
                        ),
                      ),
                ),
                   ),
                 )



      ),
    )
//    SafeArea(
//      child: Scaffold(
//        resizeToAvoidBottomInset: false,
//        body: Stack(
//            children: [
//              Container(
//                child: Column(
//                  children: [
//                    Container(
//                      padding: EdgeInsets.only(
//                          bottom: 10
//                      ),
//                      width: MediaQuery
//                          .of(context)
//                          .size
//                          .width,
//                      //height: MediaQuery.of(context).size.height*.2,
//                      color: Color(h.mainColor),
//                      child: Column(
//                        children: [
//                          SizedBox(height: 10,),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                              InkWell(
//                                onTap: () {
//                                  setState(() {
//                                    locationScreen = false;
//                                  });
//                                },
//                                child: Container(
//                                    padding: EdgeInsets.only(
//                                        left: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .width * .02,
//                                        right: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .width * .05,
//                                        top: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .height * .02,
//                                        bottom: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .height * .02
//                                    ),
//                                    child: Icon(
//                                      Icons.arrow_forward_ios_outlined,
//                                      color: Colors.white,)),
//                              ),
//                              Container(
//                                width: MediaQuery
//                                    .of(context)
//                                    .size
//                                    .width * .78,
//                                decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.all(
//                                        Radius.circular(10)),
//                                    color: Colors.white
//                                ),
//                                child: TextFormField(
//                                  onFieldSubmitted: (value) {},
//                                  onChanged: (value) {
//                                    getLocatinResult(value);
//                                  },
//                                  decoration: InputDecoration(
//                                      errorStyle: TextStyle(
//                                          fontWeight: FontWeight.bold,
//                                          fontSize: 12,
//                                          color: Color(h.mainColor)),
//                                      contentPadding: EdgeInsets.only(right: 15,
//                                          left: 15,
//                                          top: 0,
//                                          bottom: 0),
//                                      enabledBorder: new OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(
//                                              10),
//                                          borderSide: BorderSide(
//                                              color: Color(h.borderColor))
//                                      ),
//                                      focusedBorder: new OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(
//                                              10),
//                                          borderSide: BorderSide(
//                                              color: Color(h.FocusBorderColor))
//                                      ),
//                                      focusedErrorBorder: new OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(
//                                              10),
//                                          borderSide: BorderSide(
//                                              color: Color(h.ErorrBorderColor))
//                                      ),
//                                      errorBorder: new OutlineInputBorder(
//                                          borderRadius: BorderRadius.circular(
//                                              10),
//                                          borderSide: BorderSide(
//                                              color: Color(h.ErorrBorderColor))
//                                      ),
//                                      prefixIcon: Icon(Icons.search, size: 30,
//                                        color: Colors.black45,),
//                                      hintText: '  أبحث ',
//                                      hintStyle: TextStyle(
//                                          fontWeight: FontWeight.bold,
//                                          fontSize: 12,
//                                          color: Colors.black87)
//                                  ),
//                                  controller: search,
//                                ),
//                              ),
//                              InkWell(
//                                onTap: () {
//                                  //Navigator.pop(context);
//                                },
//                                child: Container(
//                                    padding: EdgeInsets.only(
//                                        left: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .width * .0258,
//                                        right: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .width * .025,
//                                        top: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .height * .02,
//                                        bottom: MediaQuery
//                                            .of(context)
//                                            .size
//                                            .height * .02
//                                    ),
//                                    child: Icon(
//                                      Icons.arrow_forward_ios_outlined,
//                                      color: Color(h.mainColor), size: 0,)),
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: MediaQuery
//                              .of(context)
//                              .size
//                              .height * .0),
//
//                        ],
//                      ),
//                    ),
//                    map(latitude,longitude,listMarkers),
//                    SizedBox(height: 10,),
//                    GestureDetector(
//                      onTap: () {
//                        Navigator.pop(context);
//                      },
//                      child: Container(
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width * .9,
//                        padding: EdgeInsets.only(
//                          left: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .07,
//                          right: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .07,
//                          top: MediaQuery
//                              .of(context)
//                              .size
//                              .height * .02,
//                          bottom: MediaQuery
//                              .of(context)
//                              .size
//                              .height * .02,
//                        ),
//                        margin: EdgeInsets.only(
//                          left: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .05,
//                          right: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .05,
//                        ),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            border: Border.all(color: Colors.black38, width: 1),
//                            color: Colors.white
//                        ),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: [
//                            //Icon(Icons.check_circle,color: Color(h.mainColor),size: 65,),
//                            Container(
//                              width: MediaQuery
//                                  .of(context)
//                                  .size
//                                  .width * .5,
//                              child: Text(" ${newPlace[0].country},${newPlace[0]
//                                  .subAdministrativeArea},${newPlace[0]
//                                  .street} ,${newPlace[0].name}",
//                                style: TextStyle(
//                                    fontWeight: FontWeight.bold
//                                ), textAlign: TextAlign.right,),
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 10,),
//                    GestureDetector(
//                      onTap: () {
//                        setState(() {
//                          locationScreen = false;
//                        });
//                      },
//                      child: Container(
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width * .9,
//                        padding: EdgeInsets.only(
//                          left: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .07,
//                          right: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .07,
//                          top: MediaQuery
//                              .of(context)
//                              .size
//                              .height * .01,
//                          bottom: MediaQuery
//                              .of(context)
//                              .size
//                              .height * .01,
//                        ),
//                        margin: EdgeInsets.only(
//                          left: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .05,
//                          right: MediaQuery
//                              .of(context)
//                              .size
//                              .width * .05,
//                        ),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(Radius.circular(10)),
//                            border: Border.all(color: Colors.black38, width: 1),
//                            color: Color(h.blueColor)
//                        ),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Icon(Icons.check_circle, color: Colors.white,
//                              size: 30,),
//                            SizedBox(width: 20,),
//                            Text(
//                              DemoLocalizations.of(context)
//                                  .title['confirm'], style: TextStyle(color: Colors.white),)
//                          ],
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 10,),
//                  ],
//                ),
//              ),
//              response==null|| response.data["predictions"].length == 0 ||
//                  response.data["predictions"] == null
//                  ? SizedBox()
//                  : Positioned(
//                left: MediaQuery
//                    .of(context)
//                    .size
//                    .width * .067,
//                top: MediaQuery
//                    .of(context)
//                    .size
//                    .height * .085,
//                child: Container(
//                  width: MediaQuery
//                      .of(context)
//                      .size
//                      .width * .78,
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height * .4,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(0),
//                      color: Colors.white
//                  ),
//                  child: ListView.builder(
//                      itemCount: response.data["predictions"].length,
//                      itemBuilder: (context, index) {
//                        return InkWell(
//                          onTap: () async{
//                            print("666666666666666666666666666666666666666666");
//                            print(response.data["predictions"][index]);
//                            print("33333333333333333333333333333333333333333333");
//                           await displayPrediction(Prediction.fromJson(response.data["predictions"][index]));
//                           setState(() {
//                             response=null;
//                           });
//                          },
//                          child: Container(
//                            padding: EdgeInsets.only(
//                              top: 5,bottom: 5,
//                              left: 10,right: 10
//                            ),
//                            child: Text(response
//                                .data["predictions"][index]["description"]),
//                          ),
//                        );
//                      }),
//                ),
//              )
//            ],
//          ),
//
//      ),
//    )
    ;
  }
  Response response;
  Map<String, dynamic>data;
  getLocatinResult(String text) async {
    var api_key = "AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI";
    var type = "(regions)";
    String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$url?input=$text&key=$api_key&type=$type";
    response = await Dio().get(request);
    setState(() {});
    print(response.data["predictions"][0]["description"]);
    print("**********************************");
  }
  SelectRegion(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            Dialog(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .4,
                decoration: BoxDecoration(color: Colors.black12,
                  // borderRadius: BorderRadius.all(Radius.circular(20))
                  // border: Border.all(color: Colors.black12,width: 2.0)
                )
                , padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01,
                left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05,
                right: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05,
              ),


                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width*.66,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          keyboardType:TextInputType.text,
                          onChanged: (val){
                           if(val.isNotEmpty){
                             setState(() {
                               RegionList=[];
                             });
                             for(int i=0;i<RegionList0.length;i++){
                               if(RegionList0[i].region.contains(val)){
                                 RegionList.add(RegionList0[i]);
                               }
                               setState(() {
                               });
                             }
                             print(RegionList.length);
                             print("1111111111111111111111111111111111111111111111111111");
                           }else{
                             setState(() {
                               RegionList=RegionList0;
                             });
                           }
                          },
                          onFieldSubmitted: (value){
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validator: (value){
                            if(value.isEmpty){
                              return null;
                            }
                            return null;
                          },
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(h.mainColor)),
                              contentPadding: EdgeInsets.only(right: 10,left: 10,top: 0,bottom: 0),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black38)
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
                              prefixIcon: Icon(Icons.search,size: 20,color: Colors.black45,),
                              hintText: 'ابحث',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black45)
                          ),
                          controller: searchzone,
                        ),
                      ),
                      SizedBox(height: 5,),
                      ListView.builder(shrinkWrap: true, primary: false,
                        itemCount: RegionList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                SelectedRegion = RegionList[index].region;
                                SelectedRegionId = RegionList[index].id;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.only(bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .005, top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .005),
                                padding: EdgeInsets.only(bottom: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .005, top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .005),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)),
                                    color: Color(h.blueColor)
                                ),
                                alignment: Alignment.center,
                                child: Text(RegionList[index].region,
                                  style: TextStyle(color: Colors.white),)),
                          );
                        },
                      ),
                    ],
                  ),
                ),

              ),
            ));
  }
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  makeMarker(double lat, double lng) async {
    newPlace = await placemarkFromCoordinates(lat, lng);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onDragEnd: (LatLng) async {
          print(LatLng);
          newPlace =
          await placemarkFromCoordinates(LatLng.latitude, LatLng.longitude);
          prefs.setString("lat", LatLng.latitude.toString());
          prefs.setString("lng", LatLng.longitude.toString());
          ParentPage.address = newPlace[0].country + " " + newPlace[0].street;
          setState(() {});
          print(ParentPage.address);
          print(
              "ssssssssss2222222222222222222222222222222222222222222222222222");
        },
        position: LatLng(
            double.parse(this.latitude), double.parse(this.longitude)),
        infoWindow: InfoWindow(title: DemoLocalizations.of(context)
            .title['currentlocation']
        ),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'images/logo.png')
            .then((onValue) {
          customIcon = onValue;
        })
    ));
    map(latitude,longitude,listMarkers);
    setState(() {
      c  =new CameraPosition(
        // bearing: 30,
          target: LatLng(lat,lng),
          //tilt: 45,
          zoom: 15
      );
    });
//newPlace[0].country},${newPlace[0]
//                                            .subAdministrativeArea},${newPlace[0]
//                                            .street
    title.text=newPlace[0].country.toString()+newPlace[0].subAdministrativeArea.toString();
    street.text = newPlace[0].street.toString();
  }
  BitmapDescriptor customIcon;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyBHG1sJAP3tp8iIsHNd_McetWdmn14HDWI");
  Future<Null> displayPrediction(Prediction p) async {

    print("00000000000000000000000000000");
    if (p != null) {
      print(p.placeId);
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
         latitude = detail.result.geometry.location.lat.toString();
          longitude = detail.result.geometry.location.lng.toString();

      makeMarker(double.parse(latitude), double.parse(longitude));
      setState(() {
        c  =CameraPosition(
          // bearing: 30,
            target: LatLng(double.parse(latitude), double.parse(longitude)),
            //tilt: 45,
            zoom: 15
        );
      });
      setState(() {
      });
      print("____________________________________________________________________________________________________");
    }
  }
 Widget map(String latitude,String longitude, Set<Marker> listMarkers ){
    return   Expanded(
      child: GoogleMap(
        myLocationEnabled :true,
        zoomControlsEnabled: true,
        mapType: MapType.normal,
        onTap: (LatLng) {
          makeMarker(LatLng.latitude, LatLng.longitude);
          setState(() {});
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: c,
        compassEnabled: true,
        markers: listMarkers,
      ),
    );
  }
}