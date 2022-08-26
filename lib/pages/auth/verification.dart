import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  dynamic user = {};

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
        getUser();
        // Get.offAllNamed('/', arguments: 2);
      }
    } on PlatformException catch (e) {
      print('ERROR: $e');
    }
  }

  deletePassImage(index) async {
    print(user['passImageUrlList'][index]['id']);
    final responsePut = await delete('/services/executor/api/executor-pass/' + user['passImageUrlList'][index]['id'].toString());
    if (responsePut != null) {
      getUser();
    }
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
        appBar: AppBar(),
        title: 'Верификация',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 35),
              child: Text(
                'Для полноценного использования приложения необходимо верифицировать вашу личность',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            user['passImageUrlList'] != null
                ? Wrap(
                    children: [
                      for (var i = 0; i < user['passImageUrlList'].length; i++)
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  mainUrl + user['passImageUrlList'][i]['fileUrl'].toString(),
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: darkRed,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    deletePassImage(i);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(bottom: 45, top: 10),
              child: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Transform.rotate(
                        angle: 45 * pi / 180,
                        child: Icon(
                          Icons.attach_file,
                          color: red,
                          size: 28,
                        ),
                      ),
                    ),
                    Text(
                      'Прикрепить фото паспорта',
                      style: TextStyle(
                        color: red,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Center(
            //   child: Text(
            //     'Верифицироваться через менеджера',
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Center(
            //   child: Container(
            //     margin: EdgeInsets.only(top: 45),
            //     decoration: BoxDecoration(
            //       border: Border(
            //         bottom: BorderSide(color: Color(0xFF707070), width: 1),
            //       ),
            //     ),
            //     child: GestureDetector(
            //       onTap: () {
            //         Get.toNamed('/why-need-verification');
            //       },
            //       child: Text(
            //         'Зачем нужна верификация?',
            //         style: TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xFF707070),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Отправить',
          onClick: () {
            if (user['passImageUrlList'].length > 0) {
              Get.toNamed('/choose-regions');
            } else {
              showErrorToast('Загрузите одно фото');
            }
            // Get.toNamed('/add-category');
          },
        ),
      ),
    );
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
                      Icons.image,
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
                      Icons.camera_alt,
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
