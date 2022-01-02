import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../components/bottom_bar.dart';
import '../../components/simple_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic profile = [
    {'name': 'Уведомления', 'icon': Icon(Icons.notifications)},
    {'name': 'Настройки', 'icon': Icon(Icons.settings)},
    {'name': 'Удалить аккаунт', 'icon': Icon(Icons.delete)},
    {'name': 'Выйти', 'icon': Icon(Icons.logout)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Поддержка',
        appBar: AppBar(),
        leading: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 86,
                      height: 86,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: globals.lightGrey,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 20,
                      right: 20,
                      child: Icon(
                        Icons.edit,
                        color: globals.red,
                        size: 28,
                      ))
                ],
              ),
              Center(
                child: Text(
                  'Бахтиёр',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: globals.black),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              Center(
                child: Text(
                  '+998 (90) 123 45 67',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: globals.black),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: globals.inputColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                children: [
                  for (var i = 0; i < profile.length; i++)
                    Container(
                      padding: EdgeInsets.only(bottom: 21),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Color(0xFFE8E8E8)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            profile[i]['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: globals.black),
                          ),
                          profile[i]['icon']
                        ],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(
        active: 2,
      ),
    );
  }
}
