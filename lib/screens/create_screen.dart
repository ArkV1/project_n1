// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quizModel.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  //
  CollectionReference quizzes =
      FirebaseFirestore.instance.collection('quizzes');
  //
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  //
  var typeQuiz = true;
  String description = 'description';
  Map<String, Object> questions = {
    'questionText': 'Testing',
    'answers': ['Test', 'Test', 'Test', 'Test'],
  };
  String creator = 'Anonymous';
  DateTime date = DateTime.now();
  //
  Future<void> addToQuizzes(typeQuiz) {
    String typeQuizText;
    if (typeQuiz) {
      typeQuizText = 'Quiz';
    } else {
      typeQuizText = 'Test';
    }
    return quizzes.add({
      'typeQuizText': typeQuizText,
      'description': description,
      'questions': questions,
      'creator': creator,
      'date': date,
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
                                decoration: InputDecoration(labelText: 'Title'),
                                controller: titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
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
                                    onPressed: () {},
                                    child: Text('Add question')),
                              ),
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
        onPressed: () {}, // () => addToQuizzes(typeQuiz),
      ),
    );
  }
}
