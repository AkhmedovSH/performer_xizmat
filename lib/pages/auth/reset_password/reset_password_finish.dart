import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helpers/api.dart';
import '../../../helpers/globals.dart';
import '../../../widgets.dart';

class ResetPasswordFinish extends StatefulWidget {
  const ResetPasswordFinish({Key? key}) : super(key: key);

  @override
  State<ResetPasswordFinish> createState() => _ResetPasswordFinishState();
}

class _ResetPasswordFinishState extends State<ResetPasswordFinish> with TickerProviderStateMixin {
  var maskFormatter = MaskTextInputFormatter(mask: '### ###', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  final _formKey = GlobalKey<FormState>();
  AnimationController? animationController;
  dynamic sendData = {
    'key': '',
    'newPassword': '',
  };
  bool showPassword = true;
  bool loading = false;

  checkActivationCode() async {
    setState(() {
      sendData['key'] = maskFormatter.getUnmaskedText();
      loading = true;
    });
    final response = await guestPost('/services/uaa/api/account/reset-password/finish', sendData);
    setState(() {
      loading = false;
    });
    if (response != null) {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('user') != null) {
        final user = jsonDecode(prefs.getString('user')!);
        user['password'] = sendData['newPassword'];
        prefs.setString('user', jsonEncode(user));
      }
      showSuccessToast('Parol muvaffaqiyatli almashtirildi');
      Get.offAllNamed('/login');
    }
  }

  @override
  void initState() {
    super.initState();
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
                        '',
                        style: TextStyle(color: black, fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'enter_the_code_sent_to_your_number'.tr,
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'required_field'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length < 7) {
                                      sendData['key'] = value;
                                    }
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                  ),
                                  focusedErrorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                  ),
                                  filled: true,
                                  fillColor: white,
                                  contentPadding: const EdgeInsets.all(16),
                                  hintText: 'SMS kodni yozing',
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
                                onChanged: (value) {
                                  setState(() {
                                    sendData['newPassword'] = value;
                                  });
                                },
                                obscureText: showPassword,
                                scrollPadding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom / 1.5,
                                ),
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
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red[700]!),
                                  ),
                                  hintText: 'password'.tr,
                                  hintStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                                ),
                                style: const TextStyle(color: Color(0xFF9C9C9C)),
                              ),
                            ),
                          ),
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
              text: 'proceed'.tr,
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  checkActivationCode();
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
