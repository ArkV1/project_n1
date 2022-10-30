class Quiz {
  String id;
  String typeQuiz;
  String description;
  Map<String, Object> questions;
  String creator;
  DateTime date;

  Quiz(
    this.id,
    this.typeQuiz,
    this.description,
    this.questions,
    this.creator,
    this.date,
  );
}
