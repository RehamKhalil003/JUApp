import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:string_similarity/string_similarity.dart';
import 'package:csv/csv.dart';
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    _loadCSV();
    loadFaqData();
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



  Map<String, String> faqData = {};

  Future<void> loadFaqData() async {
    final String csvData = await rootBundle.loadString('assets/faq.csv');
    List<List<dynamic>> csvList = CsvToListConverter(
      eol: "\n",
      fieldDelimiter: ",",
      textDelimiter: '"',
    ).convert(csvData);

    if (csvList.isNotEmpty) {
      csvList.removeAt(0); // Remove the header row
    }

    final Map<String, String> loadedFaqData = {};

    for (var row in csvList) {
      if (row.length >= 2) {
        loadedFaqData[row[0].toString().trim()] = row[1].toString().trim();
      }
    }

    setState(() {
      faqData = loadedFaqData;
    });

    print("Loaded FAQ Data: $faqData"); // Debugging output
  }



  void _handleFaq(String userQuestion) {
    print("User question: $userQuestion");
    print("FAQ data: $faqData");

    if (faqData.isEmpty) {
      _sendMessage("FAQ data is not loaded yet. Please try again later.", sender: 'bot');
      return;
    }

    // Normalize user question to lowercase
    userQuestion = userQuestion.toLowerCase();

    var bestMatch = faqData.entries
        .map((entry) => {
      'question': entry.key.toLowerCase(),
      'similarity': userQuestion.similarityTo(entry.key.toLowerCase()),
      'answer': entry.value
    })
        .reduce((current, next) =>
    (current['similarity'] as double) > (next['similarity'] as double) ? current : next);

    print("Best match: ${bestMatch['question']} with similarity: ${bestMatch['similarity']}");

    // If similarity is greater than 0.5, return the best match
    if ((bestMatch['similarity'] as double) > 0.5) {
      _sendMessage(bestMatch['answer'] as String, sender: 'bot');
    } else {
      // Check if the user question is a partial match for any key
      var partialMatch = faqData.entries.firstWhere(
            (entry) => entry.key.toLowerCase().contains(userQuestion), // FIXED: Checking if the key contains the user input
        orElse: () => MapEntry("", ""),
      );

      if (partialMatch.key.isNotEmpty) { // Ensure we found a match
        _sendMessage(partialMatch.value, sender: 'bot');
      } else {
        _sendMessage("❌ Sorry, I didn't understand. Please enter a valid Student ID or ask a relevant question.", sender: 'bot');
      }
    }
  }
  //00a650
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/Logo.jpeg', height: 40),
            SizedBox(width: 10),
            Text(
              'Student Chatbot',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Center the background image with opacity and padding from left and right
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Opacity(
                opacity: 0.04, // Adjust the opacity here (0.0 is fully transparent, 1.0 is fully opaque)
                child: Container(
                  height: 400, // Height set to 400
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Logo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Content on top of background
          Column(
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
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                        decoration: BoxDecoration(
                          color: isUserMessage ? Colors.green[400] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Text(
                          message['message']!,
                          style: TextStyle(
                            color: isUserMessage ? Colors.white : Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Enter your ID or ask a question.',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          String userInput = _controller.text.trim();
                          if (userInput.isNotEmpty) {
                            _sendMessage(userInput, sender: 'user');
                            _handleUserInput(userInput);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}