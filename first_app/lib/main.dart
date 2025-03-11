import 'package:flutter/material.dart';
import 'package:first_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: GradientContainer(
          Color.fromARGB(233, 102, 0, 255),
          Color.fromARGB(240, 255, 46, 217),
        ),
      ),
    ),
  );
}
