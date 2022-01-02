import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Step3 extends StatefulWidget {
  const Step3({Key? key}) : super(key: key);

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  Completer<GoogleMapController> _controller = Completer();
  dynamic character = 1;

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(41.311081, 69.240562), zoom: 13.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Укажите адрес',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 6.0,
                animationDuration: 500,
                percent: 0.6,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: globals.red,
                backgroundColor: Color(0xFFF8F8F8),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 30),
                child: Text(
                  'Шаг 3 / 5',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  // width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Positioned(
                    right: 32,
                    bottom: 16,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/google-map');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: globals.white,
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Image.asset(
                          'images/send.png',
                        ),
                        // child: Icon(
                        //   Icons.send,
                        //   size: 20,
                        // ),
                      ),
                    ))
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25, right: 16, left: 16, bottom: 80),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(18.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Color(0xFFDADADA), width: 1.0),
                  ),
                  filled: true,
                  fillColor: globals.white,
                  hintText: 'Ташкент',
                  hintStyle: TextStyle(
                      color: globals.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                style: TextStyle(color: globals.inputColor),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Продолжить',
          onClick: () {
            Get.toNamed('/step-4');
          },
        ),
      ),
    );
  }
}
