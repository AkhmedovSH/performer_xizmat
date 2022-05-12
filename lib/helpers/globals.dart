import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

dynamic mainUrl = 'https://admin.xizmat24.uz';

Color black = Color(0xFF40484E);
Color darkGrey = Color(0xFF727272);
Color grey = Color(0xFFF1F1F1);
Color lightGrey = Color(0xFF9C9C9C);
Color green = Color(0xFF38B135);
Color red = Color(0xFFFF5453);
Color darkRed = Color(0xFFE32F45);
Color orange = Color(0xFFFD6F4E);
Color white = Color(0xFFFFFFFF);
Color inputColor = Color(0xFFF3F7FA);
Color yellow = Color(0xFFF3A919);
Color borderColor = Color(0xFFF8F8F8);

formatUnixTime(unixTime) {
  var dt = DateTime.fromMillisecondsSinceEpoch(unixTime);
  return DateFormat('dd.MM.yyyy HH:mm').format(dt);
}

formatMoney(amount) {
  if (amount != null && amount != '') {
    amount = double.parse(amount.toString());
    return NumberFormat.currency(symbol: '', decimalDigits: 2, locale: 'UZ').format(amount);
  } else {
    return NumberFormat.currency(symbol: '', decimalDigits: 2, locale: 'UZ').format(0);
  }
}

formatPhone(phone) {
  var x = phone.substring(0, 3);
  var y = phone.substring(3, 5);
  var z = phone.substring(5, 8);
  var d = phone.substring(8, 10);
  var q = phone.substring(10, 12);
  return '+' + x + ' ' + '($y)' + ' ' + z + ' ' + d + ' ' + q;
}

showSuccessToast(message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xFF28a745),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showErrorToast(message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xFFE32F45),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
