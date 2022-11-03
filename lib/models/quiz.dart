import './question.dart';

class Quiz {
  Quiz({
    required this.typeQuiz,
    required this.description,
    required this.creator,
    required this.date,
    required this.questions,
  });

  bool typeQuiz;
  String description;
  String creator;
  DateTime date;
  List<Question> questions;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        typeQuiz: json['typeQuiz'],
        description: json['description'],
        creator: json['creator'],
        date: json['date'].toDate(),
        questions: List<Question>.from(
            json['Question'].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'typeQuiz': typeQuiz,
        'description': description,
        'creator': creator,
        'date': date,
        'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
