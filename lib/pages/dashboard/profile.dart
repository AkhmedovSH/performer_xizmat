import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';

import '../../../components/simple_app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic user = {};
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
      'description': 'Где вам удобно работать, принимаете ли вы клиентов у себя',
      'onClick': () {
        Get.toNamed('/choose-regions');
      }
    },
    {
      'name': 'Фото паспорта',
      'description': 'Для верификации в приложении',
      'onClick': () {
        Get.toNamed('/verification');
      }
    },
    {
      'name': 'Фото ваших работ',
      'description': 'Их видят клиенты',
      'onClick': () {
        Get.toNamed('/profile-upload-photo', arguments: 1);
      }
    },
    {
      'name': 'Фото сертификатов',
      'description': 'Сертификаты которые могут привлечь клиентов',
      'onClick': () {
        Get.toNamed('/profile-upload-photo', arguments: 2);
      }
    },
    {
      'name': 'О себе',
      'description': 'Образование, опыт работы и кратко о себе',
      'onClick': () {
        Get.toNamed('/update-user', arguments: 1);
      }
    },
  ];

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.remove('user');
    Get.offAllNamed('/login');
  }

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
                    margin: EdgeInsets.only(bottom: 10),
                    width: 86,
                    height: 86,
                    child: user['imageUrl'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              mainUrl + user['imageUrl'],
                              height: 86,
                              width: 86,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            width: 86,
                            height: 86,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: lightGrey,
                              ),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      pickImage();
                    },
                    icon: Icon(
                      Icons.edit,
                      color: red,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Text(
                user['name'] ?? '',
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
                '${user['phone'] != null ? formatPhone(user['phone']) : ''}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Center(
            //   child: Text(
            //     'Вы не завершили проверку',
            //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Center(
            //   child: Text('Осталось несколько шагов', style: TextStyle(color: lightGrey, fontSize: 17, fontWeight: FontWeight.w500)),
            // ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(55, 15, 55, 30),
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Get.toNamed('/verification');
            //     },
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(vertical: 16),
            //       elevation: 0,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     child: Text(
            //       'Продолжить проверку',
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 30, 16, 15),
              decoration:
                  BoxDecoration(color: inputColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              child: Column(
                children: [
                  for (var i = 0; i < profile.length; i++)
                    GestureDetector(
                      onTap: profile[i]['onClick'],
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFDADADA), width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  profile[i]['name'],
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.edit,
                                  color: black,
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, right: 50),
                              child: Text(
                                profile[i]['description'],
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF707070)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 15),
                  //   padding: EdgeInsets.only(bottom: 15),
                  //   decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFDADADA), width: 1))),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Удалить аккаунт',
                  //         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  //       ),
                  //       Icon(
                  //         Icons.delete,
                  //         color: red,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFDADADA), width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Выйти',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.logout,
                            color: red,
                          )
                        ],
                      ),
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

  Future pickImage() async {
    final source = await showImageSource(context);
    if (source == null) return;
    try {
      XFile? img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final response = await uploadImage('/services/executor/api/upload/image', File(img.path));
      String jsonsDataString = response.toString();
      final jsonData = jsonDecode(jsonsDataString);
      final user = await get('/services/executor/api/get-info');
      dynamic sendData = {};
      setState(() {
        sendData = user;
        sendData['passImageUrlList'].add(
          {'fileUrl': jsonData['url']},
        );
      });
      final responsePut = await put('/services/executor/api/update-executor', sendData);
      if (responsePut != null) {
        // Get.offAllNamed('/', arguments: 2);
      }
      setState(() {
        // imageUrl = jsonData['url'];
      });
    } on PlatformException catch (e) {
      print('ERROR: $e');
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color(0xFFF2F2F2),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Добавить из галереи'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                    Icon(
                      Icons.camera_alt,
                      color: lightGrey,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color(0xFFF2F2F2),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Сделать снимок'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                    Icon(
                      Icons.image,
                      color: lightGrey,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Отмена'.tr,
                      style: TextStyle(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                    Icon(
                      Icons.close,
                      color: lightGrey,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
