// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './catalog_screen.dart';
import './create_screen.dart';
import './settings_screen.dart';
import '../models/quiz.dart';
import '../widgets/quiz_widget.dart';
import '../widgets/buttons/menu_button.dart';

final quizzesRef = FirebaseFirestore.instance.collection('quizzes');
final storage = FirebaseStorage.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void pageNavigation(BuildContext ctx, screen) async {
    await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return screen;
        },
      ),
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Quiz> quizzes = [];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 1),
          Column(
            children: [
              Text('Quizzes and Tests', textScaleFactor: 1.75),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(flex: 1),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: FutureBuilder(
                        future: quizzesRef
                            .withConverter<Quiz>(
                              fromFirestore: (snapshots, _) =>
                                  Quiz.fromFirestore(snapshots.data()!),
                              toFirestore: (quiz, _) => quiz.toFirestore(),
                            )
                            .get(const GetOptions(source: Source.cache)),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text("Something went wrong"));
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            for (var doc in snapshot.data!.docs) {
                              var dd = doc.data();
                              dd.id = doc.id;
                              quizzes.add(dd);
                              print('Quiz added ${dd.description}');
                            }
                            print('${quizzes.length} quizzes overall');
                            return Container(
                              child: quizzes.isNotEmpty
                                  ? AspectRatio(
                                    aspectRatio: 16/9,
                                    child: QuizWidget(
                                        quiz: (quizzes.toList()..shuffle()).first,),
                                  )
                                  : null,
                            );
                          }
                          return Center(child: Text("Loading.."));
                        },
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MenuButton(
                      'Catalog',
                      () => pageNavigation(context, CatalogScreen()),
                    ),
              
                    MenuButton('Saved', () {}),
                    
                    MenuButton(
                      'Create',
                      () => pageNavigation(context, CreateScreen()),
                    ),
                    MenuButton(
                      'Settings',
                      () => pageNavigation(context, SettingsScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
