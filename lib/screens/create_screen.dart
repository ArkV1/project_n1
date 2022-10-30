// ignore_for_file: prefer_const_constructors

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
  final questionController = TextEditingController();
  List<TextEditingController> answersControllerList = [TextEditingController()];
  //
  int activeQuestions = 1;
  int activeAnswerFields = 1;
  //
  var typeQuiz = true;
  //
  List<Question> questions = [];
  //

  Future<void> addToQuizzes(typeQuiz) {
    //
    String testQuestion = 'testQuestion';
    //
    return quizzes.add({
      'typeQuiz': typeQuiz,
      'questions': 'questions',
      'creator': 'Anonymous',
      'date': DateTime.now(),
    });
  }

  final _formKey = GlobalKey<FormState>();

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
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text(
                                                              'Questions: $activeQuestions/8'),
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Question'),
                                                            // controller:
                                                            //     descriptionController,
                                                            validator: (value) {
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
                                                                    'Next question'),
                                                                onPressed: () {
                                                                  List<Answer> answers = [];
                                                                  for (var i = 0; i < activeAnswerFields; i++) {
                                                                    answers.add(Answer(answersControllerList[i].text, 0));
                                                                  };
                                                                  questions.add(Question(questionController.text,answers));
                                                                },
                                                              ),
                                                              ElevatedButton(
                                                                child: Text(
                                                                    'Previous question'),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                              'Answers: $activeAnswerFields/8'),
                                                          for (var i = 0;
                                                              i < activeAnswerFields &&
                                                                  i < 8;
                                                              i++)
                                                            TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          'Answer'),
                                                              controller:
                                                                  answersControllerList[0],
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
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Column(
                                                              children: [
                                                                ElevatedButton(
                                                                  child: Text(
                                                                      'Add answer'),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                      () {
                                                                        if (activeAnswerFields !=
                                                                            8) {
                                                                          activeAnswerFields +=
                                                                              1;
                                                                          answersControllerList
                                                                              .add(TextEditingController());
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            const SnackBar(content: Text('You can\'t have more than 8 answers!')),
                                                                          );
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
                                                                        if (activeAnswerFields !=
                                                                            1) {
                                                                          activeAnswerFields -=
                                                                              1;
                                                                          answersControllerList
                                                                              .removeLast();
                                                                        } else {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            const SnackBar(content: Text('You can\'t have less than 1 answer!')),
                                                                          );
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
                                                                    print(
                                                                        answersControllerList);
                                                                    print(answersControllerList
                                                                        .length);
                                                                    if (_formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      // addToQuizzes(typeQuiz);
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        const SnackBar(
                                                                            content:
                                                                                Text('Processing Data')),
                                                                      );
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
