import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:string_similarity/string_similarity.dart';
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
  final List<Map<String, String>> _messages = [];
  List<List<dynamic>> _csvData = [];
  String? _studentId ;
  List<dynamic> _studentData = [];
  bool _isStudentIdEntered = false;

  final Map<String, String> faqData = {
    "What are completed courses?": "Completed courses are those that the student has successfully finished.",
    "What are not completed courses?": "Not completed courses are the courses that the student has yet to finish.",
    "How do I register for courses?": "You can register for courses through the student portal on the university website.",
    "How do I reset my password?": "You can reset your password via the university portal by clicking 'Forgot Password'.",
    "What is the grading system?": "The grading system follows a scale from A to F. A is excellent, B is good, etc.",
  };

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    final String csvString = await rootBundle.loadString('assets/students.csv');
    List<List<dynamic>> csvList = CsvToListConverter(
      eol: "\n",
      fieldDelimiter: ",",
      textDelimiter: '"',
    ).convert(csvString);

    if (csvList.isNotEmpty) {
      csvList.removeAt(0); // Remove header row
    }

    setState(() {
      _csvData = csvList;
    });
  }

  void _sendMessage(String message, {String sender = 'user'}) {
    setState(() {
      _messages.insert(0, {'sender': sender, 'message': message});
    });
  }

  void _handleUserInput(String userInput) {
    userInput = userInput.trim();

    if (_isValidStudentId(userInput)) {
      _fetchStudentData(userInput);
    } else if (_isStudentIdEntered) {
      // Check if the input is a valid course selection (1 or 2)
      if (userInput == '1') {
        _sendMessage('📚 **Completed Courses:** ${_studentData[2]}', sender: 'bot');
      } else if (userInput == '2') {
        _sendMessage('📌 **Not Completed Courses:** ${_studentData[3]}', sender: 'bot');
      } else {
        // Check if the input matches an FAQ
        _handleFaq(userInput);
      }
    } else {
      // If not a valid Student ID and FAQ, handle as a regular FAQ or invalid
      _handleFaq(userInput);
    }
  }

  bool _isValidStudentId(String studentId) {
    return RegExp(r'^\d+$').hasMatch(studentId) &&
        _csvData.any((row) => row[1].toString().trim() == studentId);
  }

  void _fetchStudentData(String studentId) {
    var studentData = _csvData.firstWhere(
          (row) => row[1].toString().trim() == studentId,
      orElse: () => [],
    );

    if (studentData.isEmpty) {
      _sendMessage('Student ID not found!', sender: 'bot');
      return;
    }

    setState(() {
      _studentId = studentId;
      _studentData = studentData;
      _isStudentIdEntered = true;
    });

    _sendMessage('Student ID confirmed! Choose an option: Type **1** for Completed Courses or **2** for Not Completed Courses.', sender: 'bot');
  }

  void _handleFaq(String userQuestion) {
    final bestMatch = faqData.entries.map((entry) => {
      'question': entry.key,
      'similarity': userQuestion.similarityTo(entry.key),
      'answer': entry.value
    }).reduce((current, next) =>
    (current['similarity'] as double) > (next['similarity'] as double) ? current : next);

    if ((bestMatch['similarity'] as double) > 0.5) {
      _sendMessage(bestMatch['answer'] as String, sender: 'bot');
    } else {
      _sendMessage("❌ Sorry, I didn't understand. Please enter a valid Student ID or ask a relevant question.", sender: 'bot');
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
              reverse: true,
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
                      hintText: 'Enter Student ID or Ask a Question...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    String userInput = _controller.text.trim();
                    if (userInput.isNotEmpty) {
                      _sendMessage(userInput, sender: 'user');
                      _handleUserInput(userInput);
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
