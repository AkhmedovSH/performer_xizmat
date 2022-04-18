import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class CategoryInside extends StatefulWidget {
  const CategoryInside({Key? key}) : super(key: key);

  @override
  _CategoryInsideState createState() => _CategoryInsideState();
}

class _CategoryInsideState extends State<CategoryInside> {
  dynamic items = [
    {'name': 'Чистка мебели'},
    {'name': 'Чистка мебели'},
    {'name': 'Чистка мебели'},
    {'name': 'Чистка мебели'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Категория',
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: globals.borderColor))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('Клининговые услуги',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Icon(
                      Icons.delete,
                      color: globals.lightGrey,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Услуги',
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              for (var i = 0; i < items.length; i++)
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFDADADA), width: 1))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        items[i]['name'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16))),
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                'Спасибо',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Color(0xFF363F4D)),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              child: Text(
                                                'Сейчас менеджеры проверяют ваши данные',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 16),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                child:
                                                    Text('Посмотреть заказы'),
                                                onPressed: () => Get.back(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: 10,
                                          child: IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: globals.black,
                                                size: 32,
                                              )))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: globals.lightGrey,
                          ))
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Добавить услугу',
          onClick: () {
            Get.toNamed('/add-category');
          },
        ),
      ),
    );
  }
}
