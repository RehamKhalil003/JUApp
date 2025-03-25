import 'package:flutter/material.dart';

class ClosedRequestsTable extends StatefulWidget {
  @override
  _ClosedRequestsTableState createState() => _ClosedRequestsTableState();
}

class _ClosedRequestsTableState extends State<ClosedRequestsTable> {
  List<Map<String, String>> closedRequests = [
    {'Date': '2024-12-10', 'Status': 'Approved', 'Course Name': 'Big Data'},
    {'Date': '2025-02-06', 'Status': 'Pending', 'Course Name': 'Data Visualization'},
    {'Date': '2024-12-10', 'Status': 'Pending', 'Course Name': 'Cloud Computing'},
    {'Date': '2024-12-10', 'Status': 'Pending', 'Course Name': 'Deep Learning'},
  ];

  void cancelRequest(int index) {
    setState(() {
      closedRequests[index]['Status'] = 'Cancelled';
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green[400]!;
      case 'Pending':
        return Colors.yellow[700]!;
      case 'Cancelled':
        return Colors.red[400]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Closed Requests", style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF0088d1),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: closedRequests.length,
        itemBuilder: (context, index) {
          final request = closedRequests[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request['Course Name']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Date: ${request['Date']}"),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: getStatusColor(request['Status']!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Status: ${request['Status']}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (request['Status'] == 'Pending')
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => cancelRequest(index),
                        style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
                        child: const Text(
                          "Cancel Request",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(color: Colors.grey, thickness: 0.8),
      ),
    );
  }
}
