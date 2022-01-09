import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        appBar: AppBar(),
        title: 'Верификация',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 35),
              child: Text(
                'Для полноценного использования приложения необходимо верифицировать вашу личность',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Transform.rotate(
                        angle: 45 * pi / 180,
                        child: IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: globals.red,
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Text(
                      'Прикрепить фото паспорта',
                      style: TextStyle(
                          color: globals.red,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: widgets.Button(
                text: 'Отправить',
                onClick: () {
                  Get.toNamed('/add-category');
                },
              ),
            ),
            Text(
              'Верифицироваться через менеджера',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFF707070), width: 1))),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/why-need-verification');
                },
                child: Text(
                  'Зачем нужна верификация?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF707070)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
