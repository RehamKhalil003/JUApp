import 'package:flutter/material.dart';

class MidtermResultsPage extends StatelessWidget {
  final List<Map<String, String>> midtermResults = [
    {'Course': 'Big Data', 'Grade': 'B', 'Points': '3.0'},
    {'Course': 'Data Science', 'Grade': 'A-', 'Points': '3.7'},
    {'Course': 'AI Fundamentals', 'Grade': 'B+', 'Points': '3.5'},
    {'Course': 'Job Prep 3', 'Grade': 'B-', 'Points': '2.7'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Midterm Results"),
        backgroundColor: Color(0xFF00A650),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[200]),
              children: [
                tableHeader("Course"),
                tableHeader("Grade"),
                tableHeader("Points"),
              ],
            ),
            ...midtermResults.map(
                  (result) => TableRow(
                children: [
                  tableCell(result['Course']!),
                  tableCell(result['Grade']!),
                  tableCell(result['Points']!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableHeader(String text) => Padding(
    padding: const EdgeInsets.all(10),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget tableCell(String text) => Padding(
    padding: const EdgeInsets.all(10),
    child: Text(text),
  );
}
