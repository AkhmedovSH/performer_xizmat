import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class ServiceArea extends StatefulWidget {
  const ServiceArea({Key? key}) : super(key: key);

  @override
  _ServiceAreaState createState() => _ServiceAreaState();
}

class _ServiceAreaState extends State<ServiceArea> {
  dynamic character = 1;
  dynamic lights = false;

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
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
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
                          style: TextStyle(
                              color: globals.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 1.2,
                      child: Switch(
                          value: lights,
                          onChanged: (value) {
                            setState(() {
                              lights = value;
                              print(lights);
                            });
                          },
                          activeTrackColor: globals.inputColor,
                          activeColor: globals.darkRed),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 23),
                child: Center(
                  child: Text(
                    'или',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Выбрать районы',
                      style: TextStyle(color: globals.black, fontSize: 18),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: globals.black,
                        size: 28,
                      ),
                    )
                  ],
                ),
              ),
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
          },
        ),
      ),
    );
  }
}
