import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class AboutCompletedOrder extends StatefulWidget {
  const AboutCompletedOrder({Key? key}) : super(key: key);

  @override
  _AboutCompletedOrderState createState() => _AboutCompletedOrderState();
}

class _AboutCompletedOrderState extends State<AboutCompletedOrder> {
  int currentIndex = 0;
  Completer<GoogleMapController> _controller = Completer();
  dynamic character = 1;

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(41.311081, 69.240562), zoom: 13.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppBar(
          title: '№ 345 666',
          appBar: AppBar(),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 5),
                  child: Text(
                    'Занятия по высшей математике',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Text('бюджет:400 000 сум',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: globals.lightGrey))),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text('Дата исполнения',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: globals.lightGrey))),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text('09.20.2021, 13:00',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF444444)))),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text('Место оказания',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: globals.lightGrey))),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text('Ташкент, Яккасарайский район',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF444444)))),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: [
                      SizedBox(
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
                          right: 16,
                          bottom: 16,
                          child: GestureDetector(
                            onTap: () {
                              // Get.toNamed('/google-map');
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
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text('Заказчик',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: globals.lightGrey))),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Image.asset('images/circle_avatar.png'),
                      ),
                      Text('Абдувасит Абдуманнобзода',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text('Примечание',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: globals.lightGrey))),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                        'Нужно провести 10 уроков по математике так, чтобы мой сын гуманитарий - лоботряс поступил в нефтехазовый институт.',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF444444)))),
              ],
            ),
          ),
        )
        // floatingActionButton: Container(
        //   width: MediaQuery.of(context).size.width,
        //   margin: EdgeInsets.only(left: 32),
        //   child: ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       padding: EdgeInsets.symmetric(vertical: 8),
        //       elevation: 0,
        //       primary: globals.white,
        //       shape: RoundedRectangleBorder(
        //         side: BorderSide(color: globals.red),
        //         borderRadius: BorderRadius.circular(7),
        //       ),
        //     ),
        //     child: Container(
        //       child: Text(
        //         'Онлайн чат',
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 17,
        //             color: globals.black),
        //       ),
        //     ),
        //   ),
        // )
        );
  }
}
