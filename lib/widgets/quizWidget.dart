import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/quizModel.dart';

class QuizWidget extends StatelessWidget {
  final Quiz q1;
  
  QuizWidget(
    this.q1,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Text(q1.description),
        SizedBox(
          height: 115,
          width: 115,
          child: Center(
            child: Text('Image Placeholder'),
          ),
        ),
        Text(q1.creator),
        Text(
          (DateFormat.yMMMd().format(q1.date)),
        ),
      ]),
    );
  }
}
