import 'package:flutter/material.dart';

class StudentInfoForm extends StatelessWidget {
  const StudentInfoForm({super.key});

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
              children: const [
                Icon(Icons.person),
                SizedBox(width: 8),
                Text(
                  'Student Personal Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            buildTextField(label: 'Reference 1 *', value: 'Reham Khaleel Saleh Abu Hdeh'),
            buildTextField(label: 'Reference 1 Phone *', value: '0799709164'),
            buildTextField(label: 'Reference 2', value: 'Reham Khaleel Saleh Abu Hdeh'),
            buildTextField(label: 'Reference 2 Phone', value: '0799709164'),
            buildDropdown(
                label: "Father's Education Level *",
                value: 'diploma',
                options: ['less than high school', 'high school', 'diploma', 'bachelor']
            ),
            buildDropdown(
                label: "Mother's Education Level *",
                value: 'high school',
                options: ['less than high school', 'high school', 'diploma', 'bachelor']
            ),
            buildDropdown(
                label: 'Place of Residence *',
                value: 'Amman',
                options: ['Amman', 'Irbid', 'Jerash', 'Madaba']
            ),
            buildDropdown(
                label: 'Do you want to share your address with hiring parties?',
                value: 'Yes',
                options: ['Yes', 'No']
            ),
            buildTextField(label: 'Student Name', value: 'Reham Khaleel Saleh Abu Hdeh'),
            buildTextField(label: 'Place / Year of Birth', value: 'Amman / 2003'),
            buildTextField(label: 'Full Name in English *', value: 'REHAM KHALEEL SALEH ABUHADBAH'),
            buildTextField(label: 'Place of Birth in English *', value: 'Amman'),
            buildTextField(label: 'Permanent Address *', value: 'Tabarbour'),
            buildTextField(label: 'Mobile (Inside Jordan) *', value: '0799709164'),
            buildTextField(label: 'Mobile 2 *', value: '0799709164'),
            buildTextField(label: 'Landline Number'),
            buildTextField(label: 'Email *', value: 'rha0217056@ju.edu.jo'),
            const SizedBox(height: 16),
            const Text(
              'Do you receive full education exemption under the Military Retirement Law? *',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: 'Yes',
              items: ['Yes', 'No']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00a650),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({required String label, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required String value,
    List<String>? options,
  }) {
    final items = options ?? [value, 'Other Option'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (val) {},
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
