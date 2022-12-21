// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/quiz.dart';
import '../models/question.dart';
import '../models/result.dart';
import '../widgets/pickers/create_screen_image_picker.dart';
import '../widgets/buttons/add_questions.dart';
import '../widgets/buttons/add_results.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  List<Question> questions = [];
  List<Result> results = [];
  File? _quizPreviewImage;

  void callbackQuestions(questions) {
    setState(() {
      this.questions = questions;
    });
  }

  void callbackResults(results) {
    setState(() {
      this.results = results;
    });
  }

  String? validatorIsEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  CollectionReference quizzes = FirebaseFirestore.instance
      .collection('submitted-quizzes')
      .withConverter<Quiz>(
        fromFirestore: (snapshots, _) => Quiz.fromFirestore(snapshots.data()!),
        toFirestore: (quiz, _) => quiz.toFirestore(),
      );
  Reference storage = FirebaseStorage.instance.ref();

  final descriptionController = TextEditingController();

  var typeQuiz = true;

  void _pickedImage(File image) {
    _quizPreviewImage = image;
  }

  void printQuestions(List<Question> questions) {
    print('Number of questions: ${questions.length}');
    for (var i = 0; i < questions.length; i++) {
      print('Question #${i + 1} is ${questions[i].questionText}');
      for (var x = 0; x < questions[i].answers!.length; x++) {
        print('Answer #${x + 1} is ${questions[i].answers![x].answer}');
      }
    }
  }

  Future<void> addToQuizzes(typeQuiz) {
    // god bless quicktype.io
    print('TRYING TO ADD A DOCUMENT TO A FIRESTORE');
    var quiz = Quiz(
      typeQuiz: typeQuiz,
      description: descriptionController.text,
      creator: 'Anonymous',
      date: DateTime.now(),
      questions: questions,
      results: results,
    );
    print(quiz.toFirestore());

    return quizzes.add(quiz).then((value) {
      print(value.id);
      if (_quizPreviewImage != null) {
        storage
            .child('quiz_images')
            .child(value.id + '.jpg')
            .putFile(_quizPreviewImage!);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    // if (_quizPreviewImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please pick an image'),
    //     ),
    //   );
    // }

    if (_formKey.currentState!.validate()) {
      print('Theme of the quiz is ${descriptionController.text}');
      printQuestions(questions);
      addToQuizzes(typeQuiz);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Row(
                  children: [
                    Spacer(flex: 1),
                    Column(
                      children: [
                        // Spacer(flex: 1),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CreateScreenImagePicker(_pickedImage),
                              IntrinsicWidth(
                                child: Column(
                                  children: [
                                    TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Description'),
                                        controller: descriptionController,
                                        validator: validatorIsEmpty),
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
                                  ],
                                ),
                              ),
                              if (typeQuiz == true) ...[
                                Text('Type: Quiz'),
                              ] else ...[
                                Text('Type: Test'),
                              ],
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
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
                              ),
                              IntrinsicWidth(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ElevatedButton(
                                        child: Text('Add questions'),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AddQuestions(
                                                    this.questions,
                                                    callbackQuestions);
                                              },
                                            );
                                          }
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Text('Add results'),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AddResults(this.results,
                                                    callbackResults);
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                      'Your quiz/test will not be visible to other people in the catalog menu until it is approved by a moderator.'),
                                ),
                              ),
                              ElevatedButton(
                                child: Text('Submit'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  // MaterialStateProperty.all<Color>(
                                  //     Theme.of(context)
                                  //         .colorScheme
                                  //         .secondary),
                                ),
                                onPressed: _trySubmit,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                      'To submit items directly to the catalog, you need to log in.'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Spacer(flex: 1),
                      ],
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: _trySubmit,
      // ),
    );
  }
}
