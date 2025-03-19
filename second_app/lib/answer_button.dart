import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.clickHandle,
    required this.buttonText,
  });

  final void Function() clickHandle;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: clickHandle,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 81, 0, 173),
        foregroundColor: Colors.white,

        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40), //
        ),
      ),

      child: Text(
        buttonText, //
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
