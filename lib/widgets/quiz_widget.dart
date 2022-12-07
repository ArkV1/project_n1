// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/screens/home_screen.dart';
import '/screens/quiz_screen.dart';
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

  Future<String> getQuizPreviewImage() async {
    var imagUrl;
    try {
      imagUrl =
          await storage.ref('quiz_images/${quiz.id}.jpg').getDownloadURL();
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      print("Failed with error '${e.code}': ${e.message}");
      imagUrl = storage.ref('quiz_images/sample.jpg').getDownloadURL();
    }
    return imagUrl;
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
                          Text(
                              'Date: ${DateFormat.yMMMd().format(quiz.date!)}'),
                          Text(DateFormat.jm().format(quiz.date!)),
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
        child: FutureBuilder(
          future: getQuizPreviewImage(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: Text('Loading...'));
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Card(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!),
                              fit: BoxFit.fitHeight)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            width: double.infinity,
                            color: Theme.of(context)
                                .dialogBackgroundColor
                                .withOpacity(0.75),
                            child: Center(
                              child: Text(
                                quiz.description!,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            width: double.infinity,
                            color: Theme.of(context)
                                .dialogBackgroundColor
                                .withOpacity(0.75),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    quiz.creator!,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    DateFormat.yMMMd().format(quiz.date!),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            }
          },
        ));
  }
}
