import 'package:flutter/material.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/results_screen.dart';
import 'package:second_app/start_screen.dart';
import 'package:second_app/question_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  final List<String> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    activeScreen = StartScene(switchScreen);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(chooseAnswer: chooseAnswer);
    });
  }

  void reStartQuiz() {
    selectedAnswers.clear();

    setState(() {
      activeScreen = QuestionsScreen(chooseAnswer: chooseAnswer);
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswers: selectedAnswers,
          reStartQuizHandle: reStartQuiz,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple], //

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: activeScreen,
        ),
      ),
    );
  }
}
