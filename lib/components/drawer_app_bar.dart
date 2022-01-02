import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../globals.dart' as globals;

class DrawerAppBar extends StatefulWidget {
  const DrawerAppBar({Key? key}) : super(key: key);

  @override
  _DrawerAppBarState createState() => _DrawerAppBarState();
}

class _DrawerAppBarState extends State<DrawerAppBar> {
  Widget buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    String routeName,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
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
          // Navigator.pop(context),
          if (routeName == '/') Get.offAllNamed('/'),
          if (routeName == '/fast-search') Get.toNamed('/fast-search'),
          if (routeName == '/categories') Get.toNamed('/categories'),
          if (routeName == '/orders') Get.toNamed('/orders'),
          if (routeName == '/order-by-manager')
            Get.toNamed('/order-by-manager'),
          if (routeName == '/support') Get.toNamed('/support'),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                            child: CircleAvatar(
                              radius: 30.0,
                              child: Icon(
                                Icons.person,
                                color: globals.red,
                              ),
                              // backgroundImage: NetworkImage(
                              //   'https://via.placeholder.com/150',
                              // ),
                              backgroundColor: Color(0xFFF8F8F8),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 14),
                            child: Text(
                              'Войти',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward),
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
                'Быстрый поиск',
                Icons.search,
                '/fast-search',
              ),
              buildListTile(
                context,
                'Категории услуг',
                Icons.category,
                '/categories',
              ),
              buildListTile(
                context,
                'Мои заказы',
                Icons.list_alt,
                '/orders',
              ),
              buildListTile(
                context,
                'Заказать через менеджера',
                Icons.support_agent,
                '/order-by-manager',
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
    );
  }
}
