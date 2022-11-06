import 'package:flutter/material.dart';

import '../models/quiz.dart';

class QuizScreen extends StatelessWidget {
  Quiz quiz;

  QuizScreen({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i < quiz.questions!.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(quiz.questions![i].questionText!),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var x = 0;
                            x < quiz.questions![i].answers!.length;
                            x++)
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(quiz.questions![i].answers![x].answer!),
                          ),
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
