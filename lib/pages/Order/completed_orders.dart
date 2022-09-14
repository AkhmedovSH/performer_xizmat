import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';
import '../../helpers/globals.dart' as globals;

import '../../components/drawer_app_bar.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({Key? key}) : super(key: key);

  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic orders = [];

  getOrders() async {
    final response = await get('/services/executor/api/order-list/2');
    print(response);
    setState(() {
      orders = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
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
      drawer: DrawerAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < orders.length; i++)
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/about-completed-order', arguments: orders[i]['id']);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: globals.inputColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('№ ${orders[i]['orderNumber']}', style: TextStyle(fontWeight: FontWeight.w500)),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 5),
                          child: Text('${orders[i]['categoryChildName']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text('бюджет:${orders[i]['orderAmount']} сум',
                              style: TextStyle(fontSize: 16, color: globals.lightGrey, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
