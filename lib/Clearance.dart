import 'package:flutter/material.dart';

class ClearancePage extends StatelessWidget {
  const ClearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final headers = [
      'Departments that require clearance',
      'Reason for Hold',
      'Notes',
    ];

    final rows = [
      ['Scientific Research', 'Student is cleared', 'No remarks'],
      ['Warehouses and Laboratories', 'Student is cleared', 'No issues'],
      ['Financial Affairs Unit', 'Student is cleared', 'Paid in full'],
      ['Library', 'Student is cleared', ''],
      ['Admissions and Registration Unit', 'Student is cleared', ''],
      ['Faculty Members', 'Student is cleared', 'Cleared by supervisor'],
      ['Deanship of Student Affairs', 'Student is cleared', ''],
      ['Teachers’ Children Grant', 'Student is cleared', 'Eligible'],
      ['Armed Forces Workers’ Children Grant', 'Student is cleared', ''],
      ['Dormitories Department', 'Student is cleared', 'No pending items'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clearance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF00a650),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Note: You must visit the departments that require clearance.",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              interactive: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: headers
                      .map((header) => DataColumn(
                    label: Text(
                      header,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ))
                      .toList(),
                  rows: rows
                      .map(
                        (row) => DataRow(
                      cells: row
                          .map(
                            (cell) => DataCell(
                          Text(cell),
                        ),
                      )
                          .toList(),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
