import './answer.dart';

class Question {
  Question({
    required this.questionText,
    required this.answers,
  });

  String questionText;
  List<Answer> answers;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionText: json['questionText'],
        answers:
            List<Answer>.from(json['answers'].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'questionText': questionText,
        'answers': List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}
