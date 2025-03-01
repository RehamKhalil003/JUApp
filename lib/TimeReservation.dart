import 'package:flutter/material.dart';

class Timereservation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Time Reservation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Registration Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Container(
              width: double.infinity, // Fill screen width
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4, // More shadow for raised effect
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDataRow("Registration Date", "2025/02/18", Icons.calendar_today),
                      _buildDataRow("Registration Time", "09:45 - 10:00", Icons.access_time),
                      _buildDataRow("Free Time Date", "-", Icons.date_range),
                      _buildDataRow("Free Time Slot", "-", Icons.schedule),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32), // Add space between sections
            Text('New Reservation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Free Time Date'),
                      items: ['2025/02/18', '2025/02/19']
                          .map((date) => DropdownMenuItem<String>(
                        value: date,
                        child: Text(date),
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Free Time Slot'),
                      items: ['09:45 - 10:00', '10:00 - 10:15']
                          .map((time) => DropdownMenuItem<String>(
                        value: time,
                        child: Text(time),
                      ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a row with an icon and text
  Widget _buildDataRow(String label, String data, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: $data",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}