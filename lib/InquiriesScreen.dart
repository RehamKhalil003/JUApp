import 'package:flutter/material.dart';
import 'package:my_first_project/MidtermResultsPage.dart';
import 'package:my_first_project/FinalResultsPage.dart';
import 'package:my_first_project/SpecializationsApp.dart';
import 'package:my_first_project/TrainingApprovalForm.dart';
import 'package:my_first_project/Clearance.dart';
import 'package:my_first_project/AskGuide.dart';

void main() {
  runApp(MaterialApp(
    home: InquiriesScreen(),
  ));
}

class InquiriesScreen extends StatelessWidget {
  final List<String> buttonTitles = [
    "Half results",
    "Final result",
    "Fields allow to users to transfer to it",
    "Traning place",
    "Financial liability",
    "Ask question",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Info",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
        //   onPressed: () => Navigator.pop(context),
        // ),
        backgroundColor: const Color(0xFF00a650),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: buttonTitles.map((title) {
            return ElevatedButton(
              onPressed: () {
                switch (title) {
                  case "Half results":
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MidtermResultsPage()));
                    break;
                  case "Final result":
                    Navigator.push(context, MaterialPageRoute(builder: (_) => FinalResultsPage()));
                    break;
                  case "Fields allow to users to transfer to it":
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SpecializationsPage()));
                    break;
                  case "Traning place":
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TrainingApprovalForm()));
                    break;
                  case "Financial liability":
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ClearancePage()));
                    break;
                  case "Ask question":
                    Navigator.push(context, MaterialPageRoute(builder: (_) => InquiriesScreen()));
                    break;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00a650),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}