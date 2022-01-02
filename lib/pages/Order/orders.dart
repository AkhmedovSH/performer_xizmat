import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../globals.dart' as globals;

import '../../components/bottom_bar.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    labelColor: globals.black,
                    indicatorColor: globals.orange,
                    indicatorWeight: 2,
                    labelStyle: TextStyle(
                        fontSize: 14.0,
                        color: globals.black,
                        fontWeight: FontWeight.w500),
                    unselectedLabelStyle:
                        TextStyle(fontSize: 14.0, color: Color(0xFF9B9B9B)),
                    // controller: ,
                    tabs: const [
                      Tab(
                        text: 'Новые',
                      ),
                      Tab(
                        text: 'Текущие',
                      ),
                      Tab(
                        text: 'Завершенные',
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/order-inside');
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: globals.inputColor,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 11),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '№ 345 666',
                                    style: TextStyle(
                                        color: globals.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  currentIndex == 0
                                      ? Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              height: 4,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE32F45),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text('345 откликов',
                                                style: TextStyle(
                                                    color: Color(0xFFE32F45),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Мужская стрижка',
                                  style: TextStyle(
                                      color: globals.black, fontSize: 18),
                                ),
                                Icon(Icons.arrow_forward, color: globals.black)
                              ],
                            ),
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/order-inside');
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: globals.inputColor,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 11),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '№ 345 666',
                                    style: TextStyle(
                                        color: globals.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  currentIndex == 0
                                      ? Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              height: 4,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE32F45),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text('345 откликов',
                                                style: TextStyle(
                                                    color: Color(0xFFE32F45),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Мужская стрижка',
                                  style: TextStyle(
                                      color: globals.black, fontSize: 18),
                                ),
                                Icon(Icons.arrow_forward, color: globals.black)
                              ],
                            ),
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/order-inside');
                    },
                    child: Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: globals.inputColor,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 11),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '№ 345 666',
                                    style: TextStyle(
                                        color: globals.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  currentIndex == 0
                                      ? Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 5),
                                              height: 4,
                                              width: 4,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFE32F45),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text('345 откликов',
                                                style: TextStyle(
                                                    color: Color(0xFFE32F45),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Мужская стрижка',
                                  style: TextStyle(
                                      color: globals.black, fontSize: 18),
                                ),
                                Icon(Icons.arrow_forward, color: globals.black)
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Container(
                width: double.infinity,
                height: double.infinity,
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
                child: Icon(
                  Icons.add,
                  size: 26,
                ),
              ))
          : Container(),
      bottomNavigationBar: BottomBar(
        active: 1,
      ),
    );
  }
}
