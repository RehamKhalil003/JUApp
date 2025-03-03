// import 'package:flutter/material.dart';
// import 'package:my_first_project/sign_in.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignInPage(), // Run directly on SignInPage
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // Chat messages list
  List<List<dynamic>> _csvData = []; // Store parsed CSV data
  String? _studentId; // Store the current student ID selected by the user
  List<dynamic> _studentData = []; // Store data of the selected student

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  // Load CSV file from assets
  Future<void> _loadCSV() async {
    final String csvString = await rootBundle.loadString('assets/students.csv');
    List<List<dynamic>> csvList = CsvToListConverter(
      eol: "\n",
      fieldDelimiter: ",",
      textDelimiter: '"',
    ).convert(csvString);

    // Remove header row
    if (csvList.isNotEmpty) {
      csvList.removeAt(0);
    }

    setState(() {
      _csvData = csvList;
    });
  }

  // Fetch student data and suggest courses
  // Fetch student data and suggest courses
  void _fetchStudentData(String studentId) {
    if (_csvData.isEmpty) {
      _sendMessage('Error: Data not loaded yet!', sender: 'bot');
      return;
    }

    var studentData = _csvData.firstWhere(
          (row) => row[1].toString().trim() == studentId.trim(),
      orElse: () => [],
    );

    if (studentData.isEmpty) {
      _sendMessage('Student ID not found!', sender: 'bot');
      return;
    }

    // Store the student data and ID
    setState(() {
      _studentId = studentId;
      _studentData = studentData;
    });

    // Send a message to choose an option with instructions
    _sendMessage('Please choose an option to see: Type 1 for Completed Courses or 2 for Not Completed Courses', sender: 'bot');
  }


  // Send message function
  void _sendMessage(String message, {String sender = 'user'}) {
    setState(() {
      _messages.insert(0, {'sender': sender, 'message': message});
    });
  }

  // Handle the user input and display corresponding courses
  void _handleUserChoice(String userChoice) {
    if (_studentId == null || _studentData.isEmpty) {
      _sendMessage('Please enter a valid student ID first!', sender: 'bot');
      return;
    }

    if (userChoice == '1' || userChoice.toLowerCase() == 'completed courses') {
      String completedRaw = _studentData[2].toString();
      List<String> completedCourses = completedRaw.split(',').map((e) => e.trim()).toList();
      _sendMessage('Completed courses: ${completedCourses.join(', ')}', sender: 'bot');
    } else if (userChoice == '2' || userChoice.toLowerCase() == 'not completed courses') {
      String notCompletedRaw = _studentData[3].toString();
      List<String> notCompletedCourses = notCompletedRaw.split(',').map((e) => e.trim()).toList();
      _sendMessage('Not completed courses: ${notCompletedCourses.join(', ')}', sender: 'bot');
    } else {
      _sendMessage('Invalid choice, please type 1 for Completed Courses or 2 for Not Completed Courses.', sender: 'bot');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Chatbot'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Show latest messages at the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['sender'] == 'user';

                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.green[300] : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: isUserMessage ? Radius.circular(15) : Radius.zero,
                        bottomRight: isUserMessage ? Radius.zero : Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      message['message']!,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter student number...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    String userInput = _controller.text.trim();
                    if (userInput.isNotEmpty) {
                      _sendMessage(userInput, sender: 'user');
                      if (_studentId == null) {
                        _fetchStudentData(userInput);
                      } else {
                        _handleUserChoice(userInput);
                      }
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
