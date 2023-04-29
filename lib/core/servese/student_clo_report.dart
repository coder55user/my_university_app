import 'package:app_excle/core/servese/clo_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCloReport {
  //get docs of quiz
  static Future<List<CloModelReport>> getQuizByCloName({
    required String baseDocsIdSubject,
    required String quizTypeName,
    required String docsQuiz,
  }) async {
    List<CloModelReport> data = [];
    var summ = 0.0;

    try {
      //studentDocs
      final studentDocs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection("students")
          .get();

      //quizDocs

      final quizDocs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection("students")
          .doc(studentDocs.docs.first.id)
          .collection("quizzes")
          .get();

      //studentDocs
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection("students")
          .doc(studentDocs.docs.first.id)
          .collection("quizzes")
          .doc(quizDocs.docs.first.id)
          .collection("questions")
          .get();
      for (var element2 in result.docs) {
        if (element2.data()['name'] == "Q 3") {
          summ = summ + element2.data()['clo_degree'];
        }
      }

      print(summ);
    } catch (e) {
      // TODO
    }

    return data;
  }
}
