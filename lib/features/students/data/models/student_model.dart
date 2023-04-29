class StudentModel {
  int? ID;
  int? S_NO;
  String? name;
  String? idDocs;
  StudentModel({
    this.ID = 0,
    this.name = "",
    this.idDocs,
  });
  StudentModel.fromMap({
    required Map<String, dynamic> json,
    required String IdDocs,
  }) {
    // ID = json['ID'];
    // S_NO = json['S_NO'];
    name = json['name'];
    idDocs = IdDocs;
  }

  Map<String, dynamic> toMap() => {
        'ID': ID,
        'S_NO': S_NO,
        'name': name,
      };
}

class StudentQuestionModel {
  String? name;
  String? idDocs;
  double? degree;
  StudentQuestionModel({
    this.degree = 0,
    this.name = "",
    this.idDocs,
  });
  StudentQuestionModel.fromMap({
    required Map<String, dynamic> json,
    required String IdDocs,
  }) {
    name = json['name'];
    degree = json['degree'];
    idDocs = IdDocs;
  }

}
