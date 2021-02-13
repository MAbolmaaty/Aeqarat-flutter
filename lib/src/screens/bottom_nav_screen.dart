import 'package:aeqarat/src/screens/home_screen.dart';
import 'package:aeqarat/src/screens/notifications_screen.dart';
import 'package:aeqarat/src/screens/profile_screen.dart';
import 'package:aeqarat/src/screens/real_estates_screen.dart';
import 'package:aeqarat/src/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => BottomNavScreen(),
      );

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 2;
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          NotificationsScreen(),
          ProfileScreen(),
          HomeScreen(),
          RealEstatesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFFDB27),
        unselectedItemColor: const Color(0xFFCCCCCC),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: "Notifications"),
          BottomNavigationBarItem(
              icon: loggedIn ? Icon(Icons.person_outline) : Icon(Icons.login), label: loggedIn ? "Profile" : "Login"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_work_outlined), label: "Real Estates"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
