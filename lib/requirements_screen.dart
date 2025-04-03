import 'package:flutter/material.dart';
import 'package:my_first_project/requirement_item.dart';

class RequirementsScreen extends StatelessWidget {
  const RequirementsScreen({super.key});

  final List<String> requirements = const [
    "Compulsory University Requirements (18) Credit Hours",
    "Elective University Requirements (9) Credit Hours",
    "Compulsory College Requirements (24) Credit Hours",
    "Compulsory Major Requirements (69) Credit Hours",
    "Elective Major Requirements (12) Credit Hours",
    "General Compulsory Requirements (15) Credit Hours",
    "Remedial Courses that the student must register",
    "Courses Outside the Plan"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Study Plan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF00a650), // Updated AppBar color
        iconTheme: const IconThemeData(color: Colors.white), // White back button
      ),
      body: ListView.builder(
        itemCount: requirements.length,
        itemBuilder: (context, index) {
          return RequirementItem(title: requirements[index]);
        },
      ),
    );
  }
}
