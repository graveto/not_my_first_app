import 'package:flutter/material.dart';

import 'package:not_my_first_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:not_my_first_app/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    final ratio = (numCorrectQuestions / numTotalQuestions) * 100;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You hacked $numCorrectQuestions out of $numTotalQuestions firewalls!',
              style: GoogleFonts.audiowide(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              ratio > 75 ? 'You are ready!' : 'You will die instantly!',
              style: GoogleFonts.audiowide(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: Text(
                'Get Back to Training!',
                style: GoogleFonts.audiowide(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
