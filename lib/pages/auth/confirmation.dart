import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  Timer? timer;
  AnimationController? animationController;
  var maskFormatter = MaskTextInputFormatter(
    mask: '# # # # # #',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  bool isSendAgain = false;
  bool loading = false;
  dynamic sendData = {
    'phone': '',
  };

  dynamic timerText = '2:00';
  dynamic timerMax = 120;

  checkCode() async {
    setState(() {
      loading = true;
    });
    // final prefs = await SharedPreferences.getInstance();
    setState(() {
      sendData['activationCode'] = maskFormatter.getUnmaskedText();
    });
    final response = await guestPost('/services/executor/api/activate-executor', sendData);
    if (response != null) {
      Get.toNamed('/login');
    }
    setState(() {
      loading = false;
    });
  }

  register() async {
    setState(() {
      loading = true;
    });
    final response = await guestPost('/services/executor/api/register-executor', sendData);
    if (response != null) {
      startTimeout();
    }
    setState(() {
      loading = false;
    });
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
    setState(() {
      animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
    animationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: SimpleAppBar(
            title: 'confirmation'.tr,
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
                          'enter_code_from_sms_to_confirm'.tr,
                          style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'code_from_sms'.tr + '*',
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
                              'send_again'.tr,
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
              text: 'confirm_and_continue'.tr,
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  checkCode();
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
