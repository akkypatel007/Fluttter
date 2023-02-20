import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rto_app/api_services.dart';
import 'package:rto_app/const/colors.dart';
import 'package:rto_app/const/text_style.dart';
import 'package:rto_app/screen/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // ValueNotifier<int> _seconds = ValueNotifier<int>(60);
  var currentQuestionIndex = 0;
  int seconds = 60;
  Timer? timer;
  late Future quiz;

  int points = 0;
  int selectedOptionIndex = -1;

  var isLoaded = false;
  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoaded = false;
    selectedOptionIndex = -1;
    if (currentQuestionIndex == 14) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(),
          ));
    } else {
      currentQuestionIndex++;
    }
    // optionsColor = List<Color>.filled(optionsList.length, Colors.white);

    resetColors();
/*
    optionsColor.fillRange(0, optionsColor.length, Colors.white);
*/
    timer!.cancel();
    seconds = 60;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // final timerProvider = Provider.of<CountDown>(context, listen: false);
    print('build');
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [blue, darkBlue],
        )),
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // var data = snapshot.data["results"];
              var data = snapshot.data["rsults"];

              if (isLoaded == false) {
                optionsList = data[currentQuestionIndex]["incorrect_answers"];
                optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                optionsList.shuffle();
                print("=-==-=-=-=-=->${data.length}");
                if (data.length == 20) {
                  data.length++;
                } else {
                  print("++++++++++${data.length}");
                }
                isLoaded = true;
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: lightgrey, width: 2),
                          ),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: Colors.white,
                                size: 25,
                              )),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            normalText(
                                color: Colors.white,
                                size: 20,
                                text: "$seconds"),
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                value: seconds / 60,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: lightgrey, width: 2),
                          ),
                          child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(CupertinoIcons.heart_fill,
                                  color: Colors.white, size: 18),
                              label: normalText(
                                  color: Colors.white, size: 14, text: "Like")),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Image.asset(ideas, width: 100),
                    // const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            ),
                            label: normalText(
                                color: Colors.white, text: "preview")),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: normalText(
                                color: lightgrey,
                                size: 14,
                                text:
                                    "Question ${currentQuestionIndex + 1} of ${15 /*data.length*/}")),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              normalText(
                                color: Colors.white,
                                text: "Next",
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    normalText(
                        color: Colors.white,
                        size: 18,
                        text: data[currentQuestionIndex]["question"]),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: data[currentQuestionIndex]["IMAGE"].isNotEmpty
                            ? Image.asset(
                                // "assets/rtologos/2.jpg",
                                data[currentQuestionIndex]["IMAGE"],
                                fit: BoxFit.cover,
                              )
                            : null),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: optionsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var answer =
                            data[currentQuestionIndex]["correct_answer"];

                        return RadioListTile(
                          title: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            width: size.width - 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: selectedOptionIndex == index
                                  ? Colors.blue // selected option color
                                  : Colors.white, // unselected option color
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: headingText(
                              color: blue,
                              size: 16,
                              text: optionsList[index].toString(),
                            ),
                          ),
                          value: index,
                          groupValue: selectedOptionIndex,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOptionIndex = value!;
                              if (answer.toString() ==
                                  optionsList[index].toString()) {
                                optionsColor[index] = Colors.blue;
                                points = points + 10;
                              } else {
                                optionsColor[index] = Colors.blue;
                              }

                              if (currentQuestionIndex < data.length - 1) {
                                // gotoNextQuestion();
                                // Future.delayed(
                                //     const Duration(milliseconds: 500), () {
                                //   gotoNextQuestion();
                                // });
                              } else {
                                timer!.cancel();

                                //here you can do whatever you want with the results
                              }
                            });
                          },
                        );

                        /*GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedOptionIndex == index) {
                                // if the same option is tapped again, deselect it
                                selectedOptionIndex = -1;
                              } else {
                                selectedOptionIndex = index;
                                if (answer.toString() ==
                                    optionsList[index].toString()) {
                                  optionsColor[index] = Colors.blue;
                                  points = points + 10;
                                } else {
                                  optionsColor[index] = Colors.blue;
                                }
                              }

                              if (currentQuestionIndex < data.length - 1) {
                                // gotoNextQuestion();
                                // Future.delayed(
                                //     const Duration(milliseconds: 500), () {
                                //   gotoNextQuestion();
                                // });
                              } else {
                                timer!.cancel();

                                //here you can do whatever you want with the results
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                width: size.width - 60,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: selectedOptionIndex == index
                                      ? Colors.blue // selected option color
                                      : Colors.white, // unselected option color
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: headingText(
                                  color: blue,
                                  size: 16,
                                  text: optionsList[index].toString(),
                                ),
                              ),
                            ],
                          ),
                        );*/
/*
                            GestureDetector(
                          onTap: () {
                            setState(() {
                              if (answer.toString() ==
                                  optionsList[index].toString()) {
                                optionsColor[index] = Colors.blue;
                                points = points + 10;
                              } else {
                                optionsColor[index] = Colors.blue;
                              }

                              if (currentQuestionIndex < data.length - 1) {
                                // gotoNextQuestion();
                                // Future.delayed(
                                //     const Duration(milliseconds: 500), () {
                                //   gotoNextQuestion();
                                // });
                              } else {
                                timer!.cancel();

                                //here you can do whatever you want with the results
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                width: size.width - 60,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: optionsColor[index],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: headingText(
                                  color: blue,
                                  size: 16,
                                  text: optionsList[index].toString(),
                                ),
                              ),
                            ],
                          ),
                        );
*/
                      },
                    ),
                    ElevatedButton(
                        onPressed: () => _save(), child: const Text("Submit"))
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      )),
    );
  }

  _save() {
    gotoNextQuestion();
  }
}
