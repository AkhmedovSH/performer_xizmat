import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker = [
    Marker(
        markerId: MarkerId(LatLng(41.311081, 69.240562).toString()),
        position: LatLng(41.311081, 69.240562))
  ];
  double latitude = 0.0;
  double longitude = 0.0;
  // var geolacator = geolocator.Geolocator();

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(41.311081, 69.240562), zoom: 13.0);
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(41.311081, 69.240562),
      tilt: 59.440717697143555,
      zoom: 19.0);

  handleTab(LatLng tappedPoint) {
    setState(() {
      latitude = tappedPoint.latitude;
      longitude = tappedPoint.longitude;
      marker = [];
      marker.add(
        Marker(
            markerId: MarkerId(tappedPoint.toString()), position: tappedPoint),
      );
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    setState(() {
      marker = [];
      marker.add(
        Marker(
            markerId: MarkerId(LatLng(41.311081, 69.240562).toString()),
            position: LatLng(41.311081, 69.240562)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Добавить геолокацию',
        appBar: AppBar(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      AppBar().preferredSize.height,
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set.from(marker),
                    onTap: handleTab,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 19),
                      decoration: BoxDecoration(
                          color: globals.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Укажите адрес',
                              style: TextStyle(
                                  color: globals.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: Icon(
                                  Icons.cancel_sharp,
                                  color: globals.red,
                                  size: 20,
                                ),
                                contentPadding: EdgeInsets.all(8.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                      color: Color(0xFFECECEC), width: 0.0),
                                ),
                                filled: true,
                                fillColor: Color(0xFFF7F7F7),
                                hintText: 'Улица Бахтияра',
                                hintStyle: TextStyle(
                                    color: globals.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              style: TextStyle(color: globals.inputColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: widgets.Button(
                              text: 'Подтвердить адрес',
                              onClick: () {
                                Get.toNamed('/step-4');
                              },
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
