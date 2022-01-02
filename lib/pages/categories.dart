import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../globals.dart' as globals;

import '../components/simple_app_bar.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: 'Категории услуг', appBar: AppBar(),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              childAspectRatio: 1.25,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(0),
              // crossAxisSpacing: 4,
              crossAxisCount: 2,
              children: [
                for (var i = 1; i < 8; i++)
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin:
                            EdgeInsets.only(right: 8.0, left: 8.0, bottom: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F7FA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              child: Text(
                                'Услуги курьеров ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: globals.black),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                'images/c$i.png',
                                height: 80,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                          ],
                        )),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
