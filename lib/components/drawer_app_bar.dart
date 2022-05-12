import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          Get.offAllNamed(routeName)
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
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  'images/circle_avatar.png',
                                  height: 64,
                                  width: 64,
                                )
                                // backgroundImage: NetworkImage(
                                //   'https://via.placeholder.com/150',
                                // ),
                                // backgroundColor: globals.borderColor,
                                ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 14),
                              child: Text(
                                'Абдувасит Абдуманнобзода',
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
    );
  }
}
