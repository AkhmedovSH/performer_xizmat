import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:xizmat/helpers/api.dart';
import 'package:xizmat/helpers/globals.dart';

import 'package:xizmat/helpers/location_notification_service.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  dynamic systemOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light);
  dynamic vesrion = '';
  dynamic url = '';
  bool isRequired = false;

  @override
  void initState() {
    super.initState();
    login();
    // checkVersion();
    // startTimer();
  }

  login() async {
    // setState(() {
    //   sendData['username'] = '998' + maskFormatter.getUnmaskedText();
    // });
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      final user = jsonDecode(prefs.getString('user')!);
      final response = await guestPost('/auth/login', {
        'username': user['username'],
        'password': user['password'],
      });
      if (response != null) {
        prefs.setString('access_token', response['access_token'].toString());
        final getInfo = await get('/services/executor/api/get-info');
        var account = await get('/services/uaa/api/account');
        var checkAccess = false;
        for (var i = 0; i < account['authorities'].length; i++) {
          if (account['authorities'][i] == 'ROLE_CLIENT') {
            checkAccess = true;
          }
        }
        if (checkAccess) {
          LocalNotificationService.initialize(context);
          FirebaseMessaging.instance.getInitialMessage().then((message) {
            if (message != null) {
              Get.offAllNamed('/notifications');
            }
          });
          FirebaseMessaging.onMessage.listen((message) {
            if (message.notification != null) {
              //Get.toNamed('/');
            }
            LocalNotificationService.display(message);
          });

          FirebaseMessaging.onMessageOpenedApp.listen((message) {
            Get.offAllNamed('/notifications');
          });

          // var firebaseToken = await FirebaseMessaging.instance.getToken();
          // await put('/services/gocashmobile/api/firebase-token', {'token': firebaseToken});

          if (getInfo['imageUrl'] == null) {
            Get.offAllNamed('/upload-photo');
            return;
          }
          if (getInfo['passImageUrlList'].length == 0) {
            Get.offAllNamed('/verification');
            return;
          }
          if (getInfo['passImageUrlList'].length == 0) {
            Get.offAllNamed('/verification');
            return;
          } else {
            Get.offAllNamed('/');
          }
        }
      }
    } else {
      Get.offAllNamed('/login');
    }
  }

  void checkVersion() async {
    final newVersion = NewVersion(androidId: 'uz.cashbek.cabinet');
    final status = await newVersion.getVersionStatus();

    setState(() {
      vesrion = status!.localVersion;
      url = status.appStoreLink.toString();
    });

    if (status!.storeVersion != status.localVersion) {
      final lastVersion = status.storeVersion.split('.')[2];
      if ((int.parse(lastVersion) % 3).round() == 0) {
        setState(() {
          isRequired = true;
        });
      }

      await showUpdateDialog();
      if (isRequired) {
        SystemNavigator.pop();
        // startTimer();
      } else {
        startTimer();
      }
      return;
    } else {
      startTimer();
    }
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  void navigate() async {
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // bool lightMode =
    //     MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: red,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: systemOverlayStyle,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'images/splash_logo.png',
            height: 200,
            width: MediaQuery.of(context).size.width * 0.6,
          )),
        ],
      ),
    );
  }

  showUpdateDialog() async {
    await showDialog(
        context: context,
        // barrierDismissible: !isRequired,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
              title: Text(
                'update_app'.tr + ' "moneyBek"',
                style: const TextStyle(color: Colors.black),
                // textAlign: TextAlign.center,
              ),
              scrollable: true,
              content: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      isRequired
                          ? 'you_need_to_install_the_latest_version_to_continue_using_the_app'.tr + '"moneyBek".'
                          : 'we_recommend_installing_the_latest_version_of_the_application'.tr +
                              '"moneyBek".' +
                              'while_downloading_updates_you_can_still_use_it'.tr +
                              '.',
                      style: const TextStyle(color: Colors.black, height: 1.2),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isRequired
                              ? Container()
                              : Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: TextButton.styleFrom(primary: const Color(0xFF00865F)),
                                    child: Text(
                                      'no_thanks'.tr,
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                          ElevatedButton(
                            onPressed: () {
                              launch(url);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF00865F),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              elevation: 0,
                            ),
                            child: Text('update'.tr),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        'images/google_play.png',
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
