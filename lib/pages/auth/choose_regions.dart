import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xizmat/helpers/api.dart';

import '../../helpers/globals.dart';

import '../../components/simple_app_bar.dart';
import '../../widgets.dart';

class ChooseRegions extends StatefulWidget {
  const ChooseRegions({Key? key}) : super(key: key);

  @override
  State<ChooseRegions> createState() => _ChooseRegionsState();
}

class _ChooseRegionsState extends State<ChooseRegions> {
  dynamic regions = [];
  dynamic selectedButton = '0';
  dynamic sendData = {};

  setRegions() async {
    final user = await get('/services/executor/api/get-info');
    sendData = user;
    sendData['cityId'] = selectedButton;
    final response = await put('/services/executor/api/update-executor', sendData);
    if (response != null) {
      Get.toNamed('/choose-cities', arguments: {'id': sendData['cityId'], 'value': Get.arguments});
    }
    return false;
  }

  getRegions() async {
    final response = await get('/services/executor/api/region-helper');
    setState(() {
      regions = response;
      selectedButton = regions[0]['id'];
    });
  }

  @override
  void initState() {
    super.initState();
    getRegions();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return setRegions();
      },
      child: Scaffold(
          appBar: SimpleAppBar(
            appBar: AppBar(),
            title: 'Выберите районы',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                for (var i = 0; i < regions.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedButton = regions[i]['id'];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(regions[i]['name']),
                          Radio<dynamic>(
                            value: regions[i]['id'],
                            groupValue: selectedButton,
                            onChanged: (value) {
                              setState(() {
                                selectedButton = value;
                                sendData['cityName'] = regions[i]['name'];
                              });
                            },
                            activeColor: red,
                          ),
                          // Checkbox(
                          //   value: regions[i]['isChecked'],
                          //   activeColor: red,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       regions[i]['isChecked'] = !regions[i]['isChecked'];
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
                setRegions();
              },
              text: 'Продолжить',
            ),
          )),
    );
  }
}
