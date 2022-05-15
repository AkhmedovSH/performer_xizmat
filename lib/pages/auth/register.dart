import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../helpers/api.dart';
import '../../helpers/globals.dart';
import '../../helpers/widgets.dart';

import '../../components/simple_app_bar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(mask: '## ### ## ##', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  bool showPassword = true;
  bool showConfirmPassword = true;
  dynamic sendData = {
    'phone': '',
    'password': '',
    'confirmPassword': '',
  };

  register() async {
    final checkLogin = await get('/services/executor/api/check-login?login=${'998' + maskFormatter.getUnmaskedText()}');
    if (checkLogin['message'] == 'error.login.used') {
      showErrorToast('Телефон номер уже используется');
    }
    setState(() {
      sendData['phone'] = '998' + maskFormatter.getUnmaskedText();
    });
    final response = await guestPost('/services/executor/api/register-executor', sendData);
    if (response != null) {
      Get.toNamed('/confirmation', arguments: sendData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Регистрация',
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
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
                          initialValue: sendData['phone'],
                          onChanged: (value) {
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
                  ],
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
                    initialValue: sendData['password'],
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
                      if (value != sendData['password']) {
                        return 'passwords_must_match'.tr;
                      }
                      return null;
                    },
                    initialValue: sendData['confirmPassword'],
                    onChanged: (value) {
                      setState(() {
                        sendData['confirmPassword'] = value;
                      });
                    },
                    scrollPadding: const EdgeInsets.all(50),
                    obscureText: showConfirmPassword,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.lock,
                        ),
                      ),
                      suffixIcon: showConfirmPassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  showConfirmPassword = false;
                                });
                              },
                              icon: const Icon(
                                Icons.visibility_off,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  showConfirmPassword = true;
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
                      hintText: 'confirm_password'.tr,
                      hintStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                    ),
                    style: const TextStyle(color: Color(0xFF9C9C9C)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: Button(
          text: 'Продолжить',
          onClick: () {
            if (_formKey.currentState!.validate()) {
              register();
            }
          },
        ),
      ),
    );
  }
}
