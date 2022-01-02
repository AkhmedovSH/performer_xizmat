import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../globals.dart' as globals;

import '../components/bottom_bar.dart';
import '../components/drawer_app_bar.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Новые заказы'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
      ),
      drawer: Container(
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width * 0.95,
        child: DrawerAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'Популярное',
                      style: TextStyle(
                          color: globals.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/categories');
                    },
                    child: Row(
                      children: [
                        Text(
                          'Все категории',
                          style: TextStyle(
                              color: globals.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: globals.red,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 1; i < 7; i++)
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          width: 130,
                          height: 125,
                          margin: EdgeInsets.only(
                              right: 8.0, left: 8.0, bottom: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F7FA),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  'Услуги \n курьеров ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: globals.black),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image.asset(
                                  'images/c$i.png',
                                  height: 80,
                                  width: 100,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                            ],
                          )),
                    )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15, left: 16),
              child: Text(
                'Командные услуги',
                style: TextStyle(
                    color: globals.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, left: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: globals.red,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      margin: EdgeInsets.only(right: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                      child: Text(
                        'Лучшее',
                        style: TextStyle(
                            color: globals.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: globals.grey,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      margin: EdgeInsets.only(right: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                      child: Text(
                        'Персональные услуги ',
                        style: TextStyle(
                            color: globals.darkGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: globals.grey,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      margin: EdgeInsets.only(right: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                      child: Text(
                        'Персональные услуги ',
                        style: TextStyle(
                            color: globals.darkGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GridView.count(
              childAspectRatio: 0.92,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(0),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 2,
              children: [
                for (int i = 0; i < 6; i++)
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: globals.inputColor,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(0),
                                child: Image.asset('images/p$i.png',
                                    height: 105,
                                    width: double.infinity,
                                    fit: BoxFit.fill),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: 23, bottom: 10, right: 11, left: 11),
                                padding: EdgeInsets.symmetric(horizontal: 11),
                                child: Text(
                                  'Полная уборка квартиры',
                                  style: TextStyle(
                                    fontFamily: 'ProDisplay',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  '123 44 +',
                                  style: TextStyle(
                                    color: Color(0xFF9C9C9C),
                                    fontFamily: 'ProDisplay',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              top: 80,
                              left: MediaQuery.of(context).size.width * 0.18,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: globals.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 8),
                                child: Icon(
                                  Icons.build,
                                  color: Color(0xFF9C9C9C),
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        active: 0,
      ),
    );
  }
}
