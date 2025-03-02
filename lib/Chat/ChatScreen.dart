// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChatScreen(),
//     );
//   }
// }
//
// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Map<String, String>> _messages = []; // List to hold the chat messages
//
//   // Function to send a message
//   void _sendMessage(String message) {
//     if (message.isEmpty) return;
//
//     setState(() {
//       _messages.add({'sender': 'user', 'message': message});
//       _messages.add({'sender': 'bot', 'message': 'Fetching your data...'}); // Placeholder for bot's response
//     });
//
//     // Here you can add logic to handle the student's number and show results
//     // For now, you can just replace it with a response after some time
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         _messages.removeAt(_messages.length - 1); // Remove the placeholder message
//         _messages.add({'sender': 'bot', 'message': 'Student data: Course 1, Course 2'}); // Example response
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Student Chatbot')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               reverse: true, // To show the latest message at the bottom
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 final isUserMessage = message['sender'] == 'user';
//
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Align(
//                     alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                       decoration: BoxDecoration(
//                         color: isUserMessage ? Colors.blue : Colors.grey.shade300,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Text(
//                         message['message']!,
//                         style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Enter student number...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage(_controller.text);
//                     _controller.clear(); // Clear the text field
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
