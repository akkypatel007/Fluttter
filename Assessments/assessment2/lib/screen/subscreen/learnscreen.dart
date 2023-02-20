import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rto_app/api_services.dart';
import 'package:rto_app/const/text_style.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  late Future quiz;
  var currentQuestionIndex = 0;
  var optionsList = [];
  var isLoaded = false;

  List<String> stateList = [
    'All',
    'Mandatory',
    'Direction Control',
    'Cautionary',
    'General information',
    'Traffic'
  ];
  var selectedvalue = "";

  @override
  void initState() {
    selectedvalue = stateList.first;
    super.initState();
    quiz = getQuiz();
    print("------------------$quiz");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Learn"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 250,
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.zero)),
                          value: selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              selectedvalue = value.toString();
                            });
                          },
                          items: stateList.map((item) {
                            return DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ));
                          }).toList()),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_left_rounded)),
                    Center(child: headingText(text: "1/123", size: 20)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_right_rounded)),
                  ],
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: quiz,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data["rsults"];
                    print("------------------$data");
                    if (isLoaded == false) {
                      optionsList = data[currentQuestionIndex]["question"];
                      optionsList.shuffle();
                      isLoaded = true;
                      print("---------------------------$optionsList");
                    }

                    return Container(
                      child: Expanded(
                          child: Text(data[currentQuestionIndex]["question"])),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final int id;
  final String text;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String imageUrl;

  Question({
    required this.id,
    required this.text,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.imageUrl,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['Q_NUMBER'] ?? -1,
      text: json['question'] ?? '',
      correctAnswer: json['correct_answer'] ?? '',
      incorrectAnswers: List<String>.from(json['incorrect_answers'] ?? []),
      imageUrl: json['IMAGE'] ?? '',
    );
  }
}

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(
        Uri.parse('https://akkypatel007.000webhostapp.com/rto/question.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['rsults'];
      setState(() {
        questions = data.map((json) => Question.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question List')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];

          return ListTile(
            title: Text('${question.id}. ${question.text}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('A) ${question.correctAnswer}'),
                // Text('B) ${question.incorrectAnswers[0]}'),
                // Text('C) ${question.incorrectAnswers[1]}'),
              ],
            ),
            trailing: question.imageUrl.isNotEmpty
                ? Image.asset(question.imageUrl)
                : null,
          );
        },
      ),
    );
  }
}
