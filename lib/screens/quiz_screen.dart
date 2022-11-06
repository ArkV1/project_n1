import 'package:flutter/material.dart';

import '../models/quiz.dart';

class QuizScreen extends StatefulWidget {
  Quiz quiz;

  QuizScreen({required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var score = 0;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i < widget.quiz.questions!.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.quiz.questions![i].questionText!),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var x = 0;
                            x < widget.quiz.questions![i].answers!.length;
                            x++)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                score += widget
                                    .quiz.questions![i].answers![x].score!;
                              });
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            },
                            child: Text(
                                widget.quiz.questions![i].answers![x].answer!),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Congratz!'),
                Text('Your result is...'),
                (() {
                  for (var i = 0; i < widget.quiz.results!.length; i++) {
                    if (widget.quiz.results![i].score! > score) {
                      return Text(widget.quiz.results![i].result.toString());
                    }
                  }
                  return Text('idk bruh');
                }())
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          print('Gucci');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
        },
      ),
    );
  }
}
