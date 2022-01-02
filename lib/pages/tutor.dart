import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../globals.dart' as globals;
import '../widgets.dart' as widgets;

import '../components/simple_app_bar.dart';

class Tutor extends StatefulWidget {
  const Tutor({Key? key}) : super(key: key);

  @override
  _TutorState createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  List tutors = [
    {'name': 'Английский язык', 'active': true},
    {'name': 'Математика', 'active': false},
    {'name': 'Физика', 'active': false},
    {'name': 'Китайский язык', 'active': false},
    {'name': 'Химия', 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Репетитор',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < tutors.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(vertical: 21),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xFFF2F2F2)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tutors[i]['name'],
                          style: TextStyle(color: globals.black, fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward,
                            color: tutors[i]['active']
                                ? globals.black
                                : Color(0xFFDADADA))
                      ],
                    ),
                  ),
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50, bottom: 5),
                child: Text(
                  'Заказать услугу через менеджера',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: widgets.Button(
                text: 'Заказать',
                onClick: () => {Get.toNamed('/step-1')},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Наш менеджер проконсультирует вас и поможет найти специалиста под вашу задачу.',
                style: TextStyle(
                    color: globals.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: Container(
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Container(
      //         child: Text(
      //           'Заказать услугу через менеджера',
      //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
