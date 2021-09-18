import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  String title;

  GoogleMapsPage({this.title});

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> listMarkers = {};
  MapType currentMapType = MapType.normal;
  BitmapDescriptor customIcon;

  static final CameraPosition initCameraPosition = CameraPosition(
      bearing: 30,
      target: LatLng(41.39641729508688, 2.161925892612031),
      tilt: 45,
      zoom: 13.5
  );

  @override
  Widget build(BuildContext context) {
    listMarkers.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(41.40442592799307, 2.1761136771317475),
        infoWindow: InfoWindow(title: "La Sagrada Familia"),
        icon: customIcon
    ));

    listMarkers.add(Marker(
        markerId: MarkerId("2"),
        position: LatLng(41.39641729508688, 2.161925892612031),
        infoWindow: InfoWindow(title: "Casa Mila"),
        icon: customIcon));

    listMarkers.add(Marker(
        markerId: MarkerId("3"),
        position: LatLng(41.38840767527953, 2.173175802559483),
        infoWindow: InfoWindow(title: "Placa de Catalunya"),
        icon: customIcon));

    listMarkers.add(Marker(
        markerId: MarkerId("4"),
        position: LatLng(41.41503960716928, 2.1570586431097203),
        infoWindow: InfoWindow(title: "Park Guell"),
        icon: customIcon));

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Stack(
          children: [
            GoogleMap(
              mapType: currentMapType,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: initCameraPosition,
              compassEnabled: true,
              markers: listMarkers,
            ),
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                child: Icon(Icons.map, size: 30),
                onPressed: _onMapTypeChanged,
              ),
            )
          ],
        ));
  }

  void _onMapTypeChanged() {
    setState(() {
      currentMapType = currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void setCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/custom_marker.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }
}