import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../globals.dart' as globals;

import '../../components/bottom_bar.dart';
import '../../components/drawer_app_bar.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({Key? key}) : super(key: key);

  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Завершенные заказы',
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
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 4; i++)
              GestureDetector(
                onTap: () {
                  Get.toNamed('/about-completed-order');
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
