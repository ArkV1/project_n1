// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/answer.dart';
import '../models/question.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  //
  CollectionReference quizzes =
      FirebaseFirestore.instance.collection('quizzes');
  //
  final descriptionController = TextEditingController();
  List<TextEditingController> questionsControllerList = [
    TextEditingController(),
  ];
  List<TextEditingController> answersControllerList = [
    TextEditingController(),
  ];
  //
  var typeQuiz = true;
  //
  List<Question> questions = [];
  //

  // Future<void> addToQuizzes(typeQuiz) {
  //   //
  //   String testQuestion = 'testQuestion';
  //   //
  //   return quizzes.add({
  //     'typeQuiz': typeQuiz,
  //     'questions': 'questions',
  //     'creator': 'Anonymous',
  //     'date': DateTime.now(),
  //   });
  // }

  void snackBar(String snackText) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(content: Text(snackText)),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }

  final _formKey = GlobalKey<FormState>();
  final _subFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Row(
                children: [
                  Spacer(flex: 1),
                  Column(
                    children: [
                      // Spacer(flex: 1),
                      IntrinsicWidth(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (typeQuiz == true) ...[
                                Text('Type: Quiz'),
                              ] else ...[
                                Text('Type: Test'),
                              ],
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          typeQuiz = true;
                                        });
                                      },
                                      child: Text('Quiz'),
                                    ),
                                  ),
                                  //
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          typeQuiz = false;
                                        });
                                      },
                                      child: Text('Test'),
                                    ),
                                  ),
                                  //
                                ],
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Description'),
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Author',
                                  hintText: 'Anonymous - Not logged in',
                                ),
                                enabled: false,
                                controller: null,
                                onSubmitted: null,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Date',
                                  hintText: (DateFormat.yMMMd()
                                      .format(DateTime.now())
                                      .toString()),
                                ),
                                enabled: false,
                                controller: null,
                                onSubmitted: null,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: ElevatedButton(
                                  child: Text('Add questions'),
                                  onPressed: () {
                                    questions = [];
                                    questions.add(Question('dummyQuestion',
                                        [Answer('dummyAnswer', 0)]));
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
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
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Form(
                                                        key: _subFormKey,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                                'Question: ${questions.length}/8'),
                                                            TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          'Question'),
                                                              controller:
                                                                  questionsControllerList[
                                                                      questions
                                                                              .length -
                                                                          1],
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
                                                                  return 'Please enter some text';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            Column(
                                                              children: [
                                                                ElevatedButton(
                                                                  child: Text(
                                                                      'Add question'),
                                                                  onPressed:
                                                                      () {
                                                                    if (_subFormKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      if (questions
                                                                              .length ==
                                                                          1) {
                                                                        List<Answer>
                                                                            answers =
                                                                            [];
                                                                        for (var i =
                                                                                0;
                                                                            i < questions[questions.length - 1].answers.length - 1;
                                                                            i++) {
                                                                          answers.add(Answer(
                                                                              answersControllerList[i].text,
                                                                              0));
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          questions[0] = Question(questionsControllerList[questions.length - 1].text, answers);
                                                                          questionsControllerList
                                                                              .add(TextEditingController());
                                                                          answersControllerList =
                                                                              [
                                                                            TextEditingController(),
                                                                          ];
                                                                        });
                                                                      }
                                                                      
                                                                      if (questions
                                                                              .length !=
                                                                          8) {
                                                                        List<Answer>
                                                                            answers =
                                                                            [];
                                                                        for (var i =
                                                                                0;
                                                                            i < questions[questions.length - 1].answers.length -1;
                                                                            i++) {
                                                                          answers.add(Answer(
                                                                              answersControllerList[i].text,
                                                                              0));
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          questionsControllerList
                                                                              .add(TextEditingController());
                                                                          questions
                                                                              .add(
                                                                            Question(questionsControllerList[questions.length - 1].text,
                                                                                answers),
                                                                          );
                                                                          answersControllerList =
                                                                              [
                                                                            TextEditingController(),
                                                                          ];
                                                                        });
                                                                      } else {
                                                                        snackBar(
                                                                            'You can\'t have more than 8 question!');
                                                                      }
                                                                    }
                                                                  },
                                                                ),
                                                                ElevatedButton(
                                                                  child: Text(
                                                                      'Remove question'),
                                                                  onPressed:
                                                                      () {
                                                                    if (questions
                                                                            .length !=
                                                                        1) {
                                                                      setState(
                                                                          () {
                                                                        questions
                                                                            .removeLast();
                                                                      });
                                                                      answersControllerList =
                                                                          [];
                                                                      for (var i =
                                                                              0;
                                                                          i < questions[questions.length - 1].answers.length;
                                                                          i++) {
                                                                        answersControllerList
                                                                            .add(TextEditingController());
                                                                        answersControllerList[i]
                                                                            .text = questions[questions.length -
                                                                                1]
                                                                            .answers[i]
                                                                            .answer;
                                                                      }
                                                                    } else {
                                                                      snackBar(
                                                                          'You can\'t have less than 1 question!');
                                                                    }
                                                                    // for (var i =
                                                                    //           0;
                                                                    //       i < questions.length;
                                                                    //       i++) {
                                                                    //     print(questions[i]
                                                                    //         .questionText);
                                                                    //     for (var x =
                                                                    //             0;
                                                                    //         x < questions[i].answers.length;
                                                                    //         x++) {
                                                                    //       print(questions[i]
                                                                    //           .answers[x]
                                                                    //           .answer);
                                                                    //     }
                                                                    //   }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                                'Answers: ${questions[questions.length - 1].answers.length}/8'),
                                                            for (var i = 0; i < questions[questions.length - 1].answers.length && i < 8; i++)
                                                              TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        labelText:
                                                                            'Answer'),
                                                                controller:
                                                                    answersControllerList[
                                                                        i],
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please enter some text';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                children: [
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                        'Add answer'),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                        () {
                                                                          snackBar(
                                                                              'Processing Data');
                                                                          if (questions[questions.length - 1].answers.length !=
                                                                              8) {
                                                                            //questions[questions.length - 1].answers.add(Answer('answer${questions[questions.length - 1].answers.length}',
                                                                            //    0));
                                                                            questions[questions.length -1].answers.add(Answer(answersControllerList[questions[questions.length -1].answers.length -1].text, 0,),);
                                                                            answersControllerList.add(TextEditingController());
                                                                          } else {
                                                                            snackBar('You can\'t have more than 8 answers!');
                                                                          }
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                        'Remove answer'),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                        () {
                                                                          if (questions[questions.length - 1].answers.length !=
                                                                              1) {
                                                                            questions[questions.length - 1].answers.length -=
                                                                                1;
                                                                            answersControllerList.removeLast();
                                                                          } else {
                                                                            snackBar('You can\'t have less than 1 answer!');
                                                                          }
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    child: Text(
                                                                        'Submit'),
                                                                    style: ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all<
                                                                            Color>(Theme.of(
                                                                                context)
                                                                            .colorScheme
                                                                            .secondary)),
                                                                    onPressed:
                                                                        () {
                                                                      if (_subFormKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        snackBar(
                                                                            'Processing Data');
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              ElevatedButton(
                                child: Text('Submit'),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // addToQuizzes(typeQuiz);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      // Spacer(flex: 1),
                    ],
                  ),
                  Spacer(flex: 1),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(descriptionController.text);
            // addToQuizzes(typeQuiz);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        },
      ),
    );
  }
}
