import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';

import '../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

import '../../../components/simple_app_bar.dart';

class Speciality3 extends StatefulWidget {
  const Speciality3({Key? key}) : super(key: key);

  @override
  _Speciality3State createState() => _Speciality3State();
}

class _Speciality3State extends State<Speciality3> {
  dynamic item = [];
  dynamic checkBoxList = [];

  setCategories() async {
    dynamic sendData = {
      "categoryId": Get.arguments['id'],
      "stepList": [
        {
          "stepId": item['id'],
          "main": true,
          "optionList": [],
        }
      ]
    };
    for (var i = 0; i < checkBoxList.length; i++) {
      if (checkBoxList[i]['isChecked']) {
        sendData['stepList'][0]['optionList'].add({
          'optionId': checkBoxList[i]['id'],
          'optionType': checkBoxList[i]['optionType'],
        });
      }
    }
    final response = await post('/services/executor/api/executor-order', sendData);
    if (response != null) {
      if (Get.arguments['value'] == 1) {
        Get.toNamed('/service-area');
        return;
      }
      if (Get.arguments['value'] == 2) {
        Get.offAllNamed('/', arguments: 3);
        return;
      }
      Get.offAllNamed('/');
    }
  }

  getCategories() async {
    final response = await get('/services/mobile/api/step-category/${Get.arguments['id']}');
    if (response['optionList'] != null) {
      for (var i = 0; i < response['optionList'].length; i++) {
        response['optionList'][i]['isChecked'] = false;
      }
      setState(() {
        item = response;
        checkBoxList = response['optionList'];
      });
    }
    getCurrentCategories();
  }

  getCurrentCategories() async {
    final response = await get('/services/executor/api/executor-step/2');
    for (var i = 0; i < checkBoxList.length; i++) {
      for (var k = 0; k < response.length; k++) {
        if (checkBoxList[i]['id'] == response[k]['optionId']) {
          setState(() {
            checkBoxList[i]['isChecked'] = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Мои специальности',
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text('Специальности', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              for (var i = 0; i < checkBoxList.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checkBoxList[i]['isChecked'] = !checkBoxList[i]['isChecked'];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFF2F2F2),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: black,
                            value: checkBoxList[i]['isChecked'],
                            onChanged: (value) {
                              setState(() {
                                checkBoxList[i]['isChecked'] = !checkBoxList[i]['isChecked'];
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: Text(
                            checkBoxList[i]['optionName'],
                            style: TextStyle(color: black, fontSize: 18),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Добавить категорию',
          onClick: () {
            setCategories();
          },
        ),
      ),
    );
  }
}
