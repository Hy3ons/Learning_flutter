import 'package:flutter/material.dart';

class StartScene extends StatelessWidget {
  const StartScene(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/quiz_logo.png', width: 300),

          const SizedBox(height: 60),

          Text(
            'Learn Flutter the fun way!',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),

          const SizedBox(height: 50),

          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Color.fromARGB(253, 134, 0, 161),
            ),

            icon: const Icon(Icons.arrow_right_alt),

            label: Text('Start Quiz', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
