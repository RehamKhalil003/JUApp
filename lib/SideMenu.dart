import 'package:flutter/material.dart';
import 'package:my_first_project/MidtermResultsPage.dart';
import 'package:my_first_project/FinalResultsPage.dart';
import 'package:my_first_project/SpecializationsApp.dart';
import 'package:my_first_project/TrainingApprovalForm.dart';
import 'package:my_first_project/Clearance.dart';
import 'package:my_first_project/AskGuide.dart';

class SideMenu extends StatelessWidget {
  final Function(String) onItemTap;
  final BuildContext context;

  const SideMenu({super.key, required this.onItemTap, required this.context});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => onItemTap('home'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => onItemTap('profile'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => onItemTap('settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => onItemTap('logout'),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Half results'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MidtermResultsPage())),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_turned_in),
            title: const Text('Final result'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => FinalResultsPage())),
          ),
          ListTile(
            leading: const Icon(Icons.transfer_within_a_station),
            title: const Text('Fields allow to users to transfer to it'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => SpecializationsPage())),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Training place'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => TrainingApprovalForm())),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: const Text('Financial liability'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => ClearancePage())),
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Ask question'),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => InquiriesScreen())),
          ),
        ],
      ),
    );
  }
}
