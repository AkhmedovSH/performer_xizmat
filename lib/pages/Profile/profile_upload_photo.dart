import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../helpers/widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class ProfileUploadPhoto extends StatefulWidget {
  const ProfileUploadPhoto({Key? key}) : super(key: key);

  @override
  State<ProfileUploadPhoto> createState() => _ProfileUploadPhotoState();
}

class _ProfileUploadPhotoState extends State<ProfileUploadPhoto> {
  int from = 1;
  dynamic user = {};
  dynamic items = [];

  pickImage() async {
    final source = await showImageSource(context);
    if (source == null) return;
    try {
      XFile? img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      final response = await uploadImage('/services/executor/api/upload/image', File(img.path));
      print(response);
      String jsonsDataString = response.toString();
      final jsonData = jsonDecode(jsonsDataString);
      final user = await get('/services/executor/api/get-info');
      dynamic sendData = {};
      setState(() {
        sendData = user;
        if (from == 1) {
          sendData['galleryUrlList'].add(
            {'fileUrl': jsonData['url']},
          );
        }
        if (from == 2) {
          sendData['certUrlList'].add(
            {'fileUrl': jsonData['url']},
          );
        }
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

  deleteImage(index) async {
    dynamic responsePut;
    if (from == 1) {
      responsePut = await delete('/services/executor/api/executor-pass/' + user['galleryUrlList'][index]['id'].toString());
    }
    if (from == 2) {
      responsePut = await delete('/services/executor/api/executor-pass/' + user['certUrlList'][index]['id'].toString());
    }
    if (responsePut != null) {
      getUser();
    }
  }

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response != null) {
      setState(() {
        user = response;
        if (from == 1) {
          items = response['galleryUrlList'];
        }
        if (from == 2) {
          items = response['certUrlList'];
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
    print(Get.arguments);
    setState(() {
      from = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        appBar: AppBar(),
        title: from == 1 ? 'Выши работы' : 'Сертификаты',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 35),
              alignment: Alignment.center,
              child: Text(
                from == 1 ? 'Загрузите фотографии своих работ' : 'Загрузите фотографии своих сертификатов',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            items != null
                ? Wrap(
                    runAlignment: WrapAlignment.spaceAround,
                    children: [
                      for (var i = 0; i < items.length; i++)
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  mainUrl + items[i]['fileUrl'].toString(),
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
                                    deleteImage(i);
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
                      'Прикрепить фото ',
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
          ],
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
