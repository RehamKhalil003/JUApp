import 'package:flutter/material.dart';
import 'package:my_first_project/change_password.dart';
import 'package:my_first_project/Chat/ChatScreen.dart';
class MyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              // const SizedBox(height: 25),
              // _buildGradientButton(
              //   text: "Edit Info",
              //   imagePath: "assets/edit-information.jpeg",
              //   colors: [Colors.blueAccent, Colors.lightBlueAccent],
              //   onPressed: () {
              //     // Handle edit info action
              //   },
              // ),
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
