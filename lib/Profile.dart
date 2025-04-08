import 'package:flutter/material.dart';
import 'package:my_first_project/StudentInfoForm.dart';
import 'package:my_first_project/change_password.dart';
import 'package:my_first_project/Chat/ChatScreen.dart';
import 'package:my_first_project/MidtermResultsPage.dart';
import 'package:my_first_project/FinalResultsPage.dart';
import 'package:my_first_project/SpecializationsApp.dart';
import 'package:my_first_project/TrainingApprovalForm.dart';
import 'package:my_first_project/Clearance.dart';
import 'package:my_first_project/AskGuide.dart';
import 'CancelRequest.dart';
import 'TimeReservation.dart';

class MyProfileScreen extends StatelessWidget {
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

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF00a650),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Reham Khalil Saleh Abu Hadbah',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'King Abdullah II School for Information Technology\nData Science',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset("assets/email.jpeg", width: 24, height: 24),
                      title: const Text('rha0217056@ju.edu.jo'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Image.asset("assets/payment-card.jpeg", width: 24, height: 24),
                      title: const Text('7790217056'),
                      subtitle: const Text('Payment Number (Fawateercom)'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Image.asset("assets/school.jpeg", width: 24, height: 24),
                      title: const Text('Royal Makruma Scholarship'),
                      subtitle: const Text('Sponsoring Entity'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 15),
              _buildGradientButton(
                text: "Student Info Form",
                colors: [Color(0xFF00a650), Colors.white],
                imagePath: "assets/profile-image.jpeg",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentInfoForm()),
                  );
                },
                // child: const Icon(Icons.person),
              ),
              const SizedBox(height: 15),
              _buildGradientButton(
                text: "Change Password",
                imagePath: "assets/change-password.jpeg",
                colors: [Colors.grey, Colors.white],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildGradientButton(
                text: "Logout",
                imagePath: "assets/log-out.jpeg",
                colors: [Colors.redAccent, Colors.white],
                onPressed: () {
                  _showLogoutConfirmation(context);
                },
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildGradientButton({
    required String text,
    required String imagePath,
    required List<Color> colors,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(imagePath, width: 24, height: 24),
        label: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout action
            },
            child: const Text(
              'Log out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
