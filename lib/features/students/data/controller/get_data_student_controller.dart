import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/students/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class GetDataStudentController {
  //get All Subject
  Future<Either<Failure, List<StudentModel>>> getDataSectionType({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsNameSection,
  }) async {
    try {
      List<StudentModel> data = [];
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubject)
          .collection("students")
          .doc(idDocsStudent)
          .collection(idDocsNameSection)
          .get();
      for (var element in result.docs) {
        print(element.data());
        data.add(
            StudentModel.fromMap(json: element.data(), IdDocs: element.id));
      }

      return right(data);
    } catch (e) {
      return left(FireBaseFailure("error on insert subject$e"));
    }
  }

  //get All Subject
  Future<Either<Failure, List<StudentQuestionModel>>>
      getDataQuestionSectionType({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsQuizSection,
    required String nameCollectionSection,
  }) async {
    try {
      List<StudentQuestionModel> data = [];
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubject)
          .collection("students")
          .doc(idDocsStudent)
          .collection(nameCollectionSection)
          .doc(idDocsQuizSection)
          .collection("questions")
          .get();
      for (var element in result.docs) {
        print(element.data());

        data.add(StudentQuestionModel.fromMap(
            json: element.data(), IdDocs: element.id));
      }

      return right(data);
    } catch (e) {
      return left(
          FireBaseFailure("error on getDataQuestionSectionType subject$e"));
    }
  }
//
  Future<Either<Failure, double>> getSumOfQuiz({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsQuizSection,
    required String nameCollectionSection,
  }) async {
    try {
      double sum = 0.0;
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubject)
          .collection("students")
          .doc(idDocsStudent)
          .collection(nameCollectionSection)
          .doc(idDocsQuizSection)
          .collection("questions")
          .get();
      for (var element in result.docs) {
        sum = sum + element.data()['degree'];
      }

      print("-----------------------------");
      print("success getSumOfQuiz");
      print("-----------------------------");
      return right(sum);
    } catch (e) {
      print("-----------------------------");
      print("error getSumOfQuiz");
      print("-----------------------------");
      return left(FireBaseFailure("error on update Degree Student $e"));
    }
  }
 
}
