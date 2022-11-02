// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import './widgets/quiz_list.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference quizzes =
        FirebaseFirestore.instance.collection('quizzes');

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: quizzes.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            // if (snapshot.hasData && !snapshot.data!.exists) {
            //   return Text("Document does not exist");
            // }

            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.docs.toList();
              return GridView.count(
                crossAxisCount: 2,
                children: [
                  for (var i = 0; i < snapshot.data!.docs.length; i++)
                    Card(
                      child: Column(
                        children: [
                          Text(data[i]['description']),
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: Center(
                              child: Text('Image Placeholder'),
                            ),
                          ),
                          Text(
                            (data[i]['creator']),
                            // Text(
                            //   (DateFormat.yMMMd().format()),
                            // ),
                          ),
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
