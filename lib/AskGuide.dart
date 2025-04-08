import 'package:flutter/material.dart';

class Question {
  final int id;
  final String question;
  final String date;
  Question(this.id, this.question, this.date);
}

class InquiriesScreen extends StatefulWidget {
  const InquiriesScreen({super.key});

  @override
  State<InquiriesScreen> createState() => _InquiriesScreenState();
}

class _InquiriesScreenState extends State<InquiriesScreen> {
  final List<Question> questions = [];
  final TextEditingController questionController = TextEditingController();

  void _addQuestion(String questionText) {
    setState(() {
      questions.add(Question(
        questions.length + 1,
        questionText,
        DateTime.now().toString().split(' ')[0],
      ));
    });
  }

  void _showAddQuestionDialog() {
    questionController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Question", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: questionController,
                maxLines: 4,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGradientButton(
                    "Back",
                    Icons.arrow_back,
                        () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  _buildGradientButton("Save", Icons.save, () {
                    if (questionController.text.isNotEmpty) {
                      _addQuestion(questionController.text);
                      Navigator.pop(context);
                    }
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteQuestion(int id) {
    setState(() {
      questions.removeWhere((q) => q.id == id);
    });
  }

  Widget _buildGradientButton(String text, IconData icon, VoidCallback onPressed,
      {Color? backgroundColor}) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor == null
            ? const LinearGradient(
          colors: [Color(0xFF00a650), Color(0xFF00a650)],
        )
            : null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ask a guide",
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
          Container(
            margin: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: _buildGradientButton("Add Question", Icons.add, _showAddQuestionDialog),
          ),
          const Divider(),
          Expanded(
            child: questions.isEmpty
                ? const Center(child: Text("No questions yet."))
                : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final q = questions[index];
                return ListTile(
                  leading: Text("${q.id}"),
                  title: Text(q.question),
                  subtitle: Text("Asked on: ${q.date}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.orange),
                    onPressed: () => _deleteQuestion(q.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
