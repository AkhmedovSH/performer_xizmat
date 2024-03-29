import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';

import '../../helpers/globals.dart';

import '../../components/simple_app_bar.dart';
import '../../widgets.dart';

class ChooseCity extends StatefulWidget {
  const ChooseCity({Key? key}) : super(key: key);

  @override
  State<ChooseCity> createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  dynamic cities = [];
  dynamic selectedButton = '0';
  dynamic sendData = {};

  setcities() async {
    final user = await get('/services/executor/api/get-info');
    setState(() {
      sendData = user;
      sendData['cityId'] = selectedButton;
    });
    final response = await put('/services/executor/api/update-executor', sendData);
    if (response != null) {
      if (Get.arguments['value'] == 1) {
        Get.toNamed('/service-area', arguments: 1);
        return;
      }
      Get.toNamed('/upload-photo');
    }
    return false;
  }

  getCities() async {
    final response = await get('/services/executor/api/city-helper/${Get.arguments['id']}');
    if (response != null) {
      setState(() {
        cities = response;
        selectedButton = response[0]['id'];
      });
      getUser();
    }
  }

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response != null) {
      setState(() {
        if (response['cityId'] != null && response['cityId'] != '0' && response['cityId'] != '') {
          selectedButton = response['cityId'];
          sendData['cityId'] = selectedButton;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimpleAppBar(
          appBar: AppBar(),
          title: 'choose_city'.tr,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < cities.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedButton = cities[i]['id'];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cities[i]['name']),
                        Radio<dynamic>(
                          value: cities[i]['id'],
                          groupValue: selectedButton,
                          onChanged: (value) {
                            setState(() {
                              selectedButton = value;
                              sendData['cityName'] = cities[i]['name'];
                            });
                          },
                          activeColor: red,
                        ),
                        // Checkbox(
                        //   value: cities[i]['isChecked'],
                        //   activeColor: red,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       cities[i]['isChecked'] = !cities[i]['isChecked'];
                        //     });
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 32),
          child: Button(
            onClick: () {
              setcities();
            },
            text: 'proceed'.tr,
          ),
        ));
  }
}
