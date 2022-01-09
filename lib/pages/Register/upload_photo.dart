import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  dynamic character = 1;
  dynamic lights = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Загрузите фотографию',
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Клиенты больше доверяют специалистам с фото.  Потом его можно будет поменять в анкете.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                width: 100,
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                decoration: BoxDecoration(
                    color: globals.borderColor,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Icon(
                  Icons.person,
                  color: Color(0xFFDADADA),
                  size: 42,
                ),
              ),
            ),
            Center(
              child: Text(
                'Прикрепить фото',
                style: TextStyle(
                    color: globals.darkRed,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Далее',
          onClick: () {
            Get.toNamed('/');
          },
        ),
      ),
    );
  }
}
