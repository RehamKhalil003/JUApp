import 'package:flutter/material.dart';
import 'package:my_first_project/StudyLoadScreen.dart';
import 'package:my_first_project/UniversityFeesScreen.dart';
import 'package:my_first_project/WithdrawalRequests.dart';
import 'package:my_first_project/requirements_screen.dart';
import 'package:my_first_project/MidtermResultsPage.dart';
import 'package:my_first_project/FinalResultsPage.dart';
import 'package:my_first_project/SpecializationsApp.dart';
import 'package:my_first_project/TrainingApprovalForm.dart';
import 'package:my_first_project/Clearance.dart';
import 'package:my_first_project/AskGuide.dart';
import 'CancelRequest.dart';
import 'TimeReservation.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Time Reservation', 'icon': Icons.calendar_today},
    {'title': 'Course Registration', 'icon': Icons.grid_view},
    {'title': 'Cancel Requests', 'icon': Icons.cancel},
    {'title': 'Withdrawal without Record', 'icon': Icons.remove},
    {'title': 'Automatic Study Load', 'icon': Icons.school},
    {'title': 'Pay University Fees', 'icon': Icons.payment},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00a650),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Half results'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MidtermResultsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Final result'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinalResultsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.transfer_within_a_station),
              title: const Text('Fields allow to users to transfer to it'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpecializationsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Training place'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrainingApprovalForm()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Financial liability'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClearancePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Ask question'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InquiriesScreen()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Academic System',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF00a650),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: menuItems.map((item) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00a650),
                      Color(0xFF00cc66),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  leading: Icon(item['icon'], color: Colors.white),
                  title: Text(
                    item['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    if (item['title'] == 'Time Reservation') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Timereservation()),
                      );
                    } else if (item['title'] == 'Course Registration') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RequirementsScreen()),
                      );
                    } else if (item['title'] == 'Cancel Requests') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClosedRequestsTable()),
                      );
                    } else if (item['title'] == 'Withdrawal without Record') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WithdrawalRequestsTable()),
                      );
                    } else if (item['title'] == 'Automatic Study Load') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StudyLoadScreen()),
                      );
                    } else if (item['title'] == 'Pay University Fees') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UniversityFees()),
                      );
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegistrationScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
