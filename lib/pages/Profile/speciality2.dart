import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class Speciality2 extends StatefulWidget {
  const Speciality2({Key? key}) : super(key: key);

  @override
  _Speciality2State createState() => _Speciality2State();
}

class _Speciality2State extends State<Speciality2> {
  dynamic items = [];

  getCategories() async {
    final response = await get('/services/executor/api/category-child-list/${Get.arguments}');
    setState(() {
      items = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Мои специальности',
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text('Категории', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              for (var i = 0; i < items.length; i++)
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/speciality-3', arguments: items[i]['id']);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFDADADA), width: 1))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          items[i]['name'],
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: globals.black,
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Добавить категорию',
          onClick: () {
            Get.toNamed('/add-category');
          },
        ),
      ),
    );
  }
}
