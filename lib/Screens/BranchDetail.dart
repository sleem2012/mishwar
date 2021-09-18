import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mishwar/Model/BranchModel.dart';
import 'package:mishwar/main.dart';
import 'package:mishwar/lang/app_Localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BrachDetail extends StatefulWidget{
  BranchModelDetail branchModelDetail;
  BrachDetail(BranchModelDetail branchModelDetail){
    this.branchModelDetail=branchModelDetail;
  }
  @override
  State<StatefulWidget> createState() {
   return _state(this.branchModelDetail);
  }
}
class _state extends State<BrachDetail>{
  BranchModelDetail branchModelDetail;
  _state(BranchModelDetail branchModelDetail){
    this.branchModelDetail=branchModelDetail;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  home h=new home();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeMarker();
    print(branchModelDetail.lat);
    print(branchModelDetail.long);
    print("0000000000000000000000000000000000000000000000000000000");
  }
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       key: _scaffoldKey,appBar:  AppBar(automaticallyImplyLeading: false,elevation: 0.0,
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
             child: Text(branchModelDetail.name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
               textAlign: TextAlign.center,),
           ),
         ],
       ),),
       //endDrawer: MyDrawer(-1),
       body:  SingleChildScrollView(
           child:  Container(
                   padding: EdgeInsets.only(
                       left: MediaQuery.of(context).size.width*.05,
                       right: MediaQuery.of(context).size.width*.05
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment:
                     MainAxisAlignment.start,
                     children: [
                       SizedBox(height: MediaQuery.of(context).size.height*.02,),
                     ClipRRect(
                       borderRadius: BorderRadius.all(Radius.circular(5)),
                         child: FadeInImage.assetNetwork(
                           placeholder: "images/branch.png",
                           image:branchModelDetail.image==null?"":branchModelDetail.image,
                           height: MediaQuery.of(context).size.height*.25,
                           width: MediaQuery.of(context).size.width,
                           fit: BoxFit.fill,
                         ),
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.02,),
                       Text(branchModelDetail.name,style: TextStyle(fontSize: 16,color: Colors.black87),),
                       SizedBox(height: MediaQuery.of(context).size.height*.01,),
                       Row(
                         children: [
                           Icon(Icons.location_on,size: 17,color: Colors.black45,),
                           SizedBox(width: 5,),
                           Container(
                               width: MediaQuery.of(context).size.width*.75,
                               child: Text(branchModelDetail.address==null?"":branchModelDetail.address.toString(),maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                         ],
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.01,),
                       Row(
                         children: [
                           Icon(Icons.phone,size: 17,color: Colors.black45,),
                           SizedBox(width: 5,),
                           Container(
                              // width: MediaQuery.of(context).size.width*.7,
                               child: Text(branchModelDetail.phone==null?"":branchModelDetail.phone,textDirection: TextDirection.ltr,maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                         ],
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.01,),
                       Row(
                         children: [
                           Icon(Icons.access_time_rounded,size: 17,color: Colors.black45,),
                           SizedBox(width: 5),
                           Container(
                               width: MediaQuery.of(context).size.width*.7,
                               //timesofwork
                               child: Text(DemoLocalizations.of(context)
                                   .title['timesofwork']
                                 ,maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                         ],
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.005,),
                       Row(
                         children: [
                           Icon(Icons.access_time_rounded,size: 17,color: Colors.white,),
                           SizedBox(width: 5),
                           Container(
                               width: MediaQuery.of(context).size.width*.7,
                               child: Text(branchModelDetail.workingTime.toString(),maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                         ],
                       ),
                    /*   SizedBox(height: MediaQuery.of(context).size.height*.005,),
                       Row(
                         children: [
                           Icon(Icons.access_time_rounded,size: 17,color: Colors.white,),
                           SizedBox(width: 5),
                           Container(
                               width: MediaQuery.of(context).size.width*.7,
                               child: Text("ما عدا الجمعة من 9:00 الي 10:00",maxLines: 1,style: TextStyle(color: Colors.black54,fontSize: 11),))
                         ],
                       ),*/
                       SizedBox(height: MediaQuery.of(context).size.height*.015,),
                        Container(
                          width: MediaQuery.of(context).size.width*.9,
                          height: 1,
                          color: Colors.black12,
                        ),
                       SizedBox(height: MediaQuery.of(context).size.height*.015,),

                       branchModelDetail.lat!=null?Column(children: [
                         //Branchlocationonthemap

                         Container(alignment:DemoLocalizations.of(context).locale == Locale("en")? Alignment.centerLeft:
                         Alignment.centerRight,
                         child: Text(DemoLocalizations.of(context)
                             .title['Branchlocationonthemap']
                           ,style: TextStyle(fontSize: 16,color: Colors.black87), ),
                       ),
                       SizedBox(height: MediaQuery.of(context).size.height*.015,),
                       ClipRRect(
                         borderRadius: BorderRadius.all(Radius.circular(5)),
                         child:  Container(
                           height: MediaQuery.of(context).size.height*.25,
                           width: MediaQuery.of(context).size.width,
                           child:  ClipRRect(
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                             child: GoogleMap(
                               mapType: MapType.normal,
                               onMapCreated: (GoogleMapController controller) {
                                 _controller.complete(controller);
                               },
                               initialCameraPosition: CameraPosition(
                                 // bearing: 30,
                                   target: LatLng(double.parse(branchModelDetail.lat.toString()),double.parse(branchModelDetail.long.toString())),
                                   //tilt: 45,
                                   zoom: 8
                               ),
                               compassEnabled: true,
                               markers: listMarkers,
                             ),


                           ),
                         ),
                       ),
                     ],):SizedBox()

                     ],),
                 ),


         ),

     ),
   );
  }
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  makeMarker() async{
        listMarkers.add(Marker(
            markerId: MarkerId("1"),
            draggable: true,
            onDragEnd:(LatLng) async {
              print(LatLng);
              List<Placemark> newPlace = await placemarkFromCoordinates(LatLng.latitude,LatLng.longitude);
              print(newPlace[0].country);
              print(newPlace[0].street);
              print("ssssssssss");
            } ,
            position: LatLng(double.parse(branchModelDetail.lat.toString()), double.parse(branchModelDetail.long.toString())),
            //
            infoWindow: InfoWindow(title: DemoLocalizations.of(context)
                .title['currentlocation']
            ),
            icon: customIcon
        ));
  }
  BitmapDescriptor customIcon;
}
