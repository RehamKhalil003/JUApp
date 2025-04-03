import 'package:flutter/material.dart';
import 'package:my_first_project/course_details_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  final List<Map<String, String>> courses = const [
    {"code": "1901902", "name": "Algorithms"},
    {"code": "1901906", "name": "Computer Networks"},
    {"code": "1902910", "name": "Software Engineering"},
    {"code": "1902912", "name": "Databases"},
    {"code": "1902914", "name": "Artificial Intelligence"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF00a650), // Updated AppBar color
        iconTheme: const IconThemeData(color: Colors.white), // White back button
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(courses[index]['name']!),
            subtitle: const Text('Credits: 3'),
            trailing: IconButton(
              icon: const Icon(Icons.search, color: Color(0xFF00a650)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailsScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
