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
        title: Text(
          'Новые заказы',
          style: TextStyle(color: globals.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: globals.black,
          ),
        ),
        actions: [
          Container(),
        ],
      ),
      drawer: Container(
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width * 0.95,
        child: DrawerAppBar(),
      ),
      endDrawer: Container(
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Drawer(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Фильтр',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Подбор заказов по параметрам',
                                  style: TextStyle(
                                      color: globals.lightGrey,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Бюджет (сум)',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'От',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.38,
                                // height: 30,
                                child: TextField(
                                    decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5.0),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF9C9C9C)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: globals.red),
                                  ),
                                  hintText: '0',
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF9C9C9C)),
                                )),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'До',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  // height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(5.0),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF9C9C9C)),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: globals.red),
                                      ),
                                      hintText: '123 000 000',
                                      hintStyle: const TextStyle(
                                          color: Color(0xFF9C9C9C)),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Дата исполнения',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'От',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  // height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_today),
                                      contentPadding: EdgeInsets.all(18.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      filled: true,
                                      fillColor: globals.borderColor,
                                      hintText: 'дд/мм/гг',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9C9C9C),
                                          fontSize: 14),
                                    ),
                                  ))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'До',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  // height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_today),
                                      contentPadding: EdgeInsets.all(18.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      filled: true,
                                      fillColor: globals.borderColor,
                                      hintText: 'дд/мм/гг',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9C9C9C),
                                          fontSize: 14),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Время исполнения',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'От',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  // height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.schedule),
                                      contentPadding: EdgeInsets.all(18.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      filled: true,
                                      fillColor: globals.borderColor,
                                      hintText: '00:00',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9C9C9C),
                                          fontSize: 14),
                                    ),
                                  ))
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  'До',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                  // height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.schedule),
                                      contentPadding: EdgeInsets.all(18.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: Color(0xFFDADADA),
                                            width: 1.0),
                                      ),
                                      filled: true,
                                      fillColor: globals.borderColor,
                                      hintText: '00:00',
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9C9C9C),
                                          fontSize: 14),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: globals.borderColor, width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close, color: globals.darkRed),
                          Text(
                            'ЗАКРЫТЬ',
                            style: TextStyle(
                                color: globals.darkRed,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 7),
                        child: Icon(
                          Icons.filter_list,
                          color: globals.darkRed,
                          size: 28,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Сортировка',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          Text(
                            'по бюджету',
                            style: TextStyle(
                                color: globals.lightGrey,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 7),
                        child: Icon(
                          Icons.filter_alt,
                          color: globals.darkRed,
                          size: 28,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Фильтры',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          Text(
                            'Не выбраны',
                            style: TextStyle(
                                color: globals.lightGrey,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            for (var i = 0; i < 4; i++)
              GestureDetector(
                onTap: () {
                  Get.toNamed('/order-inside');
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: globals.inputColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('№ 345 666',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, bottom: 5),
                        child: Text('Занятия по высшей математике',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text('бюджет:400 000 сум',
                            style: TextStyle(
                                fontSize: 16,
                                color: globals.lightGrey,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text('Дата исполнения: 09.20.2021, 13:00',
                            style: TextStyle(
                                fontSize: 14,
                                color: globals.lightGrey,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
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
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Откликнуться',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed('/chat');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  elevation: 0,
                                  primary: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: globals.black),
                                    borderRadius: BorderRadius.circular(4),
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      )),
      bottomNavigationBar: BottomBar(
        active: 0,
      ),
    );
  }
}
