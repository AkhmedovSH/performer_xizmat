import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './globals.dart' as globals;

import 'pages/index.dart';
import 'pages/chat.dart';
import 'pages/balance.dart';
import 'pages/payment.dart';
import 'pages/support.dart';

import 'pages/Profile/profile.dart';
import 'pages/Profile/speciality.dart';
import 'pages/Profile/add_category.dart';
import 'pages/Profile/category_inside.dart';
import 'pages/Profile/verification.dart';
import 'pages/Profile/why_need_verification.dart';

import 'pages/Register/register.dart';
import 'pages/Register/confirmation.dart';
import 'pages/Register/select_category.dart';
import 'pages/Register/choose_specialization.dart';
import 'pages/Register/service_area.dart';
import 'pages/Register/upload_photo.dart';

import 'pages/Order/proposed_orders.dart';
import 'pages/Order/current_orders.dart';
import 'pages/Order/completed_orders.dart';
import 'pages/Order/about_new_order.dart';
import 'pages/Order/about_offered_order.dart';
import 'pages/Order/about_completed_order.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      popGesture: true,
      defaultTransition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 250),
      theme: ThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        brightness: Brightness.light,
        primaryColor: Color(0xFFFF5453),
        platform: TargetPlatform.android,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: globals.black,
              displayColor: globals.black,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: globals.red,
          ),
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/balance', page: () => Balance()),
        GetPage(name: '/payment', page: () => Payment()),
        GetPage(name: '/support', page: () => Support()),

        // Profile

        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/speciality', page: () => Speciality()),
        GetPage(name: '/add-category', page: () => AddCategory()),
        GetPage(name: '/category-inside', page: () => CategoryInside()),
        GetPage(name: '/verification', page: () => Verification()),
        GetPage(name: '/why-need-verification', page: () => WhyNeedVerification()),

        // Order

        GetPage(name: '/', page: () => Index()),
        GetPage(name: '/order-inside', page: () => AboutNewOrder()),
        GetPage(name: '/about-offered-order', page: () => AboutOfferedOrder()),
        GetPage(name: '/proposed-orders', page: () => ProposedOrders()),
        GetPage(name: '/current-orders', page: () => CurrentOrders()),
        GetPage(name: '/completed-orders', page: () => CompletedOrders()),
        GetPage(
            name: '/about-completed-order', page: () => AboutCompletedOrder()),

        // Register

        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/confirmation', page: () => Confirmation()),
        GetPage(name: '/select-category', page: () => SelectCategory()),
        GetPage(
            name: '/choose_specialization', page: () => ChooseSpecialization()),
        GetPage(name: '/service-area', page: () => ServiceArea()),
        GetPage(name: '/upload-photo', page: () => UploadPhoto()),
      ],
    );
  }
}
