class Result {
  String? result;
  int? score;

  Result({
    this.result,
    this.score,
  });

  factory Result.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return Result(
      result: data?['result'],
      score: data?['score'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (result != null) "result": result,
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
