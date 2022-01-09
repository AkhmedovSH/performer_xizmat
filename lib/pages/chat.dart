import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import '../globals.dart' as globals;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back)),
                    Container(
                      padding: EdgeInsets.all(13),
                      margin: EdgeInsets.only(left: 15, right: 18),
                      decoration: BoxDecoration(
                          color: globals.borderColor,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Icon(
                        Icons.person,
                        color: globals.lightGrey,
                      ),
                    ),
                    Text('Евгений',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 28,
                      color: globals.darkRed,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: Text(
                          '09.09.2021',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: globals.borderColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  'Здравствуйте, заинтересовал ваш заказ. Мы занимаемся доставкой в любую точку города. Готовы сотрудничать.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 1.3),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'images/circle_avatar.png',
                                      height: 64,
                                      width: 64,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          child: Text(
                            '17:00',
                            style: TextStyle(
                                color: globals.lightGrey,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: globals.borderColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                    child: Icon(
                                      Icons.person,
                                      color: globals.lightGrey,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: globals.borderColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  'Здравствуйте, заинтересовал ваш заказ. Мы занимаемся доставкой в любую точку города. Готовы сотрудничать.',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      height: 1.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          child: Text(
                            '20:00',
                            style: TextStyle(
                                color: globals.lightGrey,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  decoration: BoxDecoration(
                      color: globals.white,
                      border: Border(
                          top: BorderSide(
                              width: 1, color: globals.borderColor))),
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
                            primary: globals.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            'Принять заказ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: globals.white),
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
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            'Отказаться',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: globals.black),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: globals.borderColor,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      margin: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Color(0xFFE5E5EA), width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Color(0xFFE5E5EA), width: 1.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Ваше сообщение...',
                          hintStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: 315 * pi / 180,
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: globals.darkRed,
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
