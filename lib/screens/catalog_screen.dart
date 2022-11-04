// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz.dart';
import '../widgets/quiz_widget.dart';

CollectionReference quizzesRef =
    FirebaseFirestore.instance.collection('quizzes');

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Quiz> quizzes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        //child: Text('game'),
        child: FutureBuilder(
          future: quizzesRef
              .withConverter<Quiz>(
                fromFirestore: (snapshots, _) =>
                    Quiz.fromFirestore(snapshots.data()!),
                toFirestore: (quiz, _) => quiz.toFirestore(),
              )
              .get(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            // if (snapshot.connectionState == ConnectionState.done) {

            // }

            if (snapshot.connectionState == ConnectionState.done) {
              for (var doc in snapshot.data!.docs) {
                var dd = doc.data();
                quizzes.add(dd);
                print('Quiz added ${dd.description}');
              }
              print('${quizzes.length} quizzes overall');
              //
              return GridView.count(
                crossAxisCount: 2,
                children: [
                  for (var i = 0; i < quizzes.length; i++)
                    QuizWidget(quiz: quizzes[i]),
                ],
              );
            }
            return Center(child: Text("Loading.."));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu),
        onPressed: () {},
      ),
    );
  }
}
