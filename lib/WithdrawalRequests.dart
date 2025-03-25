import 'package:flutter/material.dart';

class WithdrawalRequestsTable extends StatefulWidget {
  @override
  _WithdrawalRequestsTableState createState() => _WithdrawalRequestsTableState();
}

class _WithdrawalRequestsTableState extends State<WithdrawalRequestsTable> {
  List<String> withdrawalRequests = [
    'Machine Learning',
    'Cyber Security',
    'Artificial Intelligence',
    'Software Engineering',
  ];

  void confirmWithdrawal(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Withdrawal"),
          content: Text("Are you sure you want to drop ${withdrawalRequests[index]}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  withdrawalRequests.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Confirm", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdrawal Requests", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF0088d1),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: withdrawalRequests.length,
        itemBuilder: (context, index) {
          final courseName = withdrawalRequests[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    courseName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => confirmWithdrawal(index),
                    style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
                    child: const Text(
                      "withdrawal",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
