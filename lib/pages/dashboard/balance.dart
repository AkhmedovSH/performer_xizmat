import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/globals.dart' as globals;
import '../../../widgets.dart' as widgets;

import '../../components/bottom_bar.dart';
import '../../../components/simple_app_bar.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Баланс',
        appBar: AppBar(),
        leading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              margin: EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(color: globals.inputColor, borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                children: [
                  Text(
                    'Текущий баланс',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF363F4D)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    child: Text(
                      '200 000  сум',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF363F4D)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: widgets.Button(
                      text: 'Пополнить баланс',
                      onClick: () {
                        Get.toNamed('/payment');
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(Icons.support_agent),
                      ),
                      Text('Служба поддержки', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'История оплат',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF363F4D)),
              ),
            ),
            for (var i = 0; i < 2; i++)
              Container(
                padding: EdgeInsets.only(bottom: 15),
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: globals.borderColor, width: 1))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Заказ№ 345 666', style: TextStyle(color: globals.darkGrey, fontWeight: FontWeight.w500)),
                        Text('09.20.2021, 13:00', style: TextStyle(color: globals.darkGrey, fontWeight: FontWeight.w500))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4, bottom: 2),
                      child: Text(
                        '200 000 сум',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(
                      'Комиссия: 25 000 сум',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
