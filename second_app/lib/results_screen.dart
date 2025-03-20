import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.reStartQuizHandle,
  });

  final List<String> chosenAnswers;
  final void Function() reStartQuizHandle;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        //
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final int numCorrectQuestions =
        summaryData
            .where((data) => data['correct_answer'] == data['user_answer'])
            .length;

    return SizedBox(
      width: double.infinity,

      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!!',

                textAlign: TextAlign.center,

                style: GoogleFonts.lato(
                  //
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ), //
              const SizedBox(height: 60),

              Text(
                'List of answers and questions',

                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ), //
              const SizedBox(height: 20),

              QuestionsSummary(summaryData),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: reStartQuizHandle,
                child: Text(
                  'Restart Quiz!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, //
                  ),
                ),
              ),

              SizedBox(height: 30),
            ], //
          ),
        ),
      ),
    );
  }
}
