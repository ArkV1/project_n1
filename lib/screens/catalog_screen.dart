// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference quizzesRef =
        FirebaseFirestore.instance.collection('quizzes').withConverter<Quiz>(
              fromFirestore: (snapshots, _) => Quiz.fromJson(snapshots.data()!),
              toFirestore: (quiz, _) => quiz.toJson(),
            );
    
    //List<Quiz> quizzes = [];
    
    return Scaffold(
      body: SafeArea(
        //child: Text('hehe'),
        child: FutureBuilder(
          future: quizzesRef.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            // if (snapshot.hasData && !snapshot.data!.exists) {
            //   return Text("Document does not exist");
            // }

            if (snapshot.hasData && snapshot.data!.docs != null && snapshot.connectionState == ConnectionState.done) {
              List<Quiz> quizzes = [];
              snapshot.data!.docs.forEach((doc) {
                quizzes.add(doc.data() as Quiz);
              });
              //snapshot.data!.docs.toList().get().then((snapshot) => snapshot.data()!);
              return GridView.count(
                crossAxisCount: 2,
                children: [
                  for (var i = 0; i < quizzes.length - 1; i++)
                    Card(
                      child: Column(
                        children: [
                          Text(quizzes[i].description),
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Center(
                              child: Text('Image Placeholder'),
                            ),
                          ),
                          Text(
                            (quizzes[i].creator),
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
