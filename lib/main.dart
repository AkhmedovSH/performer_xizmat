import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';

import 'helpers/globals.dart';
import 'helpers/translations.dart';

// Main

import 'package:xizmat/pages/splash.dart';

import 'pages/dashboard/dashboard.dart';
import 'pages/chat.dart';
import 'pages/dashboard/balance.dart';
import 'pages/payment.dart';
import 'pages/dashboard/support.dart';

// Profile

import 'pages/dashboard/profile.dart';
import 'pages/Profile/speciality.dart';
import 'pages/Profile/speciality2.dart';
import 'pages/Profile/speciality3.dart';
import 'pages/Profile/add_category.dart';
import 'pages/Profile/category_inside.dart';
import 'pages/Profile/why_need_verification.dart';
import 'pages/Profile/about_me.dart';
import 'pages/Profile/profile_upload_photo.dart';

// Auth

import 'pages/auth/login.dart';
import 'pages/auth/register.dart';
import 'pages/auth/confirmation.dart';
import 'pages/auth/select_category.dart';
import 'pages/auth/choose_specialization.dart';
import 'pages/auth/service_area.dart';
import 'pages/auth/choose_regions.dart';
import 'pages/auth/upload_photo.dart';
import 'pages/auth/verification.dart';

// Orders

import 'pages/Order/proposed_orders.dart';
import 'pages/Order/current_orders.dart';
import 'pages/Order/completed_orders.dart';
import 'pages/Order/about_new_order.dart';
import 'pages/Order/about_offered_order.dart';
import 'pages/Order/about_completed_order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, 
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: const Locale('ru', 'RU'),
      fallbackLocale: const Locale('uz', 'UZ'),
      debugShowCheckedModeBanner: false,
      popGesture: true,
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 250),
      theme: ThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        brightness: Brightness.light,
        primaryColor: red,
        platform: TargetPlatform.android,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: black,
              displayColor: black,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: red,
          ),
        ),
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => Splash()),

        GetPage(name: '/chat', page: () => Chat()),
        GetPage(name: '/balance', page: () => Balance()),
        GetPage(name: '/payment', page: () => Payment()),
        GetPage(name: '/support', page: () => Support()),

        // Profile

        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/speciality', page: () => Speciality()),
        GetPage(name: '/speciality-2', page: () => Speciality2()),
        GetPage(name: '/speciality-3', page: () => Speciality3()),
        GetPage(name: '/add-category', page: () => AddCategory()),
        GetPage(name: '/category-inside', page: () => CategoryInside()),
        GetPage(name: '/why-need-verification', page: () => WhyNeedVerification()),
        GetPage(name: '/about-me', page: () => AboutMe()),
        GetPage(name: '/profile-upload-photo', page: () => ProfileUploadPhoto()),

        // Order

        GetPage(name: '/', page: () => const Dashboard()),
        GetPage(name: '/order-inside', page: () => AboutNewOrder()),
        GetPage(name: '/about-offered-order', page: () => AboutOfferedOrder()),
        GetPage(name: '/proposed-orders', page: () => ProposedOrders()),
        GetPage(name: '/current-orders', page: () => CurrentOrders()),
        GetPage(name: '/completed-orders', page: () => CompletedOrders()),
        GetPage(name: '/about-completed-order', page: () => AboutCompletedOrder()),

        // Auth
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/confirmation', page: () => Confirmation()),
        GetPage(name: '/select-category', page: () => SelectCategory()),
        GetPage(name: '/verification', page: () => Verification()),
        GetPage(name: '/choose-specialization', page: () => ChooseSpecialization()),
        GetPage(name: '/upload-photo', page: () => UploadPhoto()),
        GetPage(name: '/service-area', page: () => ServiceArea()),
        GetPage(name: '/choose-regions', page: () => ChooseRegions()),
      ],
    );
  }
}
