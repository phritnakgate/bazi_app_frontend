import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:bazi_app_frontend/widgets/authenticated_screen/authenticated_screen_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({super.key});

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  int bottomNavIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      bottomNavIndex = index;
    });
  }

  Map<int, Widget> widgetOptions = {
    0: HomeWidget(),
    1: CalendarWidget(),
    2: ProfileWidget(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widgetOptions[bottomNavIndex]!,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
              currentIndex: bottomNavIndex,
              onTap: onItemTapped,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: wColor,
              unselectedItemColor: Theme.of(context).disabledColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'หน้าหลัก',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'ปฏิทินวันดี',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'ข้อมูลส่วนตัว',
                ),
              ]),
        ));
  }
}
