import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SpecializationsPage extends StatelessWidget {
  const SpecializationsPage({super.key});

  final List<Map<String, String>> data = const [
    {'college': 'Science', 'major': 'Mathematics'},
    {'college': 'Science', 'major': 'Physics'},
    {'college': 'Science', 'major': 'Industrial Chemistry'},
    {'college': 'Science', 'major': 'Life Sciences'},
    {'college': 'Science', 'major': 'Environmental & Applied Geology'},
    {'college': 'Sharia', 'major': 'Foundations of Religion'},
    {'college': 'Agriculture', 'major': 'Animal Production'},
    {'college': 'Agriculture', 'major': 'Agricultural Economics & Business Management'},
    {'college': 'Agriculture', 'major': 'Plant Protection'},
    {'college': 'Agriculture', 'major': 'Horticulture & Crops'},
    {'college': 'Agriculture', 'major': 'Landscape & Flower Production'},
    {'college': 'Agriculture', 'major': 'Soil, Water & Environment'},
  ];

  Future<void> _exportToPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Specializations allowed to transfer to',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['College', 'Major'],
                data: data.map((item) => [item['college'], item['major']]).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  Future<void> _exportToExcel(BuildContext context) async {
    final excel = Excel.createExcel();
    final sheet = excel['Specializations'];

    sheet.appendRow(['College', 'Major']);
    for (var row in data) {
      sheet.appendRow([row['college'], row['major']]);
    }

    if (await Permission.storage.request().isGranted) {
      try {
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final path = '${directory.path}/specializations.xlsx';
          final file = File(path);
          await file.writeAsBytes(excel.encode()!);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Excel file saved at:\n$path')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving the Excel file')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Specializations allowed to transfer to",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color(0xFF00a650),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _exportToPdf,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text('Export PDF', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "College",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Major",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            Expanded(
              child: ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) => const Divider(height: 0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(data[index]['college']!),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(data[index]['major']!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
