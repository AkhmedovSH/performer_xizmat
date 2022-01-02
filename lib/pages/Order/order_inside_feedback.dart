import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

class OrderInsideFeedback extends StatefulWidget {
  const OrderInsideFeedback({Key? key}) : super(key: key);

  @override
  _OrderInsideFeedbackState createState() => _OrderInsideFeedbackState();
}

class _OrderInsideFeedbackState extends State<OrderInsideFeedback> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/specialist-inside');
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: globals.inputColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('images/circle_avatar.png'),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Специалист окликнулся',
                      style: TextStyle(
                          fontSize: 14,
                          color: globals.lightGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      'Абдувасит Абдуманнобзода',
                      style: TextStyle(
                          fontSize: 16,
                          color: globals.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFF3A919),
                                  size: 18,
                                ),
                                Padding(padding: EdgeInsets.only(right: 5)),
                                Text('4,96',
                                    style: TextStyle(
                                        color: globals.black,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.feedback_outlined,
                                color: globals.lightGrey,
                              ),
                              Padding(padding: EdgeInsets.only(right: 5)),
                              Text('123',
                                  style: TextStyle(
                                      color: globals.lightGrey,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      'Здравствуйте, готов взяться за ва...',
                      style: TextStyle(
                          fontSize: 16,
                          color: globals.black,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                          colors: const [
                            Color(0xFFFF5353),
                            Color(0xFFF99247),
                          ],
                          begin: const FractionalOffset(0.0, 1.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Text(
                      '2',
                      style: TextStyle(
                          fontSize: 14,
                          color: globals.white,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
