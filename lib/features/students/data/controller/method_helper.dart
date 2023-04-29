import 'package:cloud_firestore/cloud_firestore.dart';

class MethodStudentHelper {
  //get Count Of Clos
  static Future<int> getCountOfSection({
    required String baseDocsIdSubject,
    required String collectionName,
  }) async {
    final count = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseDocsIdSubject)
        .collection(collectionName)
        .get();
    return count.docs.length;
  }

  //get Count Of Clos
  static Future<List<String>> getBaseClosId({
    required String baseDocsIdSubject,
  }) async {
    List<String> id = [];
    final count = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseDocsIdSubject)
        .collection("clos")
        .get();
    for (var element in count.docs) {
      id.add(element.id);
    }

    return id;
  }

  //
  static Future<List<String>> getDocsOfQuizType({
    required String baseDocsIdSubject,
    required String quizType,
  }) async {
    List<String> data = [];

    final result = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseDocsIdSubject)
        .collection(quizType)
        .get();
    for (var element in result.docs) {
      data.add(element.id);
    }

    return data;
  }

  //
  static Future<int> getCountOfQuestions({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuiz,
  }) async {
    final result = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseDocsIdSubject)
        .collection(quizType)
        .doc(docsQuiz)
        .collection("questions")
        .get();
    return result.docs.length;
  }

  //
  static Future<List<String>> getNameOfQuizType({
    required String baseDocsIdSubject,
    required String quizType,
  }) async {
    List<String> data = [];
    final result = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseDocsIdSubject)
        .collection(quizType)
        .get();
    for (var element in result.docs) {
      data.add(element.data()['name']);
    }
    return data;
  }

  //
  static Future<DocumentReference<Map<String, dynamic>>> addTheQuestionForQuiz({
    required DocumentReference<Map<String, dynamic>> docsTypeQuiz,
    required int i,
    String? baseDocsIdSubject,
  }) async {
    //get the count of questions quiz
    Map<String, dynamic> data = {
      "name": "Q $i",
      "degree": 0.0,
      "clo_name": "",
    };
    return await docsTypeQuiz.collection("questions").add(data);
  }

 static Future<DocumentReference<Map<String, dynamic>>> addQuizTypeToStudent({
    required String baseDocsIdSubject,
    required String idDocsStudent,
    required String dataQuiz,
    required String collectionName,
  }) async {
    Map<String, dynamic> data = {"name": dataQuiz};

    final result = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseDocsIdSubject)
        .collection("students")
        .doc(idDocsStudent)
        .collection(collectionName)
        .add(data);
    return result;
  }
}
