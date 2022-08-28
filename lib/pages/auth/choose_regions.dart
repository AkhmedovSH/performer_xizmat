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

  setRegions() async {
    final user = await get('/services/executor/api/get-info');
    dynamic sendData = {};
    sendData = user;
    sendData['regionId'] = [];
    dynamic regionSelected = false;
    for (var i = 0; i < regions.length; i++) {
      if (regions[i]['isChecked']) {
        // sendData['regionId'].add(regions[i]['id'].toString());
        sendData['regionId'] = regions[i]['id'];
        sendData['regionName'] = regions[i]['name'];
        regionSelected = true;
      }
    }
    if (!regionSelected) {
      showWarningToast('Выберите один город');
      return;
    }
    sendData['regionId'] = regions[0]['id'];
    sendData['regionName'] = regions[0]['name'];
    final response = await put('/services/executor/api/update-executor', sendData);
    if (response != null) {
      Get.toNamed('/');
    }
    return false; 
  }

  getRegions() async {
    final response = await get('/services/executor/api/region-helper');
    for (var i = 0; i < response.length; i++) {
      response[i]['isChecked'] = false;
    }
    setState(() {
      regions = response;
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
                        regions[i]['isChecked'] = !regions[i]['isChecked'];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(regions[i]['name']),
                          Checkbox(
                            value: regions[i]['isChecked'],
                            activeColor: red,
                            onChanged: (value) {
                              setState(() {
                                regions[i]['isChecked'] = !regions[i]['isChecked'];
                              });
                            },
                          )
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
