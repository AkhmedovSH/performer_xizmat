import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class WhyNeedVerification extends StatefulWidget {
  const WhyNeedVerification({Key? key}) : super(key: key);

  @override
  _WhyNeedVerificationState createState() => _WhyNeedVerificationState();
}

class _WhyNeedVerificationState extends State<WhyNeedVerification> {
  dynamic items = [
    {'text': 'Для принятия заказов'},
    {'text': 'Для защиты ваших интересов'},
    {'text': 'Для пополнения баланса'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        appBar: AppBar(),
        title: '',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 35),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 25, top: 25),
              child: Text('Зачем нужна верификация?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            for (var i = 0; i < items.length; i++)
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        '0${i + 1}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      items[i]['text'],
                      style: TextStyle(
                          color: Color(0xFF707070),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            Container(
                margin: EdgeInsets.only(top: 55, bottom: 25),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_back, color: globals.red),
                      ),
                      Text(
                        'Пройти верификацию',
                        style: TextStyle(
                            color: globals.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
            Text(
              'Верифицироваться через менеджера',
              style: TextStyle(
                  color: globals.lightGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
