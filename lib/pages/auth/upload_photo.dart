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
        title: 'upload_photo'.tr,
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
                'clients_trust_specialists_with_photos_more_then_it_can_be_changed_in_the_questionnaire'.tr,
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
                  'attach_photo'.tr,
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
          text: 'further'.tr,
          onClick: () {
            Get.toNamed('/speciality', arguments: 1);
          },
        ),
      ),
    );
  }

  List items = [
    {'text': 'the_photo_shows_you'.tr},
    {'text': 'full_face_is_visible'.tr},
    {'text': 'photo_size_not_less_than_100x200_pixels'.tr},
    {'text': 'pictured_is_your_company_logo'.tr},
  ];
  List items2 = [
    {'text': 'in_the_photo_you_are_wearing_tinted_glasses_or_hat'.tr},
    {'text': 'there_are_strangers_in_the_frame'.tr},
    {'text': 'there_are_captions_or_pictures_on_the_photo'.tr},
    {'text': 'there_are_cigarettes_alcohol_people_without_clothes_in_the_photo'.tr},
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
          user['imageUrl'] = jsonData['url'].toString();
        });
        final responsePut = await put('/services/executor/api/update-executor', user);
        if (responsePut != null) {
          getUser();
          Get.back();
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
                            'what_should_be_the_photo'.tr,
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
                                        'fits'.tr,
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
                                        'doesn\'t_fit'.tr,
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
                              'photo_fit'.tr,
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
                              'the_photo_doesn\'t_fit'.tr,
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
                            'select_from_gallery'.tr,
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
