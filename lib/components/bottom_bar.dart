import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../globals.dart' as globals;

//ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int? active;
  BottomBar({Key? key, this.active}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // int active = 0;

  onItemTab(int index) {
    print(index);
    if (index != widget.active) {
      setState(() {
        // active = index;
      });

      switch (index) {
        case 0:
          Get.offAllNamed('/');
          break;
        case 1:
          Get.offAllNamed(
            '/orders',
          );
          break;
        case 2:
          Get.offAllNamed('/profile');
          break;
        case 3:
          Get.offAllNamed(
            '/support',
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: globals.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: -3, blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            onTap: onItemTab,
            currentIndex: widget.active!,
            backgroundColor: globals.white,
            selectedItemColor: globals.black,
            selectedIconTheme: IconThemeData(color: globals.black),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Главная'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt, color: Color(0xFF828282)),
                  label: 'Мои заказы'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Color(0xFF828282)),
                  label: 'Профиль'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.headset_mic, color: Color(0xFF828282)),
                  label: 'Поддержка'),
            ]),
      ),
    );
  }
}

// BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         // showSelectedLabels: false,
//         // showUnselectedLabels: false,
//         onTap: onItemTab,
//         currentIndex: widget.active!,
//         backgroundColor: globals.white,
//         selectedItemColor: globals.black,
        
//         selectedIconTheme: IconThemeData(color: globals.black),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             label: 'Главная'
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.list_alt, color: Color(0xFF828282)),
//               label: 'Мои заказы'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person, color: Color(0xFF828282)),
//               label: 'Профиль'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.headset_mic, color: Color(0xFF828282)),
//               label: 'Поддержка'),
//         ])