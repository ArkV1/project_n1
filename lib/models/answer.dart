import 'dart:ffi';

class Answer {
  Answer({
    required this.answer,
    required this.score,
  });

  String answer;
  int score;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answer: json["answer"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "score": score,
      };
}
