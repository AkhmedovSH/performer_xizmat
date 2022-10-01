import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class Speciality extends StatefulWidget {
  const Speciality({Key? key}) : super(key: key);

  @override
  _SpecialityState createState() => _SpecialityState();
}

class _SpecialityState extends State<Speciality> {
  dynamic items = [];

  getCategories() async {
    final response = await get('/services/executor/api/category-list');
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
        title: 'my_specialties'.tr,
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
                child: Text(
                  'categories'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (var i = 0; i < items.length; i++)
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/speciality-2', arguments: {'id': items[i]['id'], 'value': Get.arguments});
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
