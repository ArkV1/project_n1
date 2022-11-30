// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../models/question.dart';
import '../../models/answer.dart';

class AddQuestions extends StatefulWidget {
  List<Question> questions;
  Function(List<Question>) callback;
  AddQuestions(this.questions, this.callback);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  String? validatorIsEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void snackBar(String snackText) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(content: Text(snackText)),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }

  void printQuestions(questions) {
    print('Number of questions: $numberOfQuestions');
    for (var i = 0; i < questions.length; i++) {
      print('Question #${i + 1} is ${questions[i].questionText}');
      for (var x = 0; x < questions[i].answers.length; x++) {
        print('Answer #${x + 1} is ${questions[i].answers[x].answer}');
      }
    }
  }

  final _subFormKey = GlobalKey<FormState>();

  List<Question> questions = [];

  List<TextEditingController> questionsControllerList = [
    TextEditingController(),
  ];
  List<TextEditingController> answersControllerList = [
    TextEditingController(),
  ];
  List<TextEditingController> answersScoreControllerList = [
    TextEditingController(),
  ];

  var numberOfQuestions = 1;
  var numberOfAnswers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Add questions'),
          content: StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Form(
                key: _subFormKey,
                child: Column(
                  children: <Widget>[
                    Text('Question: $numberOfQuestions/8'),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(top: (10.0)),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //                 <--- border radius here
                            ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Question'),
                        controller:
                            questionsControllerList[numberOfQuestions - 1],
                        validator: validatorIsEmpty,
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          child: Text('Add question'),
                          onPressed: () {
                            if (_subFormKey.currentState!.validate()) {
                              List<Answer> answers = [];
                              for (var i = 0; i < numberOfAnswers; i++) {
                                answers.add(Answer(
                                  answer: answersControllerList[i].text,
                                  score: int.parse(
                                      answersScoreControllerList[i].text),
                                ));
                              }
                              if (questions.length - 1 < 8) {
                                setState(() {
                                  questions.add(Question(
                                      questionText: questionsControllerList[
                                              numberOfQuestions - 1]
                                          .text,
                                      answers: answers));
                                  questionsControllerList
                                      .add(TextEditingController());
                                  //
                                  numberOfQuestions++;
                                  //
                                  answersScoreControllerList = [
                                    TextEditingController()
                                  ];
                                  answersControllerList = [
                                    TextEditingController()
                                  ];
                                  //
                                  numberOfAnswers = 1;
                                  //
                                  printQuestions(questions);
                                });
                              } else {
                                snackBar(
                                    'You can\'t have more than 8 question!');
                              }
                            }
                          },
                        ),
                        ElevatedButton(
                          child: Text('Remove question'),
                          onPressed: () {
                            if (numberOfQuestions != 1) {
                              setState(
                                () {
                                  printQuestions(questions);
                                  answersControllerList = [];
                                  answersScoreControllerList = [];
                                  for (var i = 0;
                                      i <
                                          questions[numberOfQuestions - 2]
                                              .answers!
                                              .length;
                                      i++) {
                                    answersControllerList
                                        .add(TextEditingController());
                                    answersScoreControllerList
                                        .add(TextEditingController());
                                    answersControllerList[i].text =
                                        questions[questions.length - 1]
                                            .answers![i]
                                            .answer!;
                                    answersScoreControllerList[i].text =
                                        questions[questions.length - 1]
                                            .answers![i]
                                            .score!
                                            .toString();
                                  }
                                  numberOfAnswers =
                                      questions[numberOfQuestions - 2]
                                          .answers!
                                          .length;
                                  questions.removeLast();
                                  questionsControllerList.removeLast();
                                  numberOfQuestions--;
                                  print('after');
                                  printQuestions(questions);
                                },
                              );
                            } else {
                              snackBar('You can\'t have less than 1 question!');
                            }
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Answers: $numberOfAnswers/8'),
                        for (var i = 0; i < numberOfAnswers; i++)
                          Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.symmetric(vertical: (3.0)),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Answer'),
                                  controller: answersControllerList[i],
                                  validator: validatorIsEmpty,
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Score'),
                                  controller: answersScoreControllerList[i],
                                  validator: validatorIsEmpty,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                            child: Text('Add answer'),
                            onPressed: () {
                              setState(
                                () {
                                  // snackBar('Processing Data');
                                  if (numberOfAnswers != 8) {
                                    //questions[questions.length - 1].answers.add(Answer('answer${questions[questions.length - 1].answers.length}',
                                    //    0));
                                    numberOfAnswers++;
                                    answersControllerList
                                        .add(TextEditingController());
                                    answersScoreControllerList
                                        .add(TextEditingController());
                                  } else {
                                    snackBar(
                                        'You can\'t have more than 8 answers!');
                                  }
                                },
                              );
                            },
                          ),
                          ElevatedButton(
                            child: Text('Remove answer'),
                            onPressed: () {
                              setState(
                                () {
                                  if (numberOfAnswers != 1) {
                                    answersControllerList.removeLast();
                                    answersScoreControllerList.removeLast();
                                    numberOfAnswers--;
                                    // questions[questions.length - 1]
                                    //     .answers
                                    //     .length -= 1;
                                    // answersControllerList.removeLast();
                                  } else {
                                    snackBar(
                                        'You can\'t have less than 1 answer!');
                                  }
                                },
                              );
                            },
                          ),
                          ElevatedButton(
                            child: Text('Submit'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    Theme.of(context).colorScheme.secondary)),
                            onPressed: () {
                              if (_subFormKey.currentState!.validate()) {
                                List<Answer> answers = [];
                                for (var i = 0; i < numberOfAnswers; i++) {
                                  answers.add(Answer(
                                      answer: answersControllerList[i].text,
                                      score: int.parse(
                                          answersScoreControllerList[i].text)));
                                }
                                questions.add(
                                  Question(
                                      questionText: questionsControllerList[
                                              numberOfQuestions - 1]
                                          .text,
                                      answers: answers),
                                );
                                printQuestions(questions);
                                Navigator.pop(context);
                                widget.callback(questions);
                                //
                                //
                                snackBar('Processing Data');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
    ;
  }
}
