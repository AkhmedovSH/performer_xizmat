import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xizmat/helpers/api.dart';
import 'package:xizmat/helpers/globals.dart';

class DrawerAppBar extends StatefulWidget {
  Map? user = {};
  Function? changeIndex = () {};
  DrawerAppBar({Key? key, this.user, this.changeIndex}) : super(key: key);

  @override
  State<DrawerAppBar> createState() => _DrawerAppBarState();
}

class _DrawerAppBarState extends State<DrawerAppBar> {
  dynamic user = {};

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response != null) {
      setState(() {
        user = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          if (routeName == '/') Get.offAllNamed('/'),
          if (routeName == '/current-orders') Get.toNamed('/current-orders'),
          if (routeName == '/proposed-orders') Get.toNamed('/proposed-orders'),
          if (routeName == '/orders') Navigator.pop(context),
          if (routeName == '/completed-orders') Get.toNamed('/completed-orders'),
          if (routeName == '/order-by-manager') Get.toNamed('/order-by-manager'),
          if (routeName == '/support') Get.offAllNamed('/', arguments: 3),
          // Navigator.pop(context),
        },
      ),
    );
  }
}
