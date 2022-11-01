// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/add_questions.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  String? validatorIsEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  CollectionReference quizzes =
      FirebaseFirestore.instance.collection('quizzes');

  final descriptionController = TextEditingController();
  
  var typeQuiz = true;
  

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
                                validator: validatorIsEmpty
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
                                    if (_formKey.currentState!.validate()) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddQuestions();
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
