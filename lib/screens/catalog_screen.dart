// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz.dart';

CollectionReference quizzesRef = FirebaseFirestore.instance
    .collection('quizzes')
    .withConverter<Quiz>(
      fromFirestore: (snapshots, _) => Quiz.fromFirestore(snapshots.data()!),
      toFirestore: (quiz, _) => quiz.toFirestore(),
    );

Future<void> getQuizzes() async {
  // final ref = FirebaseFirestore.instance.collection("quizzes").doc("Sq5kabHbNyGlyNX5Y4Eg").withConverter(
  //       fromFirestore: (snapshots, _) => Quiz.fromFirestore(snapshots.data()!),
  //       toFirestore: (quiz, _) => quiz.toFirestore(),
  //     );

  // final docSnap = await ref.get().whenComplete(() => print('mfka'));
  // print(docSnap.data());
  // final q1 = docSnap.data();
  // print(q1);
  // final docSnap = await quizzesRef.doc('Sq5kabHbNyGlyNX5Y4Eg').get().whenComplete(() => print('GAMER'));
  // print('BEFORE');
  // print(docSnap.data());
  // Quiz q1 = docSnap.data();
  // print('AFTER');
  // print(q1);
  // final docSnap = await quizzesRef.get();
  // print(docSnap);
  // final quiz1 = docSnap.data();
  // print(quiz1);
  // var qrg = await quizzesRef.get();
  // qrg.docs.forEach((doc) {
  //   print(doc.data());
  // });
  // var qrdg = await quizzesRef.doc('4P8LyK2HlyFkhhW3YwWI').withConverter<Quiz>(
  //         fromFirestore: (snapshot, _) => Quiz.fromJson(snapshot.data()!),
  //         toFirestore: (quiz, _) => quiz.toJson(),
  //       ).get().whenComplete(() => print('GUCCI'));
  // print(qrdg.get('field'));
}

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
          future: getQuizzes(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            // if (snapshot.hasData && !snapshot.data!.exists) {
            //   return Text("Document does not exist");
            // }

            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.count(
                crossAxisCount: 2,
                children: [
                  for (var i = 0; i < quizzes.length - 1; i++)
                    Card(
                      child: Column(
                        children: [
                          Text(quizzes[i].description!),
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Center(
                              child: Text('Image Placeholder'),
                            ),
                          ),
                          Text(
                            (quizzes[i].creator!),
                          ),
                          // Text(
                          //   (DateTimeFormatdata[i]['date']),
                          // ),
                        ],
                      ),
                    )
                ],
              );
            }

            return Center(child: Text("loading"));
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
