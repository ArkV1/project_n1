class Answer {
  String? answer;
  int? score;

  Answer({
    this.answer,
    this.score,
  });

  factory Answer.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return Answer(
      answer: data?['answer'],
      score: data?['score'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (answer != null) "answer": answer,
      if (score != null) "score": score,
    };
  }

  // factory Answer.fromJson(Map<String, dynamic> json) => Answer(
  //       answer: json["answer"],
  //       score: json["score"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "answer": answer,
  //       "score": score,
  //     };
}
