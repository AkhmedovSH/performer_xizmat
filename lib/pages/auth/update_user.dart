import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:xizmat/components/simple_app_bar.dart';
import 'package:xizmat/helpers/api.dart';

import '../../../helpers/globals.dart';
import '../../widgets.dart' as widgets;

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();
  var maskFormatter = MaskTextInputFormatter(mask: '+998 ## ### ## ##', filter: {'#': RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
  dynamic sendData = {
    "name": "Alisher",
    "phone": "998998325455",
    "gender": 1,
    "regionId": '0',
    "cityId": '0',
    "imageUrl": "imageUrl",
    "birthDate": "2022-01-01"
  };
  dynamic data = {
    "nameController": TextEditingController(),
    "phoneController": TextEditingController(text: '+998 '),
    'birthDateController': TextEditingController(),
    'genderController': TextEditingController(),
  };
  DateTime selectedDate = DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())) - 16);

  List regions = [
    {'name': '', 'id': '0'}
  ];

  List cities = [
    {'name': '', 'id': '0'}
  ];

  selectDate(BuildContext context) async {
    DateTime date = DateTime.now();
    dynamic year = DateFormat('yyyy').format(date);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(int.parse(year) - 16),
      // locale: const Locale("fr", "FR"),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: red,
            colorScheme: ColorScheme.light(primary: red),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        data['birthDateController'].text = DateFormat('yyyy-MM-dd').format(picked);
        sendData['birthDate'] = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  updateUser() async {
    setState(() {
      sendData['phone'] = '998' + maskFormatter.getUnmaskedText();
    });
    print(sendData);
    final response = await put('/services/executor/api/update-executor', sendData);
    print(response);
    if (response != null) {
      if (response['success']) {
        if (Get.arguments == 1) {
          Get.back();
          return;
        }
        Get.toNamed('/choose-regions');
      }
    }
  }

  getRegions({id}) async {
    final response = await get('/services/mobile/api/region-helper');
    if (id == null || id == 'null' || id == '0' || id == 0) {
      await getCities(response[0]['id']);
    }
    print(id != null || id != 'null' || id != '0' || id != 0);
    setState(() {
      if (id != null && id != 'null' && id != '0' && id != 0) {
        sendData['regionId'] = id.toString();
      } else {
        sendData['regionId'] = response[0]['id'].toString();
      }
      regions = response;
    });
  }

  getCities(id, {cityid}) async {
    final response = await get('/services/mobile/api/city-helper/$id');
    setState(() {
      if (cityid != null) {
        sendData['cityId'] = cityid.toString();
      } else {
        sendData['cityId'] = response[0]['id'].toString();
      }
      cities = response;
    });
    return;
  }

  getUser() async {
    final response = await get('/services/executor/api/get-info');
    if (response['regionId'] != null && response['regionId'] != '0' && response['regionId'] != 0) {
      getRegions(id: response['regionId']);
    } else {
      getRegions();
    }
    if (response['cityId'] != null && response['cityId'] != '0' && response['cityId'] != 0) {
      getCities(response['regionId'], cityid: response['cityId']);
    }
    setState(() {
      data['nameController'].text = response['name'].toString() != 'null' ? response['name'].toString() : '';
      data['phoneController'].text =
          response['phone'].toString() != 'null' ? maskFormatter.maskText(response['phone'].substring(3, response['phone'].length)) : '';
      data['birthDateController'].text = response['birthDate'].toString() != 'null' ? response['birthDate'].toString() : '';
      data['genderController'].text = response['gender'].toString() != 'null'
          ? response['gender'].toString() == '0'
              ? 'male'.tr
              : 'female'.tr
          : '';
      sendData = response;
      selectedButton = response['gender'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    // getRegions();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SimpleAppBar(
        appBar: AppBar(),
        title: 'Настройка',
        leading: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                        margin: const EdgeInsets.only(bottom: 20),
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
                            controller: data['nameController'],
                            onChanged: (value) {
                              setState(() {
                                sendData['name'] = value;
                              });
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person),
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
                              labelText: 'Имя'.tr,
                              labelStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                            ),
                            style: const TextStyle(color: Color(0xFF9C9C9C)),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 20),
                      //   child: Theme(
                      //     data: Theme.of(context).copyWith(
                      //       colorScheme: ThemeData().colorScheme.copyWith(
                      //             primary: red,
                      //           ),
                      //     ),
                      //     child: TextFormField(
                      //       inputFormatters: [maskFormatter],
                      //       validator: (value) {
                      //         if (value == null || value.isEmpty) {
                      //           return 'required_field'.tr;
                      //         }
                      //         return null;
                      //       },
                      //       controller: data['phoneController'],
                      //       onChanged: (value) {
                      //         if (value == '') {
                      //           setState(() {
                      //             data['phoneController'].text = '+998 ';
                      //             data['phoneController'].selection = TextSelection.fromPosition(TextPosition(offset: data['username'].text.length));
                      //           });
                      //         }
                      //         setState(() {
                      //           sendData['phone'] = value;
                      //         });
                      //       },
                      //       keyboardType: TextInputType.number,
                      //       decoration: InputDecoration(
                      //         prefixIcon: IconButton(
                      //           onPressed: () {},
                      //           icon: const Icon(
                      //             Icons.phone_iphone,
                      //           ),
                      //         ),
                      //         contentPadding: const EdgeInsets.all(18.0),
                      //         focusColor: red,
                      //         filled: true,
                      //         fillColor: Colors.transparent,
                      //         enabledBorder: const UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                      //         ),
                      //         focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: red),
                      //         ),
                      //         labelText: 'telephone_number'.tr + '(9* *** ** **)',
                      //         labelStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                      //       ),
                      //       style: const TextStyle(color: Color(0xFF9C9C9C)),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        // height: 45,
                        child: GestureDetector(
                          onTap: () {
                            selectDate(context);
                          },
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: red,
                                  ),
                            ),
                            child: TextFormField(
                              controller: data['birthDateController'],
                              validator: (_) {
                                if (data['birthDateController'].text == '') {
                                  return 'required_field'.tr;
                                }
                                return null;
                              },
                              onTap: () {},
                              decoration: InputDecoration(
                                enabled: false,
                                prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.calendar_month,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(18.0),
                                focusColor: red,
                                filled: true,
                                fillColor: Colors.transparent,
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: red),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: red),
                                ),
                                errorStyle: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                                labelText: 'Дата рождения'.tr,
                                labelStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                              ),
                              style: const TextStyle(color: Color(0xFF9C9C9C)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        // height: 45,
                        child: GestureDetector(
                          onTap: () {
                            showSelectGenger();
                          },
                          child: TextFormField(
                            controller: data['genderController'],
                            validator: (_) {
                              if (data['genderController'].text == '') {
                                return 'required_field'.tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabled: false,
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.female),
                              ),
                              contentPadding: const EdgeInsets.all(18.0),
                              focusColor: red,
                              filled: true,
                              fillColor: Colors.transparent,
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF9C9C9C)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: red),
                              ),
                              labelText: 'Пол'.tr,
                              labelStyle: const TextStyle(color: Color(0xFF9C9C9C)),
                            ),
                            style: const TextStyle(color: Color(0xFF9C9C9C)),
                          ),
                        ),
                      ),
                      // regions.isNotEmpty && sendData['regionId'] != '0' && sendData['regionId'] != 0
                      //     ? Container(
                      //         margin: const EdgeInsets.only(bottom: 25),
                      //         width: MediaQuery.of(context).size.width,
                      //         decoration: BoxDecoration(
                      //           border: Border(
                      //             bottom: BorderSide(
                      //               color: const Color(0xFF9C9C9C),
                      //               width: 1,
                      //             ),
                      //           ),
                      //         ),
                      //         child: DropdownButtonHideUnderline(
                      //           child: ButtonTheme(
                      //             alignedDropdown: true,
                      //             child: DropdownButton(
                      //               value: sendData['regionId'],
                      //               isExpanded: true,
                      //               hint: Text('${regions[0]['name']}'),
                      //               icon: const Icon(
                      //                 Icons.keyboard_arrow_down_rounded,
                      //                 size: 28,
                      //                 color: Color(0xFF9C9C9C),
                      //               ),
                      //               iconSize: 24,
                      //               iconEnabledColor: grey,
                      //               elevation: 16,
                      //               style: const TextStyle(color: Color(0xFF313131)),
                      //               underline: Container(),
                      //               onChanged: (newValue) {
                      //                 setState(() {
                      //                   sendData['regionId'] = newValue;
                      //                 });
                      //                 getCities(newValue);
                      //               },
                      //               items: regions.map((item) {
                      //                 return DropdownMenuItem<String>(
                      //                   value: '${item['id']}',
                      //                   child: Text(item['name']),
                      //                 );
                      //               }).toList(),
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     : Container(),
                      // cities.isNotEmpty && sendData['cityId'] != '0' && sendData['cityId'] != 0
                      //     ? Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         decoration: BoxDecoration(
                      //           border: Border(
                      //             bottom: BorderSide(
                      //               color: const Color(0xFF9C9C9C),
                      //               width: 1,
                      //             ),
                      //           ),
                      //         ),
                      //         child: ButtonTheme(
                      //           alignedDropdown: true,
                      //           child: DropdownButton(
                      //             value: sendData['cityId'],
                      //             isExpanded: true,
                      //             hint: Text('${cities[0]['name']}'),
                      //             icon: const Icon(
                      //               Icons.keyboard_arrow_down_rounded,
                      //               size: 28,
                      //               color: Color(0xFF9C9C9C),
                      //             ),
                      //             iconSize: 24,
                      //             iconEnabledColor: grey,
                      //             elevation: 16,
                      //             style: const TextStyle(color: Color(0xFF313131)),
                      //             underline: Container(),
                      //             onChanged: (newValue) {
                      //               setState(() {
                      //                 sendData['cityId'] = newValue;
                      //               });
                      //             },
                      //             items: cities.map((item) {
                      //               return DropdownMenuItem<String>(
                      //                 value: '${item['id']}',
                      //                 child: Text(item['name']),
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ),
                      //       )
                      //     : Container(),
                      SizedBox(
                        height: 70,
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                text: 'Сохранить',
                onClick: () {
                  if (_formKey.currentState!.validate()) {
                    updateUser();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic selectedButton = '0';

  showSelectGenger() async {
    return showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: ((context, genderSetState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   child: Row(
                //     children: [
                //       Radio(
                //         value: sendData['gender'] == '0',
                //         groupValue: SingingCharacter.lafayette,
                //         onChanged: (value) {},
                //       )
                //     ],
                //   ),
                // ),
                ListTile(
                  leading: Radio(
                    value: '0',
                    groupValue: selectedButton,
                    onChanged: (value) {
                      genderSetState(() {
                        selectedButton = '0';
                        sendData['gender'] = '0';
                        data['genderController'].text = 'male'.tr;
                      });
                      Get.back();
                    },
                    activeColor: red,
                  ),
                  title: Text('male'.tr),
                  onTap: () => genderSetState(() {
                    selectedButton = '0';
                    sendData['gender'] = '0';
                    data['genderController'].text = 'male'.tr;
                    Get.back();
                  }),
                ),
                ListTile(
                  leading: Radio(
                    value: '1',
                    groupValue: selectedButton,
                    onChanged: (value) {
                      genderSetState(() {
                        selectedButton = '1';
                        sendData['gender'] = '1';
                        data['genderController'].text = 'female'.tr;
                      });
                      Get.back();
                    },
                    activeColor: red,
                  ),
                  title: Text('female'.tr),
                  onTap: () => genderSetState(() {
                    selectedButton = '1';
                    sendData['gender'] = '1';
                    data['genderController'].text = 'female'.tr;
                    Get.back();
                  }),
                ),
              ],
            )),
      ),
    );
  }
}
