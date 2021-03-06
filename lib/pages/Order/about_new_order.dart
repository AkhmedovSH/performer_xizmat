import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../helpers/globals.dart' as globals;

import '../../components/simple_app_bar.dart';

class AboutNewOrder extends StatefulWidget {
  const AboutNewOrder({Key? key}) : super(key: key);

  @override
  _AboutNewOrderState createState() => _AboutNewOrderState();
}

class _AboutNewOrderState extends State<AboutNewOrder> {
  int currentIndex = 0;
  final Completer<GoogleMapController> _controller = Completer();
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        'Занятия по высшей математике',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
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
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    decoration: BoxDecoration(
                      color: globals.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: -3,
                            blurRadius: 5),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          // margin: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              elevation: 0,
                              primary: globals.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Откликнуться',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: globals.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              elevation: 0,
                              primary: globals.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: globals.black),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Написать',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: globals.black),
                            ),
                          ),
                        )
                      ],
                    )))
          ],
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
