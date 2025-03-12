import 'package:flutter/material.dart';
import 'package:second_app/StartScene.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple], //

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: const StartScene(), //
        ),
      ),
    ),
  );
}
