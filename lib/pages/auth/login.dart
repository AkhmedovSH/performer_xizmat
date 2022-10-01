import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../helpers/globals.dart';
import '../../helpers/api.dart';
import '../../helpers/widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';
import 'package:xizmat/helpers/location_notification_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  AnimationController? animationController;
  dynamic sendData = {
    'username': '+998 ', // 998 998325455
    'password': '', // 112233
    'isRemember': false,
  };
  dynamic data = {
    'username': TextEditingController(text: '+998 '), // 998 998325455
    'password': TextEditingController(), // 112233
    'isRemember': false,
  };
  bool showPassword = true;
  bool loading = false;

  List languages = [
    {'id': '1', 'name': 'Uzbek', 'locale': const Locale('uz-Latn-UZ', ''), 'active': false},
    {'id': '2', 'name': 'Русский', 'locale': const Locale('ru', ''), 'active': false},
  ];
  dynamic currentLocale = '1';

  login() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    if (maskFormatter.getUnmaskedText().isNotEmpty) {
      setState(() {
        sendData['username'] = '998' + maskFormatter.getUnmaskedText();
      });
    }
    dynamic response = {};
    try {
      final login = await dio.post('https://admin.xizmat24.uz/auth/login', data: sendData);
      response = login.data;
    } on DioError catch (e) {
      setState(() {
        loading = false;
      });
      statuscheker(e);
    }
    if (response != null) {
      prefs.setString('access_token', response['access_token'].toString());
      prefs.setString('user', jsonEncode(sendData));
      var account = await get('/services/uaa/api/account');
      var checkAccess = false;
      for (var i = 0; i < account['authorities'].length; i++) {
        if (account['authorities'][i] == 'ROLE_EXECUTOR') {
          checkAccess = true;
        }
      }
      print(checkAccess);
      if (checkAccess) {
        LocalNotificationService.initialize(context);
        FirebaseMessaging.instance.getInitialMessage().then((message) {
          if (message != null) {
            Get.offAllNamed('/notifications');
          }
        });
        FirebaseMessaging.onMessage.listen((message) {
          if (message.notification != null) {}
          LocalNotificationService.display(message);
        });

        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          Get.offAllNamed('/notifications');
        });
        final user = await get('/services/executor/api/get-info');
        setState(() {
          loading = false;
        });
        if (user != null) {
          if (user['name'] == null || user['name'] == '') {
            Get.toNamed('/update-user');
            return;
          }
          if (user['imageUrl'] == null) {
            Get.toNamed('/upload-photo');
            return;
          } else {
            Get.offAllNamed('/');
          }
        }
      } else {
        setState(() {
          loading = false;
        });
        showErrorToast('Нет доступа');
      }
    }
  }

  changeLocale(id) async {
    int newIndex = int.parse(id);
    final prefs = await SharedPreferences.getInstance();
    Get.updateLocale(languages[newIndex - 1]['locale']);
    prefs.setInt('locale', int.parse(languages[newIndex - 1]['id']));
    setState(() {
      currentLocale = id;
      if (Get.locale == const Locale('ru', '')) {
        languages[1]['active'] = true;
        languages[0]['active'] = false;
      }
      if (Get.locale == const Locale('uz-Latn-UZ', '')) {
        languages[0]['active'] = true;
        languages[1]['active'] = false;
      }
    });
  }

  checkIsRemember() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      final user = jsonDecode(prefs.getString('user')!);
      if (user['isRemember'] != null) {
        if (user['isRemember']) {
          setState(() {
            sendData['isRemember'] = user['isRemember'];
            sendData['username'] = user['username'];
            sendData['password'] = user['password'];
            data['username'].text = maskFormatter.maskText(user['username'].substring(3, user['username'].length));
            data['password'].text = user['password'];
          });
        }
      }
    }
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('locale') != null) {
      setState(() {
        if (prefs.getInt('locale') == 1) {
          currentLocale = '1';
        }
        if (prefs.getInt('locale') == 2) {
          currentLocale = '2';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsRemember();
    getData();
    setState(() {
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    });
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: SimpleAppBar(
            title: '',
            appBar: AppBar(),
            leading: false,
          ),
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'welcome_to_xizmat'.tr,
                      style: TextStyle(color: black, fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'sign_in_to_continue'.tr,
                      style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: red,
                                  ),
                            ),
                            child: TextFormField(
                              inputFormatters: [maskFormatter],
                              controller: data['username'],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'required_field'.tr;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (value == '') {
                                  setState(() {
                                    data['username'].text = '+998 ';
                                    data['username'].selection = TextSelection.fromPosition(TextPosition(offset: data['username'].text.length));
                                  });
                                }
                                setState(() {
                                  sendData['username'] = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.phone_iphone,
                                    )),
                                contentPadding: const EdgeInsets.all(18.0),
                                focusColor: red,
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: red),
                                ),
                                labelText: 'telephone_number'.tr + '(9* *** ** **)',
                                labelStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                              ),
                              style: const TextStyle(color: Color(0xFF9C9C9C)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 25),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: red,
                                  ),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'required_field'.tr;
                                }
                                return null;
                              },
                              controller: data['password'],
                              onChanged: (value) {
                                setState(() {
                                  sendData['password'] = value;
                                });
                              },
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.lock,
                                  ),
                                ),
                                suffixIcon: showPassword
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.visibility_off,
                                          // color: red,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.visibility,
                                          // color: red,
                                        ),
                                      ),
                                contentPadding: const EdgeInsets.all(18.0),
                                focusColor: red,
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: red),
                                ),
                                labelText: 'password'.tr,
                                labelStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                              ),
                              style: const TextStyle(color: Color(0xFF9C9C9C)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: red,
                                  value: sendData['isRemember'],
                                  onChanged: (value) {
                                    setState(() {
                                      sendData['isRemember'] = !sendData['isRemember'];
                                    });
                                  },
                                ),
                                Text(
                                  'remember'.tr,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/reset-password-init');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: red,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'forgot_your_password'.tr + '?',
                                  style: TextStyle(
                                    color: red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     bottom: BorderSide(
                        //       color: const Color(0xFF9C9C9C),
                        //       width: 1,
                        //     ),
                        //   ),
                        // ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            value: currentLocale,
                            isExpanded: true,
                            hint: Text('${languages[0]['name']}'),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 28,
                              color: Color(0xFF9C9C9C),
                            ),
                            iconSize: 24,
                            iconEnabledColor: grey,
                            elevation: 16,
                            style: const TextStyle(color: Color(0xFF313131)),
                            underline: Container(),
                            onChanged: (newValue) {
                              changeLocale(newValue);
                            },
                            items: languages.map((item) {
                              return DropdownMenuItem<String>(
                                value: '${item['id']}',
                                child: Text(item['name']),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(left: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: widgets.Button(
                    text: 'login'.tr,
                    onClick: () {
                      login();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'no_account'.tr + '?',
                      style: TextStyle(fontWeight: FontWeight.w500, color: black, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/register');
                      },
                      child: Text(
                        'registration'.tr,
                        style: TextStyle(color: red, fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        loading
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.4),
                child: SpinKitThreeBounce(
                  color: red,
                  size: 35.0,
                  controller: animationController,
                ),
              )
            : Container()
      ],
    );
  }
}
