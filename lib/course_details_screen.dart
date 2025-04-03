import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {
      'name': 'Algorithms',
      'status': 'Open',
      'teacher': 'Azzam Salbat',
      'time1': '16:00',
      'time2': '19:00',
      'day': 'Sun, Mon, Tue, Wed, Thu',
      'condition': 'Arranged with the teacher',
      'students': '4',
    },
    {
      'name': 'Data Structures',
      'status': 'Closed',
      'teacher': 'Mohammad Ahmed',
      'time1': '14:00',
      'time2': '17:00',
      'day': 'Sun, Mon, Tue, Wed, Thu',
      'condition': 'Available to all',
      'students': '3',
    },
  ];

  CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00a650), // Green header
        title: const Text(
          'Course Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: courses.map((course) {
            return Card(
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course: ${course['name'] ?? 'Unknown'}', // Handling null value safely
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabelValue('Course Status', ''),
                        _buildStatusBadge(course['status'] ?? 'Closed'), // Handling null value safely
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildLabelValue('Teacher', course['teacher'] ?? 'Unknown'), // Handling null value safely
                    const SizedBox(height: 8),
                    _buildLabelValue('Time', '${course['time1'] ?? 'N/A'} - ${course['time2'] ?? 'N/A'}'), // Handling null value safely
                    const SizedBox(height: 8),
                    _buildLabelValue('Day', course['day'] ?? 'Unknown'), // Handling null value safely
                    const SizedBox(height: 8),
                    _buildLabelValue('Course Condition', course['condition'] ?? 'N/A'), // Handling null value safely
                    const SizedBox(height: 8),
                    _buildLabelValue('Registered Students', course['students'] ?? '0'), // Handling null value safely
                    const SizedBox(height: 16),
                    if (course['status'] == 'Open')
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your registration logic here
                            _showDialog(context, course['name'] ?? 'Unknown');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00a650), // Green color
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: status == 'Open' ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showDialog(BuildContext context, String courseName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Course Registration'),
          content: Text('You have successfully registered for the $courseName course!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
