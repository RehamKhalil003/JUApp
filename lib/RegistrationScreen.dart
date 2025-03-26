import 'package:flutter/material.dart';
import 'package:my_first_project/StudyLoadScreen.dart';
import 'package:my_first_project/UniversityFeesScreen.dart';
import 'package:my_first_project/WithdrawalRequests.dart';
import 'CancelRequest.dart';
import 'TimeReservation.dart';
import 'package:my_first_project/Chat/ChatScreen.dart';

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Academic System', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 20)),
        backgroundColor: const Color(0xFF00a650),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: menuItems.map((item) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF00a650), // Green
                      const Color(0xFF00cc66), // Slightly lighter green for depth
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  children: [
                    Icon(
                      item['icon'],
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );


          }).toList(),
        ),
      ),
      // 🟢 Floating Action Button for Chat
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        backgroundColor: const Color(0xFF00a650), // Match theme color
        child: const Icon(Icons.chat, color: Colors.white),
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
