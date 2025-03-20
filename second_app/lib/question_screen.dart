import 'package:flutter/material.dart';
import 'package:second_app/answer_button.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/models/quiz_question.dart';

import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.chooseAnswer});

  final void Function(String answer) chooseAnswer;

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  void clickedAnswer(String answer) {
    widget.chooseAnswer(answer);

    setState(() {
      currentQuestionIndex++;
    });
  }

  List<Widget> getButtonWidgets({required int quizNumber}) {
    final QuizQuestion currentQuestion = questions[quizNumber];
    List<AnswerButton> buttons = [];

    buttons.add(
      AnswerButton(
        clickHandle: () {
          clickedAnswer(currentQuestion.answers[0]);
        },
        buttonText: currentQuestion.answers[0],
      ),
    );

    for (int i = 1; i < currentQuestion.answers.length; i++) {
      buttons.add(
        AnswerButton(
          clickHandle: () {},
          buttonText: currentQuestion.answers[i],
        ),
      );
    }

    buttons.shuffle();

    List<Widget> widgetList = [];
    widgetList.add(buttons[0]);

    for (int i = 1; i < currentQuestion.answers.length; i++) {
      widgetList.add(SizedBox(height: 10));
      widgetList.add(buttons[i]);
    }

    return widgetList;
  }

  var currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final QuizQuestion currentQuestion = questions[currentQuestionIndex];

    // List<Widget> widgetList = getButtonWidgets(quizNumber: 0);

    return SizedBox(
      width: double.infinity,

      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,

              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),

              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // 내가 사용한 방법, widget list를 만들어서, 미리 버튼 위젯에 값들을 할당한 뒤,
            // 후에 재배치
            // ...widgetList,
            ...currentQuestion.getShuffledAnswers().map((String answer) {
              return AnswerButton(
                clickHandle: () {
                  clickedAnswer(answer);
                },

                buttonText: answer,
              );
            }),
          ],
        ),
      ),
    );
  }
}
