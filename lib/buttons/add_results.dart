// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/result.dart';

class AddResults extends StatefulWidget {
  List<Result> results;
  Function(List<Result>) callback;
  AddResults(this.results, this.callback);

  @override
  State<AddResults> createState() => _AddResultsState();
}

class _AddResultsState extends State<AddResults> {
  String? validatorIsEmpty(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void snackBar(String snackText) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(content: Text(snackText)),
        )
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }

  void printResults(results) {
    print('Number of results: $numberOfResults');
    for (var i = 0; i < results.length; i++) {
      print('Result #${i + 1} is ${results[i].result}');
    }
  }

  final _subFormKey = GlobalKey<FormState>();

  List<Result> results = [];

  List<TextEditingController> resultsControllerList = [
    TextEditingController(),
  ];
  List<TextEditingController> resultsScoreControllerList = [
    TextEditingController(),
  ];

  var numberOfResults = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Add results'),
          content: StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Form(
                key: _subFormKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Text('Results: $numberOfResults/8'),
                        for (var i = 0; i < numberOfResults; i++)
                          Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.symmetric(vertical: (3.0)),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Result'),
                                  controller: resultsControllerList[i],
                                  validator: validatorIsEmpty,
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Score'),
                                  controller: resultsScoreControllerList[i],
                                  validator: validatorIsEmpty,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          ElevatedButton(
                            child: Text('Add result'),
                            onPressed: () {
                              setState(
                                () {
                                  // snackBar('Processing Data');
                                  if (numberOfResults != 8) {
                                    //questions[questions.length - 1].answers.add(Answer('answer${questions[questions.length - 1].answers.length}',
                                    //    0));
                                    numberOfResults++;
                                    resultsControllerList
                                        .add(TextEditingController());
                                    resultsScoreControllerList
                                        .add(TextEditingController());
                                  } else {
                                    snackBar(
                                        'You can\'t have more than 8 answers!');
                                  }
                                },
                              );
                            },
                          ),
                          ElevatedButton(
                            child: Text('Remove result'),
                            onPressed: () {
                              setState(
                                () {
                                  if (numberOfResults != 1) {
                                    resultsControllerList.removeLast();
                                    resultsScoreControllerList.removeLast();
                                    numberOfResults--;
                                    // questions[questions.length - 1]
                                    //     .answers
                                    //     .length -= 1;
                                    // answersControllerList.removeLast();
                                  } else {
                                    snackBar(
                                        'You can\'t have less than 1 result!');
                                  }
                                },
                              );
                            },
                          ),
                          ElevatedButton(
                            child: Text('Submit'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    Theme.of(context).colorScheme.secondary)),
                            onPressed: () {
                              if (_subFormKey.currentState!.validate()) {
                                List<Result> results = [];
                                for (var i = 0; i < numberOfResults; i++) {
                                  results.add(Result(
                                      result: resultsControllerList[i].text,
                                      score: 0));
                                }
                                printResults(results);
                                Navigator.pop(context);
                                widget.callback(results);
                                //
                                //
                                snackBar('Processing Data');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
    ;
  }
}
