import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../../widgets.dart' as widgets;

import '../../components/bottom_bar.dart';
import '../../../components/simple_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic profile = [
    {
      'name': 'Специальности',
      'description': 'Выбор специальностей, редактирование услуг и цен на них',
      'onClick': () {
        Get.toNamed('/speciality');
      }
    },
    {
      'name': 'Районы и адреса',
      'description': 'Где вам удобно работать, принимаете ли вы клиентов у себя'
    },
    {'name': 'Фото ваших работ', 'description': 'Их видят клиенты'},
    {
      'name': 'О себе',
      'description': 'Образование, опыт работы и кратко о себе'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Поддержка',
        appBar: AppBar(),
        leading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                      width: 86,
                      height: 86,
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'images/circle_avatar.png',
                            height: 86,
                            width: 86,
                          ))),
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
                'Абдувасит Абдуманнобзода Бахтиярович',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                '+998 (90) 123 45 67',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: globals.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Вы не завершили проверку',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text('Осталось несколько шагов',
                  style: TextStyle(
                      color: globals.lightGrey,
                      fontSize: 17,
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(55, 15, 55, 30),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/verification');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Продолжить проверку',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 30, 16, 15),
              decoration: BoxDecoration(
                  color: globals.inputColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Column(
                children: [
                  for (var i = 0; i < profile.length; i++)
                    GestureDetector(
                      onTap: profile[i]['onClick'],
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFFDADADA), width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  profile[i]['name'],
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.edit,
                                  color: globals.black,
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, right: 50),
                              child: Text(
                                profile[i]['description'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF707070)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFDADADA), width: 1))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Удалить аккаунт',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.delete,
                          color: globals.red,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFDADADA), width: 1))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Выйти',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.logout,
                          color: globals.red,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
