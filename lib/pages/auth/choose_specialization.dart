import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class ChooseSpecialization extends StatefulWidget {
  const ChooseSpecialization({Key? key}) : super(key: key);

  @override
  _ChooseSpecializationState createState() => _ChooseSpecializationState();
}

class _ChooseSpecializationState extends State<ChooseSpecialization> {
  dynamic character = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Электрика',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  'Выберите специализацию',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: globals.darkRed,
                    ),
                    contentPadding: EdgeInsets.all(18.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          BorderSide(color: Color(0xFFECECEC), width: 0.0),
                    ),
                    filled: true,
                    fillColor: globals.inputColor,
                    hintText: 'Поиск',
                    hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                  ),
                  style: TextStyle(color: globals.inputColor),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Установка разеток',
                      style: TextStyle(color: globals.black, fontSize: 18),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: globals.darkRed,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.check,
                        color: globals.white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Замена проводки',
                      style: TextStyle(color: globals.black, fontSize: 18),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: globals.darkGrey),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.check,
                        color: globals.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Продолжить',
          onClick: () {
            Get.toNamed('/service-area');
          },
        ),
      ),
    );
  }
}
