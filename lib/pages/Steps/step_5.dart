import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Step5 extends StatefulWidget {
  const Step5({Key? key}) : super(key: key);

  @override
  _Step5State createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  dynamic character = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Бюджет услуги (сум)',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 6.0,
                animationDuration: 500,
                percent: 1,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: globals.red,
                backgroundColor: Color(0xFFF8F8F8),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  'Шаг 5 / 5',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Бюджет услуги',
                style: TextStyle(
                    color: globals.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(18.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
                  ),
                  filled: true,
                  fillColor: globals.inputColor,
                  hintText: 'Введите сумму',
                  hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                ),
                style: TextStyle(color: globals.inputColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Примечание к заказу',
                style: TextStyle(
                    color: globals.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(18.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
                  ),
                  filled: true,
                  fillColor: globals.inputColor,
                  hintText: 'Введите текст...',
                  hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                ),
                minLines: 8,
                maxLines: 10,
                style: TextStyle(color: globals.inputColor),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Опубликовать заказ',
          onClick: () {
            Get.toNamed('/success');
          },
        ),
      ),
    );
  }
}
