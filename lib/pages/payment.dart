import 'package:flutter/material.dart';

import '../helpers/globals.dart' ;
import '../../widgets.dart' as widgets;

import '../../components/simple_app_bar.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  dynamic character = 1;

  Widget buildTextField(String text) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(18.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Color(0xFFECECEC), width: 1.0),
        ),
        filled: true,
        fillColor: inputColor,
        hintText: text,
        hintStyle: TextStyle(
            color: Color(0xFF7A7A7A),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      style: TextStyle(color: inputColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Пополнить баланс',
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(16, 14, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Сумма оплаты',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  buildTextField('Введите сумму')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Номер карты*',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  buildTextField('0000 0000 0000 0000')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Срок действия:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: buildTextField('01'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 19),
                        child: Text(
                          '/',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF363F4D)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: buildTextField('01'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text('Пароль карты',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  buildTextField('Введите пароль')
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 32),
        child: widgets.Button(
          text: 'Подтвердить оплату',
          onClick: () {},
        ),
      ),
    );
  }
}
