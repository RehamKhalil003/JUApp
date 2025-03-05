import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});

  // Factory method to create an FAQ from JSON
  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      question: json['question'],
      answer: json['answer'],
    );
  }
}

Future<List<FAQ>> loadFAQData() async {
  // Load the JSON file
  final String jsonString = await rootBundle.loadString('assets/faq_data.json');
  final Map<String, dynamic> jsonResponse = json.decode(jsonString);

  // Parse FAQ data
  List<FAQ> faqList = (jsonResponse['faqs'] as List)
      .map((faqJson) => FAQ.fromJson(faqJson))
      .toList();

  return faqList;
}




List<String> courseRelatedWords = [
  "How do I",
  "Where can I",
  "When is the deadline for",
  "How can I check",
  "What are the requirements for",
  "How do I apply for"
];

List<String> courseTopics = [
  "registration",
  "course materials",
  "grades",
  "admissions",
  "graduation",
  "scholarships",
  "financial aid",
];

String generateRandomQuestion() {
  Random rand = Random();
  String question = courseRelatedWords[rand.nextInt(courseRelatedWords.length)] +
      " " +
      courseTopics[rand.nextInt(courseTopics.length)] +
      "?";
  return question;
}

void main() {
  // Generate 10,000 questions
  for (int i = 0; i < 10000; i++) {
    print(generateRandomQuestion());
  }
}
