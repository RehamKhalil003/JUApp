import 'package:flutter/material.dart';

class RegisteredCoursesSection extends StatelessWidget {
  final int initialVisibleCourses;
  final bool showAll;
  final VoidCallback onToggle;

  final List<Map<String, String>> registeredCourses = [
    {'Course ID': '1915498', 'Course Name': 'Job Preparation 3 (Skills)', 'Time': '11:30 AM - 3:30 PM', 'Day': 'Sunday, Monday, Tuesday, Wednesday, Thursday', 'Room': 'Accounting'},
    {'Course ID': '1915431', 'Course Name': 'Big Data', 'Time': '10:00 AM - 11:30 AM', 'Day': 'Tuesday, Thursday', 'Room': 'Technology Lab 102'},
    {'Course ID': '1915401', 'Course Name': 'Data Science 101', 'Time': '-', 'Day': '-', 'Room': 'Accounting'},
    {'Course ID': '1915499', 'Course Name': 'AI Fundamentals', 'Time': '-', 'Day': '-', 'Room': 'Accounting'},
  ];

  RegisteredCoursesSection({
    required this.initialVisibleCourses,
    required this.showAll,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final visibleCourses = showAll ? registeredCourses : registeredCourses.take(initialVisibleCourses).toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Registered Courses",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleCourses.length,
              itemBuilder: (context, index) {
                final item = visibleCourses[index];
                return ListTile(
                  title: Text(item['Course Name'] ?? ''),
                );
              },
              separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            ),
            if (registeredCourses.length > initialVisibleCourses)
              TextButton(
                child: Text(showAll ? "Show Less" : "Show More"),
                onPressed: onToggle,
              ),
          ],
        ),
      ),
    );
  }
}
