import './answer.dart';

class Question {
  String? questionText;
  List<Answer>? answers;

  Question({
    this.questionText,
    this.answers,
  });

  factory Question.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return Question(
      questionText: data?['questionText'],
      answers: List<Answer>.from(
          data?['answers'].map((x) => Answer.fromFirestore(x))),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (questionText != null) "questionText": questionText,
      if (answers != null)
        "answers": List<dynamic>.from(answers!.map((x) => x.toFirestore())),
    };
  }
  // factory Question.fromJson(Map<String, dynamic> json) => Question(
  //       questionText: json['questionText'],
  //       answers:
  //           List<Answer>.from(json['answers'].map((x) => Answer.fromJson(x))),
  //     );

  // Map<String, dynamic> toJson() => {
  //       'questionText': questionText,
  //       'answers': List<dynamic>.from(answers.map((x) => x.toJson())),
  //     };
}
