import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> expandedIndices = [0, 0, 0]; // Store expanded index for each tab

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Student Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF0088d1), // Main blue color
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0), // Space between title and tabs
              child: TabBar(
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00B8D4), Color(0xFF01579B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.6),
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
                  Tab(
                    icon: Image.asset('assets/book.jpeg', width: 25, height: 25),
                    text: "Courses",
                  ),
                  Tab(
                    icon: Image.asset('assets/absence.jpeg', width: 25, height: 25),
                    text: "Absences",
                  ),
                  Tab(
                    icon: Image.asset('assets/request-open-courses.jpeg', width: 25, height: 25),
                    text: "Requests",
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildExpandableSection(registeredCourses, sectionIndex: 0),
            _buildExpandableSection(absenceRecords, sectionIndex: 1),
            _buildExpandableSection(closedRequests, sectionIndex: 2, isRequestSection: true),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSection(List<Map<String, String>> data, {required int sectionIndex, bool isRequestSection = false}) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: data.length,
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

class _AnimatedExpansionTileState extends State<_AnimatedExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getStatusColor(String status) {
      return status == 'Approved' ? Colors.green[400]! : Colors.yellow[700]!;
    }

    return Column(
      children: [
        ListTile(
          title: Text(
            widget.item['Course Name'] ?? widget.item['Subject Name'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
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
              // Handle Date and Status in a single Row
              if (widget.isRequestSection &&
                  (widget.item.containsKey('Date') ||
                      widget.item.containsKey('Status')))
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      if (widget.item.containsKey('Date'))
                        Text("Date: ${widget.item['Date']}"),
                      const SizedBox(width: 10),
                      if (widget.item.containsKey('Status'))
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: getStatusColor(widget.item['Status']!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Status: ${widget.item['Status']}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              // Handle other details in ListTiles
              ...widget.item.entries
                  .where((entry) =>
              entry.key != 'Course Name' &&
                  entry.key != 'Subject Name' &&
                  entry.key != 'Date' &&
                  entry.key != 'Status')
                  .map((entry) => ListTile(
                title: Text("${entry.key}: ${entry.value}"),
              ))
                  .toList(),
            ],
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}