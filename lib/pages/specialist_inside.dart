import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../globals.dart' as globals;
import '../widgets.dart' as widgets;

import '../components/simple_app_bar.dart';

class SpecialistInside extends StatefulWidget {
  const SpecialistInside({Key? key}) : super(key: key);

  @override
  _SpecialistInsideState createState() => _SpecialistInsideState();
}

class _SpecialistInsideState extends State<SpecialistInside> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppBar(
          title: 'Об исполнителе',
          appBar: AppBar(),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'images/circle_avatar.png',
                                height: 100,
                                width: 64,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text(
                                    'Абдувасит Абдуманнобзода Бахтиярович',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: globals.black,
                                        fontWeight: FontWeight.bold),
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5)),
                                              Text('4,96',
                                                  style: TextStyle(
                                                      color: globals.black,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.feedback_outlined,
                                              color: globals.lightGrey,
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5)),
                                            Text('123',
                                                style: TextStyle(
                                                    color: globals.lightGrey,
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: globals.inputColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              'О себе',
                              style: TextStyle(
                                  color: globals.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                              'Имею большой опыт работы в Ташкенте с 2017 года в сфере репетиторства.',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        'Сертификаты и документы',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var i = 0; i < 4; i++)
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Image.asset(
                                'images/sertificat.png',
                                height: 100,
                                width: 80,
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15),
                      child: Text(
                        'Услуги',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Column(
                      children: [
                        for (var i = 0; i < 3; i++)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  color: Color(0xFFDADADA), width: 1.0),
                            )),
                            child: Text(
                              'Занятия по высшей математике',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15),
                      child: Text(
                        'Портфолио',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var i = 0; i < 4; i++)
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Image.asset(
                                'images/portofolio.png',
                                height: 120,
                                width: 150,
                              ),
                            )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15),
                      child: Text(
                        'Отзывы об исполнителе',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Column(
                      children: [
                        for (var i = 0; i < 5; i++)
                          Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: globals.inputColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Гульмирова Гульноза',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '02.05.2021',
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 10),
                                  child: Row(
                                    children: [
                                      for (var i = 0; i < 5; i++)
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.star,
                                            color: globals.yellow,
                                            size: 16,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                Text(
                                    'Обучает моего сына уже три года. Уровень английского просто на высоте. Настоящий практик и знаток своего дела.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: widgets.OutlinedButton(
                        text: 'Показать еще отзывы',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                              padding: EdgeInsets.symmetric(vertical: 8),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Предложить заказ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
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
                              'Написать',
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
        ));
  }
}
