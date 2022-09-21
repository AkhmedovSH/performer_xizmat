import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helpers/globals.dart';
import '../../../helpers/api.dart';
import '../../../widgets.dart';

class ResetPasswordInit extends StatefulWidget {
  const ResetPasswordInit({Key? key}) : super(key: key);

  @override
  State<ResetPasswordInit> createState() => _ResetPasswordInitState();
}

class _ResetPasswordInitState extends State<ResetPasswordInit> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(mask: '+998 ## ### ## ##', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  AnimationController? animationController;
  dynamic sendData = {
    'phone': '',
    'password': '',
    'confirmPassword': '',
  };
  dynamic data = {
    'phone': TextEditingController(text: '+998 '),
    'password': '',
    'confirmPassword': '',
  };
  bool loading = false;

  resetPasswordInit() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      final user = jsonDecode(prefs.getString('user')!);
      setState(() {
        sendData['password'] = user['password'];
      });
    }
    // else {
    //   showErrorToast('user_is_not_found'.tr);
    // }
    setState(() {
      sendData['phone'] = '998' + maskFormatter.getUnmaskedText();
    });
    final response = await guestPost('/services/uaa/api/account/reset-password/init', sendData);
    if (response != null) {
      if (response['success']) {
        Get.toNamed('/reset-password-finish');
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: white,
            ),
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Parolni esdan chiqardingizmi' '?',
                        style: TextStyle(color: black, fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Parolni tiklash uchun kerakli ma\'lumotlarni yozing',
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
                                controller: data['phone'],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Majburiy maydon';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value == '') {
                                    setState(() {
                                      data['phone'].text = '+998 ';
                                      data['phone'].selection = TextSelection.fromPosition(TextPosition(offset: data['phone'].text.length));
                                    });
                                  }
                                  setState(() {
                                    sendData['phone'] = value;
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
                          const SizedBox(
                            height: 70,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(left: 32),
            child: Button(
              text: 'Продолжить',
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  resetPasswordInit();
                }
              },
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
