import 'package:flutter/material.dart';

class StudyLoadScreen extends StatefulWidget {
  @override
  _StudyLoadScreenState createState() => _StudyLoadScreenState();
}

class _StudyLoadScreenState extends State<StudyLoadScreen> {
  String? selectedPermissionType;
  String? selectedReason;
  int hours = 0;
  final TextEditingController requestStatusController = TextEditingController();

  final List<String> permissionTypes = ["---", "More than", "Less than"];
  final List<String> reasons = [
    "---",
    "Expected graduation of the student for the current semester - 2024 second",
    "Registration of insurance or training only (zero hours)",
    "Registration of 9-11 hours for non-graduates (Bachelor for regular semester, not summer)"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Automated Study Load", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Ensures content scrolls if needed
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Academic Year: 2024", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("Semester: 2", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),

                  // Required Permission Type
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Required Permission Type*",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    value: selectedPermissionType,
                    isExpanded: true, // Prevents overflow
                    items: permissionTypes.map((String type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPermissionType = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Reason Dropdown
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: "Reason",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    value: selectedReason,
                    isExpanded: true, // Prevents text overflow
                    items: reasons.map((String reason) {
                      return DropdownMenuItem(value: reason, child: Text(reason, overflow: TextOverflow.ellipsis));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Number of Hours
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Number of Hours",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        hours = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Request Status
                  TextFormField(
                    controller: requestStatusController,
                    decoration: InputDecoration(
                      labelText: "Request Status",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text("Save", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
