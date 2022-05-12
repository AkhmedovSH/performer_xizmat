import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  dynamic character = 1;
  dynamic lights = false;

  dynamic user = {};

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response != null) {
      setState(() {
        user = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Загрузите фотографию',
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Клиенты больше доверяют специалистам с фото.  Потом его можно будет поменять в анкете.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: user['imageUrl'] != null
                  ? Container(
                      margin: EdgeInsets.only(bottom: 30),
                      // width: 100,
                      // height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          mainUrl + user['imageUrl'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      decoration: BoxDecoration(color: borderColor, borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.person,
                        color: Color(0xFFDADADA),
                        size: 42,
                      ),
                    ),
            ),
            GestureDetector(
              onTap: () {
                showUploadBottomSheet();
              },
              child: Center(
                child: Text(
                  'Прикрепить фото',
                  style: TextStyle(color: darkRed, fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Далее',
          onClick: () {
            Get.toNamed('/verification');
          },
        ),
      ),
    );
  }

  List items = [
    {'text': 'На фото изображены вы'},
    {'text': 'Лицо видно полностью'},
    {'text': 'Размер фото не меньше 100х200 пикселей'},
    {'text': 'На фото логотип вашей компании'},
  ];
  List items2 = [
    {'text': 'На фото вы в затемненных очках или головном уборе'},
    {'text': 'В кадре есть посторонние люди'},
    {'text': 'На фото есть надписи или картинки'},
    {'text': 'На фото есть сигареты, алкоголь, люди без одежды'},
  ];

  dynamic sendData = {};

  Future pickImage(source) async {
    try {
      XFile? img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final response = await uploadImage('/services/executor/api/upload/image', File(img.path));
      if (response != null) {
        String jsonsDataString = response.toString();
        final jsonData = jsonDecode(jsonsDataString);
        setState(() {
          user['imageUrl'] = jsonData['url'];
        });
        final responsePut = await put('/services/executor/api/update-executor', user);
        if (responsePut != null) {
          getUser();
        }
      }
    } on PlatformException catch (e) {
      print('ERROR: $e');
    }
  }

  showUploadBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 23),
                          child: Text(
                            'Каким должно быть фото',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 11),
                          margin: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(color: borderColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset('images/circle_avatar.png'),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.check,
                                          color: green,
                                        ),
                                      ),
                                      Text(
                                        'Подходит',
                                        style: TextStyle(color: green, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Image.asset('images/circle_avat.png'),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.close,
                                          color: darkRed,
                                        ),
                                      ),
                                      Text(
                                        'Не подходит',
                                        style: TextStyle(color: darkRed, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 7),
                              child: Icon(
                                Icons.check,
                                color: green,
                              ),
                            ),
                            Text(
                              'Фото подойдет',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < items.length; i++)
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    '-  ${items[i]['text']}',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 7),
                              child: Icon(
                                Icons.close,
                                color: darkRed,
                              ),
                            ),
                            Text(
                              'Фото не подойдет',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < items2.length; i++)
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    '-  ${items2[i]['text']}',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                )
                            ],
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
                        color: black,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                  boxShadow: const [
                    BoxShadow(color: Colors.black38, spreadRadius: -3, blurRadius: 5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Выбрать из галереи',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          pickImage(ImageSource.camera);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(color: borderColor, borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Icon(
                            Icons.photo_camera,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
