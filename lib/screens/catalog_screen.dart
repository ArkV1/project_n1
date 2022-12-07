// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz.dart';
import '../widgets/quiz_widget.dart';

CollectionReference quizzesRef =
    FirebaseFirestore.instance.collection('quizzes');

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: quizzesRef
              .withConverter<Quiz>(
                  fromFirestore: (snapshots, _) =>
                      Quiz.fromFirestore(snapshots.data()!),
                  toFirestore: (quiz, _) => quiz.toFirestore())
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text('Not connected to the Stream or null'),);

              case ConnectionState.waiting:
                return Center(child: Text('Awaiting for interaction'),);

              case ConnectionState.active:
                print("Stream has started but not finished");

                var totalQuizzesCount = 0;
                List<DocumentSnapshot> quizzes;

                if (snapshot.hasData) {
                  quizzes = snapshot.data!.docs;
                  totalQuizzesCount = quizzes.length;

                  if (totalQuizzesCount > 0) {
                    return GridView.builder(
                      itemCount: totalQuizzesCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: ((context, index) {
                        final q = quizzes[index].data()! as Quiz;
                        q.id = quizzes[index].id;
                        return QuizWidget(quiz: q);
                      }),
                    );
                  }
                }
                return Center(
                  child: Text('No quizzes yet! Go create one!'),
                );
              case ConnectionState.done:
                return Center(
                  child: Text('Streaming is done'),
                );
            }
          },
        ),

        // child: FutureBuilder(
        //   future: futureQuizzes,
        //   builder: (BuildContext context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(child: Text("Something went wrong"));
        //     }

        //     // if (snapshot.connectionState == ConnectionState.done) {

        //     // }

        //     if (snapshot.connectionState == ConnectionState.done) {
        //       for (var doc in snapshot.data!.docs) {
        //         var dd = doc.data();
        //         quizzes.add(dd);
        //         print('Quiz added ${dd.description}');
        //       }
        //       print('${quizzes.length} quizzes overall');
        //       //
        //       if (quizzes.isEmpty) {
        //         return Center(
        //           child: Text('No quizzes yet! Go create one!'),
        //         );
        //       } else {
        //         return new GridView.count(
        //           crossAxisCount: 2,
        //           children: [
        //             for (var i = 0; i < quizzes.length; i++)
        //               QuizWidget(quiz: quizzes[i]),
        //           ],
        //         );
        //       }
        //     }
        //     return Center(child: Text("Loading.."));
        //   },
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu),
        onPressed: () {},
      ),
    );
  }
}
