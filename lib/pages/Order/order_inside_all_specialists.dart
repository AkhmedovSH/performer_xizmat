import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class OrderInsideAllSpecialists extends StatefulWidget {
  const OrderInsideAllSpecialists({Key? key}) : super(key: key);

  @override
  _OrderInsideAllSpecialistsState createState() =>
      _OrderInsideAllSpecialistsState();
}

class _OrderInsideAllSpecialistsState extends State<OrderInsideAllSpecialists> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Меня зовут Абдувасит, я начинающий курьер. Среднее образование. Быстро',
                        style: TextStyle(
                            fontSize: 16,
                            color: globals.black,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    'Еще',
                    style: TextStyle(
                        fontSize: 14,
                        color: globals.red,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
