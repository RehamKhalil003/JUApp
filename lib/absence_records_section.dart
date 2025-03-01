import 'package:flutter/material.dart';

class AbsenceRecordsSection extends StatelessWidget {
  final int initialVisibleCourses;
  final bool showAll;
  final VoidCallback onToggle;

  final List<Map<String, String>> absenceRecords = [
    {'Subject Name': 'Big Data', 'Absence Count': '2'},
    {'Subject Name': 'Job Preparation 3 (Skills)', 'Absence Count': '1'},
    {'Subject Name': 'Job Preparation 2 (Project)', 'Absence Count': '3'},
  ];

  AbsenceRecordsSection({
    required this.initialVisibleCourses,
    required this.showAll,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final visibleRecords = showAll ? absenceRecords : absenceRecords.take(initialVisibleCourses).toList();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Student Absences",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visibleRecords.length,
              itemBuilder: (context, index) {
                final item = visibleRecords[index];
                return ListTile(
                  title: Text("${item['Subject Name']}: ${item['Absence Count']} absences"),
                );
              },
              separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            ),
            if (absenceRecords.length > initialVisibleCourses)
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
