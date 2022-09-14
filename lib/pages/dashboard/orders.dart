import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:xizmat/helpers/api.dart';
import '../../helpers/globals.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int currentIndex = 0;
  dynamic orders = [];

  changeTab(index) {
    setState(() {
      currentIndex = index;
      orders = [];
    });
    if (index == 0) {
      getPurposed();
    }
    if (index == 1) {
      getCurrent();
    }
    if (index == 2) {
      getCompleted();
    }
  }

  getPurposed() async {
    final response = await get('/services/executor/api/order-list/100');
    print(response);
    setState(() {
      orders = response;
    });
  }

  getCurrent() async {
    final response = await get('/services/executor/api/order-list/1');
    setState(() {
      orders = response;
    });
  }

  getCompleted() async {
    final response = await get('/services/executor/api/order-list/2');
    print(response);
    setState(() {
      orders = response;
    });
  }

  setComplete(item) async {
    print(item);
    final response = await post('/services/mobile/api/order-completed', {
      "id": item['id'],
      "executorId": item['executorId'],
      "rating": 4.5,
      "rating_text": "buladi",
    });
    print(response);
    getCompleted();
  }

  @override
  void initState() {
    super.initState();
    getPurposed();
  }

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
                      changeTab(index);
                    },
                    labelColor: black,
                    indicatorColor: orange,
                    indicatorWeight: 2,
                    labelStyle: TextStyle(fontSize: 12.0, color: black, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: TextStyle(fontSize: 12.0, color: Color(0xFF9B9B9B)),
                    // controller: ,
                    tabs: const [
                      Tab(
                        text: 'Предложенные',
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
                  for (var i = 0; i < orders.length; i++)
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/order-inside', arguments: orders[i]['id']);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          color: inputColor,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '№ ${orders[i]['orderNumber']}',
                                    style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  // currentIndex == 0
                                  //     ? Row(
                                  //         children: [
                                  //           Container(
                                  //             margin: EdgeInsets.only(right: 5),
                                  //             height: 4,
                                  //             width: 4,
                                  //             decoration: BoxDecoration(
                                  //               color: Color(0xFFE32F45),
                                  //               shape: BoxShape.circle,
                                  //             ),
                                  //           ),
                                  //           Text('${orders[i]['countExecutors']} откликов',
                                  //               style: TextStyle(color: Color(0xFFE32F45), fontWeight: FontWeight.w500)),
                                  //         ],
                                  //       )
                                  //     : Container(),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${orders[i]['categoryChildName']}',
                                  style: TextStyle(color: black, fontSize: 18),
                                ),
                                Icon(Icons.arrow_forward, color: black)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
