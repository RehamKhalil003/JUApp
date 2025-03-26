import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'Profile.dart';
import 'RegistrationScreen.dart';

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
    SearchScreen(),
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
                icon: ImageIcon(AssetImage('assets/home-image.jpeg')),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/registration.jpeg')),
                label: 'Registration',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/request-image.jpeg')),
                label: 'Electronic Request',
              ),
              // BottomNavigationBarItem(
              //   icon: ImageIcon(AssetImage('assets/purchases-image.jpeg')),
              //   label: 'My Purchases',
              // ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/profile-image.jpeg')),
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

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Screen'));
  }
}

class MyPurchasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('My Purchases Screen'));
  }
}

