import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final _formKey = GlobalKey<FormState>();
  Timer? timer;
  var maskFormatter = MaskTextInputFormatter(mask: '# # # # # #', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  bool isSendAgain = false;
  dynamic sendData = {
    'phone': '',
  };

  dynamic timerText = '2:00';
  dynamic timerMax = 120;

  checkCode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sendData['activationCode'] = maskFormatter.getUnmaskedText();
    });
    final response = await guestPost('/services/executor/api/activate-executor', sendData);
    if (response != null) {
      Get.toNamed('/login');
    }
  }

  register() async {
    final response = await guestPost('/services/executor/api/register-executor', sendData);
    if (response != null) {
      startTimeout();
    }
  }

  startTimeout() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        Duration clockTimer = Duration(seconds: timerMax - timer.tick);
        timerText = '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
        if (timer.tick == timerMax) {
          isSendAgain = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
    sendData = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Подтверждение',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Text(
                      'Введите код из SMS для подтверждения',
                      style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Код из SMS*',
                    style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
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
                        sendData['activationCode'] = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(18.0),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: red),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red[700]!),
                      ),
                      hintText: '_ _ _ _ _ _',
                      hintStyle: TextStyle(color: Color(0xFF9C9C9C)),
                    ),
                    style: TextStyle(
                      color: lightGrey,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isSendAgain) {
                          register();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: black, width: 1)),
                        ),
                        child: Text(
                          'Отправить заново',
                          style: TextStyle(color: black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Text(
                      '$timerText',
                      style: TextStyle(color: Color(0xFF808080), fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Подтвердить и продолжить',
          onClick: () {
            if (_formKey.currentState!.validate()) {
              checkCode();
            }
          },
        ),
      ),
    );
  }
}
