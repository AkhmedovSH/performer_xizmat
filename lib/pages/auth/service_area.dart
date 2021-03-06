import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class ServiceArea extends StatefulWidget {
  const ServiceArea({Key? key}) : super(key: key);

  @override
  _ServiceAreaState createState() => _ServiceAreaState();
}

class _ServiceAreaState extends State<ServiceArea> {
  dynamic isChecked = false;

  changeDeparture() async {
    final user = await get('/services/executor/api/get-info');
    dynamic sendData = {};
    sendData = user;
    sendData['departure'] = isChecked;
    final response = await put('/services/executor/api/update-executor', user);
    if (response != null) {
      Get.toNamed('/upload-photo');
    }
  }

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response != null) {
      setState(() {
        isChecked = response['departure'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Территория оказания услуг',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 13),
                          child: Icon(Icons.drive_eta),
                        ),
                        Text(
                          'Выезжаю к клиенту',
                          style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Switch(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value;
                          });
                        },
                        activeTrackColor: inputColor,
                        activeColor: darkRed,
                      ),
                    )
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 23),
              //   child: Center(
              //     child: Text(
              //       'или',
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed('/choose-regions');
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 16),
              //     decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Выбрать районы',
              //           style: TextStyle(color: black, fontSize: 18),
              //         ),
              //         SizedBox(
              //           child: Icon(
              //             Icons.arrow_forward,
              //             color: black,
              //             size: 28,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Применить',
          onClick: () {
            Get.toNamed('/upload-photo');
            // changeDeparture();
          },
        ),
      ),
    );
  }
}
