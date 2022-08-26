import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';

import '../../helpers/globals.dart';

import 'index.dart';
import 'balance.dart';
import 'profile.dart';
import 'support.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  dynamic user = {};

  changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      currentIndex = Get.arguments;
    }
  }

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response != null) {
      setState(() {
        user = response;
      });
    }
  }

  openDrawerBar() {
    getUser();
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: IndexedStack(
        index: currentIndex,
        children: [
          currentIndex == 0
              ? Index(
                  openDrawerBar: openDrawerBar,
                )
              : Container(),
          currentIndex == 1 ? const Balance() : Container(),
          currentIndex == 2 ? const Profile() : Container(),
          currentIndex == 3 ? const Support() : Container(),
        ],
      ),
      drawer: currentIndex == 0
          ? Container(
              padding: const EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Drawer(
                child: SafeArea(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              // width: double.infinity,
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/register');
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: user['imageUrl'] != null
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.network(
                                                mainUrl + user['imageUrl'],
                                                height: 64,
                                                width: 64,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Container(
                                              width: 64,
                                              height: 64,
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF8F8F8),
                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: lightGrey,
                                                ),
                                              ),
                                            ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 14),
                                        child: Text(
                                          '${user['name']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                right: 18,
                                top: 25,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 32,
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildListTile(
                          context,
                          'Новые заказы',
                          Icons.search,
                          '/',
                        ),
                        buildListTile(
                          context,
                          'Предложенные заказы',
                          Icons.category,
                          '/proposed-orders',
                        ),
                        buildListTile(
                          context,
                          'Текущие заказы',
                          Icons.list_alt,
                          '/current-orders',
                        ),
                        buildListTile(
                          context,
                          'Завершенные заказы',
                          Icons.support_agent,
                          '/completed-orders',
                        ),
                        buildListTile(
                          context,
                          'Баланс',
                          Icons.settings_suggest,
                          '/balance',
                        ),
                        buildListTile(
                          context,
                          'Поддержка',
                          Icons.settings_suggest,
                          '/support',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Container(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          // color: white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: -3, blurRadius: 5),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              onTap: changeIndex,
              currentIndex: currentIndex,
              backgroundColor: white,
              selectedItemColor: black,
              selectedIconTheme: IconThemeData(color: black),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Заказы'),
                BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF828282)), label: 'Баланс'),
                BottomNavigationBarItem(icon: Icon(Icons.person, color: Color(0xFF828282)), label: 'Профиль'),
                BottomNavigationBarItem(icon: Icon(Icons.headset_mic, color: Color(0xFF828282)), label: 'Поддержка'),
              ]),
        ),
      ),
    );
  }

  Widget buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    String routeName,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
      child: ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () => {
          if (routeName == '/') Navigator.pop(context),
          if (routeName == '/current-orders') Navigator.pop(context),
          if (routeName == '/proposed-orders') Navigator.pop(context),
          if (routeName == '/orders') Navigator.pop(context),
          if (routeName == '/order-by-manager') Get.toNamed('/order-by-manager'),
          if (routeName == '/support') changeIndex(3),
          // Navigator.pop(context),
        },
      ),
    );
  }
}
