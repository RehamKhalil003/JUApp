import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'Profile.dart';
import 'RegistrationScreen.dart';
import 'InquiriesScreen.dart';

class CustomTabBarController extends StatefulWidget {
  @override
  _CustomTabBarControllerState createState() => _CustomTabBarControllerState();
}

class _CustomTabBarControllerState extends State<CustomTabBarController> {
  int _selectedIndex = 0;
  late double _indicatorPosition;

  final List<Widget> _pages = [
    HomeScreen(),
    RegistrationScreen(),
    // InquiriesScreen(),
    MyProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _indicatorPosition = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _indicatorPosition = index.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: const Color(0xFF00a650),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white60,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.app_registration),
                label: 'Registration',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          left: MediaQuery.of(context).size.width / _pages.length * _indicatorPosition,
          child: Container(
            width: MediaQuery.of(context).size.width / _pages.length,
            height: 4,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

