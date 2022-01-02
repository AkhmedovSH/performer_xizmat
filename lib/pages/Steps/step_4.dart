import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Step4 extends StatefulWidget {
  const Step4({Key? key}) : super(key: key);

  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  dynamic character = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Дата и время исполнения',
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
                percent: 0.8,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: globals.red,
                backgroundColor: Color(0xFFF8F8F8),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  'Шаг 4 / 5',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          contentPadding: EdgeInsets.all(18.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Color(0xFFDADADA), width: 1.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF8F8F8),
                          hintText: 'дд/мм/гг',
                          hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                        ),
                        style: TextStyle(color: globals.inputColor),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.schedule),
                          contentPadding: EdgeInsets.all(18.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Color(0xFFDADADA), width: 1.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF8F8F8),
                          hintText: '00:00',
                          hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                        ),
                        style: TextStyle(color: globals.inputColor),
                      )),
                ],
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
            Get.toNamed('/step-5');
          },
        ),
      ),
    );
  }
}
