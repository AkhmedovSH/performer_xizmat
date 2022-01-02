import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import './order_inside_feedback.dart';
import './order_inside_all_specialists.dart';

import '../../components/simple_app_bar.dart';

class OrderInside extends StatefulWidget {
  const OrderInside({Key? key}) : super(key: key);

  @override
  _OrderInsideState createState() => _OrderInsideState();
}

class _OrderInsideState extends State<OrderInside> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppBar(
          title: '№ 345 666',
          appBar: AppBar(),
        ),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 13, bottom: 20),
                    child: Text(
                      'Мужская стрижка',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: globals.black),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: globals.inputColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 0;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: currentIndex == 0
                                    ? globals.white
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Отклики',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentIndex == 0
                                            ? globals.black
                                            : globals.lightGrey,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.44,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: currentIndex == 1
                                    ? globals.white
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Все специалисты',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: currentIndex == 1
                                            ? globals.black
                                            : globals.lightGrey,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      currentIndex == 0
                          ? OrderInsideFeedback()
                          : OrderInsideAllSpecialists()
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                bottom: 0,
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
                              primary: globals.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: globals.red),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Text(
                              'Написать специалисту',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: globals.red),
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
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Text(
                              'Отменить заказ',
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
