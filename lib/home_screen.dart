import 'package:flutter/material.dart';
import 'package:my_first_project/Chat/ChatScreen.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:my_first_project/MidtermResultsPage.dart';
import 'package:my_first_project/FinalResultsPage.dart';
import 'package:my_first_project/SpecializationsApp.dart';
import 'package:my_first_project/TrainingApprovalForm.dart';
import 'package:my_first_project/Clearance.dart';
import 'package:my_first_project/AskGuide.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> expandedIndices = [0, 0, 0];
  int selectedTabIndex = 0;

  final List<Map<String, String>> registeredCourses = [
    {'Course ID': '1915498', 'Course Name': 'Job Preparation 3 (Skills)', 'Time': '11:30 AM - 3:30 PM', 'Day': 'Sunday, Monday, Tuesday, Wednesday, Thursday', 'Room': 'Accounting'},
    {'Course ID': '1915431', 'Course Name': 'Big Data', 'Time': '10:00 AM - 11:30 AM', 'Day': 'Tuesday, Thursday', 'Room': 'Technology Lab 102'},
    {'Course ID': '1915401', 'Course Name': 'Data Science 101', 'Time': '-', 'Day': '-', 'Room': 'Accounting'},
    {'Course ID': '1915499', 'Course Name': 'AI Fundamentals', 'Time': '-', 'Day': '-', 'Room': 'Accounting'},
  ];

  final List<Map<String, String>> absenceRecords = [
    {'Subject Name': 'Big Data', 'Absence Count': '2'},
    {'Subject Name': 'Job Preparation 3 (Skills)', 'Absence Count': '1'},
    {'Subject Name': 'Job Preparation 2 (Project)', 'Absence Count': '3'},
  ];

  final List<Map<String, String>> closedRequests = [
    {'Date': '2024-12-10', 'Status': 'Approved', 'Course Name': 'Big Data'},
    {'Date': '2025-02-06', 'Status': 'Pending', 'Course Name': 'Data Visualization'},
    {'Date': '2024-12-10', 'Status': 'Pending', 'Course Name': 'Cloud Computing'},
    {'Date': '2024-12-10', 'Status': 'Pending', 'Course Name': 'Deep Learning'},
  ];

  Future<void> _exportRegisteredCoursesToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Header(level: 0, child: pw.Text('Registered Courses')),
          pw.Table.fromTextArray(
            headers: registeredCourses.first.keys.toList(),
            data: registeredCourses.map((course) => course.values.toList()).toList(),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF00a650),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('Half results'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MidtermResultsPage())),
              ),
              ListTile(
                leading: const Icon(Icons.assignment_turned_in),
                title: const Text('Final result'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => FinalResultsPage())),
              ),
              ListTile(
                leading: const Icon(Icons.transfer_within_a_station),
                title: const Text('Fields allow to users to transfer to it'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SpecializationsPage())),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Training place'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TrainingApprovalForm())),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Financial liability'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ClearancePage())),
              ),
              ListTile(
                leading: const Icon(Icons.question_answer),
                title: const Text('Ask question'),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => InquiriesScreen())),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Student Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF00a650),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white), // to color the drawer icon
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TabBar(
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00A650),
                      Color(0xFF004D40),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.7),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                tabs: [
                  Tab(icon: Image.asset('assets/book.jpeg', width: 25, height: 25), text: "Courses"),
                  Tab(icon: Image.asset('assets/absence.jpeg', width: 25, height: 25), text: "Absences"),
                  Tab(icon: Image.asset('assets/request-open-courses.jpeg', width: 25, height: 25), text: "Requests"),
                ],
                onTap: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: TabBarView(
                  children: [
                    _buildExpandableSection(registeredCourses, sectionIndex: 0),
                    _buildExpandableSection(absenceRecords, sectionIndex: 1),
                    _buildExpandableSection(closedRequests, sectionIndex: 2, isRequestSection: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedTabIndex == 0)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: _exportRegisteredCoursesToPDF,
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                  label: const Text("Export to PDF"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            const SizedBox(height: 40),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
          },
          backgroundColor: const Color(0xFF00a650),
          child: const Icon(Icons.chat, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(List<Map<String, String>> data, {required int sectionIndex, bool isRequestSection = false}) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _AnimatedExpansionTile(
          item: data[index],
          isExpanded: index == expandedIndices[sectionIndex],
          onTap: () {
            setState(() {
              expandedIndices[sectionIndex] = (expandedIndices[sectionIndex] == index) ? -1 : index;
            });
          },
          isRequestSection: isRequestSection,
        );
      },
      separatorBuilder: (context, index) => const Divider(color: Colors.grey, thickness: 0.8),
    );
  }
}

class _AnimatedExpansionTile extends StatefulWidget {
  final Map<String, String> item;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool isRequestSection;

  const _AnimatedExpansionTile({
    required this.item,
    required this.isExpanded,
    required this.onTap,
    this.isRequestSection = false,
  });

  @override
  State<_AnimatedExpansionTile> createState() => _AnimatedExpansionTileState();
}

class _AnimatedExpansionTileState extends State<_AnimatedExpansionTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    if (widget.isExpanded) _controller.value = 1;
  }

  @override
  void didUpdateWidget(covariant _AnimatedExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      widget.isExpanded ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getStatusColor(String status) {
    return status == 'Approved' ? Colors.green[400]! : Colors.yellow[700]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.item['Course Name'] ?? widget.item['Subject Name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Image.asset(
            widget.isExpanded ? 'assets/collapse.jpeg' : 'assets/expand.jpeg',
            width: 15,
            height: 15,
          ),
          onTap: widget.onTap,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: widget.isExpanded
              ? Column(
            children: [
              if (widget.isRequestSection && (widget.item.containsKey('Date') || widget.item.containsKey('Status')))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      if (widget.item.containsKey('Date')) Text("Date: ${widget.item['Date']}"),
                      const SizedBox(width: 10),
                      if (widget.item.containsKey('Status'))
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: getStatusColor(widget.item['Status']!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Status: ${widget.item['Status']}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ...widget.item.entries
                  .where((entry) =>
              entry.key != 'Course Name' &&
                  entry.key != 'Subject Name' &&
                  entry.key != 'Date' &&
                  entry.key != 'Status')
                  .map((entry) => ListTile(title: Text("${entry.key}: ${entry.value}")))
                  .toList(),
            ],
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
