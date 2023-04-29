class QuizTypeModel {
  String? title;
  String? idDocs;

  QuizTypeModel({
    this.title,
    this.idDocs,
  });

  //

  QuizTypeModel.fromMap(
    Map<String, dynamic> json,
    String? docsId,
  ) {
    title = json['name'] ?? "";
    idDocs = docsId ?? "";
  }

  Map<String, dynamic> toMap() {
    return {
      'name': title,
      'id': idDocs,
    };
  }
}

class QuestionOfQuizModel {
  String? name;
  String? idDocs;
  String? cloId;
  String? cloName;
  double? cloDegree;

  QuestionOfQuizModel({
    this.idDocs,
    this.cloId,
    this.name,
    this.cloName,
    this.cloDegree,
  });

  //

  QuestionOfQuizModel.fromMap(
    Map<String, dynamic> json,
    String? docsId,
  ) {
    idDocs = docsId ?? "";
    name = json['name'] ?? "";
    cloId = json['clo_id'] ?? "";
    cloName = json['clo_name'] ?? "";
    cloDegree = json['clo_degree'] ?? 0.0;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? "",
      'clo_id': cloId ?? "",
      'clo_name': cloName ?? "",
      'clo_degree': cloDegree ?? 0.0,
    };
  }
}
