import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../globals.dart' as globals;
import '../../../widgets.dart' as widgets;

import '../../../components/bottom_bar.dart';
import '../../../components/simple_app_bar.dart';

class OrderByManagerSuccess extends StatefulWidget {
  const OrderByManagerSuccess({Key? key}) : super(key: key);

  @override
  _OrderByManagerSuccessState createState() => _OrderByManagerSuccessState();
}

class _OrderByManagerSuccessState extends State<OrderByManagerSuccess> {
  dynamic character = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 7),
            child: Text(
              'Спасибо!',
              style: TextStyle(
                  color: Color(0xFF363F4D),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 22),
            child: Text(
              'Ваши данные отправлены, в ближайшее время менеджер свяжется с вами.',
              style: TextStyle(
                  color: Color(0xFF363F4D),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Text(
                  'Перейти на главную',
                  style: TextStyle(
                      color: Color(0xFFE32F45),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Color(0xFFE32F45),
              )
            ],
          )
        ],
      ),
    );
  }
}
