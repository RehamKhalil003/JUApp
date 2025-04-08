import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class TrainingApprovalForm extends StatefulWidget {
  const TrainingApprovalForm({super.key});

  @override
  State<TrainingApprovalForm> createState() => _TrainingApprovalFormState();
}

class _TrainingApprovalFormState extends State<TrainingApprovalForm> {
  bool isTrainingSelected = true;
  final List<Map<String, String>> courses = [];
  int totalCourseHours = 0;

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Info",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF00a650),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTrainingSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isTrainingSelected ? const Color(0xFF00a650) : Colors.grey[300],
                      foregroundColor: isTrainingSelected ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Training"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTrainingSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isTrainingSelected ? const Color(0xFF00a650) : Colors.grey[300],
                      foregroundColor: !isTrainingSelected ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Course"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isTrainingSelected) _buildTrainingForm() else _buildCourseSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingForm() {
    return Column(
      children: [
        _buildTextField("Company Name / E"),
        _buildTextField("Training Location"),
        _buildTextField("Supervisor Email"),
        _buildTextField("Company Notes"),
        _buildTextField("Supervisor Notes"),
        _buildTextField("Supervisor Decision", value: "Pending"),
        _buildTextField("Final Student Status"),
        _buildDatePickerField("From Date", fromDateController),
        _buildDatePickerField("To Date", toDateController),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () async {
            await FilePicker.platform.pickFiles();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.attach_file),
          label: const Text("Choose Attachment"),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00a650),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text("Save", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(color: Colors.red),
              ),
              child: const Text("Delete", style: TextStyle(color: Colors.red, fontSize: 16)),
            )
          ],
        )
      ],
    );
  }

  Widget _buildCourseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // Display all courses
        for (var course in courses)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Name and Description
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course['name'] ?? 'Course Name',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course['desc'] ?? 'Description not available',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Course Details (Hours, Dates, Link)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hours: ${course['hours'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'From: ${course['from'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'To: ${course['to'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Link: ${course['link'] ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Approve/Reject buttons
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          // Approve action
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            courses.remove(course); // Remove the course from the list
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        const SizedBox(height: 8),
        const Text(
          "** Total training hours must be at least 90 hours",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => _showAddCourseDialog(),
          icon: const Icon(Icons.add),
          label: const Text("Add Course"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00a650),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }

  void _showAddCourseDialog() {
    final nameController = TextEditingController();
    final orgController = TextEditingController();
    final hoursController = TextEditingController();
    final descController = TextEditingController();
    final fromDateController = TextEditingController();
    final toDateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Course Details"),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _dialogTextField("Course Name", nameController),
                _dialogTextField("Provider Organization", orgController),
                _dialogTextField("Course Hours", hoursController, keyboard: TextInputType.number),
                _dialogTextField("Description", descController, lines: 3),
                _buildDatePickerField("From Date", fromDateController),
                _buildDatePickerField("To Date", toDateController),
                const SizedBox(height: 10),
                if (totalCourseHours < 90)
                  const Text(
                    "** Total training hours must be at least 90 hours",
                    style: TextStyle(color: Colors.red),
                  )
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final hours = int.tryParse(hoursController.text) ?? 0;
              setState(() {
                totalCourseHours += hours;
                courses.add({
                  'name': nameController.text,
                  'desc': descController.text,
                  'hours': hours.toString(),
                  'from': fromDateController.text,
                  'to': toDateController.text,
                  'link': '',
                  'notes': '',
                  'decision': '',
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00a650),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text("Save", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _dialogTextField(String label, TextEditingController controller, {int lines = 1, TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: lines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {String value = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: value),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            controller.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          }
        },
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}