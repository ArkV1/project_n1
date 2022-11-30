// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_n1/screens/quiz_screen.dart';

import '../models/quiz.dart';

class QuizWidget extends StatelessWidget {
  Quiz quiz;

  QuizWidget({required this.quiz});

  void pageNavigation(BuildContext ctx, screen) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String typeQuizString;
    if (quiz.typeQuiz!) {
      typeQuizString = 'quiz';
    } else {
      typeQuizString = 'test';
    }
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Builder(
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Center(
                      child: Text('${quiz.description} $typeQuizString'),
                    ),
                    content: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: Center(
                            child: Text('Image Placeholder'),
                          ),
                        ),
                        Text('Creator: ${quiz.creator!}'),
                        Text('Date: ${DateFormat.yMMMd().format(quiz.date!)}'),
                        Text('${DateFormat.jm().format(quiz.date!)}'),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              pageNavigation(context, QuizScreen(quiz: quiz));
                            },
                            child: Text('Start $typeQuizString'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(quiz.description!),
              SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Text('Image Placeholder'),
                ),
              ),
              Text(
                (quiz.creator!),
              ),
              Text(
                (DateFormat.yMMMd().format(quiz.date!)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
