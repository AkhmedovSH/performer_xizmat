import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: globals.black,
                        )),
                    suffixIcon: Icon(
                      Icons.cancel_sharp,
                      color: globals.red,
                      size: 20,
                    ),
                    contentPadding: EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF7F7F7),
                    hintText: 'Введите категорию',
                    hintStyle: TextStyle(
                        color: globals.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
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
                      'Репетиторство',
                      style: TextStyle(color: globals.black, fontSize: 18),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: globals.orange,
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
                      'Малярные услуги',
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
        )),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Сохранить',
          onClick: () {
            Get.toNamed('/category-inside');
          },
        ),
      ),
    );
  }
}
