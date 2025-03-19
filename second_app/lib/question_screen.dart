import 'package:flutter/material.dart';
import 'package:second_app/answer_button.dart';
import 'package:second_app/data/questions.dart';
import 'package:second_app/models/quiz_question.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  void clickedAnswer() {}

  @override
  Widget build(BuildContext context) {
    final QuizQuestion currentQuestion = questions[0];
    List<AnswerButton> buttons = [];

    buttons.add(
      AnswerButton(
        clickHandle: clickedAnswer,
        buttonText: currentQuestion.text,
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

              style: const TextStyle(
                color: Colors.white, //
                fontSize: 30,
              ),

              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            ...widgetList,
          ],
        ),
      ),
    );
  }
}
