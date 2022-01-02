import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../globals.dart' as globals;

class FastSearch extends StatefulWidget {
  const FastSearch({Key? key}) : super(key: key);

  @override
  _FastSearchState createState() => _FastSearchState();
}

class _FastSearchState extends State<FastSearch> {
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
                      icon: Icon(Icons.arrow_back)),
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
                  hintText: 'Специалист или услуга',
                  hintStyle: TextStyle(color: globals.lightGrey),
                ),
              ),
            ),
            DefaultTabController(
              length: 2,
              child: TabBar(
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                labelColor: globals.black,
                indicatorColor: globals.orange,
                indicatorWeight: 2,
                labelStyle: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF272727),
                    fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    TextStyle(fontSize: 16.0, color: Color(0xFF9B9B9B)),
                // controller: ,
                tabs: const [
                  Tab(
                    text: 'Категории услуг',
                  ),
                  Tab(
                    text: 'История',
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/tutor');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 21),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xFFF2F2F2)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Репетитор',
                          style: TextStyle(color: globals.black, fontSize: 18),
                        ),
                        Icon(Icons.arrow_forward, color: globals.black)
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 21),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Врач',
                        style: TextStyle(color: globals.black, fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward, color: globals.black)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 21),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xFFF2F2F2)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Муж на час',
                        style: TextStyle(color: globals.black, fontSize: 18),
                      ),
                      Icon(Icons.arrow_forward, color: globals.black)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    ));
  }
}
