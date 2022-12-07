import './question.dart';
import './result.dart';

class Quiz {
  String? id;
  final bool? typeQuiz;
  final String? description;
  final String? creator;
  final DateTime? date;
  final List<Question>? questions;
  final List<Result>? results;

  Quiz({
    this.id,
    this.typeQuiz,
    this.description,
    this.creator,
    this.date,
    this.questions,
    this.results,
  });

  factory Quiz.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return Quiz(
      typeQuiz: data['typeQuiz'],
      description: data['description'],
      creator: data['creator'],
      date: data['date'].toDate(),
      questions: List<Question>.from(
          data['questions'].map((x) => Question.fromFirestore(x))),
      results: List<Result>.from(
          data['results'].map((x) => Result.fromFirestore(x))),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (typeQuiz != null) "typeQuiz": typeQuiz,
      if (description != null) "description": description,
      if (creator != null) "creator": creator,
      if (date != null) "date": date,
      if (questions != null)
        "questions": List<dynamic>.from(questions!.map((x) => x.toFirestore())),
      if (results != null)
        "results": List<dynamic>.from(results!.map((x) => x.toFirestore())),
    };
  }
}


  // factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
  //       typeQuiz: json['typeQuiz'],
  //       description: json['description'],
  //       creator: json['creator'],
  //       date: (json['date'] as Timestamp).toDate(),
  //       questions: List<Question>.from(json['Question'].map((x) => Question.fromJson(x))),
  //     );

  // Map<String, dynamic> toJson() => {
  //       'typeQuiz': typeQuiz,
  //       'description': description,
  //       'creator': creator,
  //       'date': date,
  //       'questions': List<dynamic>.from(questions!.map((x) => x.toJson())),
  //     };
  // }
