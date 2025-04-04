import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...summaryData.map((data) {
          bool correct = data['user_answer'] == data['correct_answer'];

          return Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            margin: EdgeInsets.only(top: 40),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CircleAvatar(
                  radius: 20, //
                  backgroundColor: correct ? Colors.green : Colors.red[600],
                  child: Text(
                    (data['question_index'] as int).toString(),

                    style: GoogleFonts.lato(
                      color: Colors.white, //
                      fontSize: 15,
                    ),
                  ),
                ), //

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Text(
                          data['question'] as String,

                          textAlign: TextAlign.left,

                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 155, 155, 155),
                            fontSize: 15,
                          ),
                        ),

                        Text(
                          data['user_answer'] as String,

                          textAlign: TextAlign.left,

                          style: GoogleFonts.lato(
                            color: correct ? Colors.blue[300] : Colors.red[400],
                            fontSize: 15,

                            decoration:
                                correct ? null : TextDecoration.lineThrough,

                            decorationThickness: 3.0,
                            decorationColor: const Color.fromARGB(
                              146,
                              60,
                              60,
                              60,
                            ),
                          ),
                        ),

                        Text(
                          data['correct_answer'] as String,

                          textAlign: TextAlign.left,

                          style: GoogleFonts.lato(
                            color: Colors.green,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
