import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:xizmat/helpers/api.dart';
import '../../helpers/globals.dart' as globals;

import '../../components/drawer_app_bar.dart';

class CurrentOrders extends StatefulWidget {
  const CurrentOrders({Key? key}) : super(key: key);

  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic orders = [];

  orderCompleted(id) async {
    final response = await post('/services/executor/api/order-completed', {
      "id": id,
    });
    print(response);
    getOrders();
  }

  getOrders() async {
    final response = await get('/services/executor/api/order-list/1');
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
          'Текущие заказы',
          style: TextStyle(color: globals.black),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
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
                Container(
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
                        child: Text('бюджет: ${orders[i]['orderAmount']} сум',
                            style: TextStyle(fontSize: 16, color: globals.lightGrey, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text('Дата исполнения: ${orders[i]['executionDate']}, ${orders[i]['executionTime']}',
                            style: TextStyle(fontSize: 14, color: globals.lightGrey, fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              // margin: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  orderCompleted(orders[i]['id']);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Завершить',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  elevation: 0,
                                  primary: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: globals.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Написать',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: globals.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.close,
                                color: globals.darkGrey,
                              ),
                            ),
                            Text(
                              'Отказаться от исполнения',
                              style: TextStyle(color: globals.darkGrey, fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
