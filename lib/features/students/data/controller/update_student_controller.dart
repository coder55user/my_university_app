import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/students/data/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UpdateStudentController {
  //get All Subject
  Future<Either<Failure, int>> updateDegreeStudent({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsQuizSection,
    required String nameCollectionSection,
    required String idDocsOfQuestionUpdate,
    required double newDegree,
    required String newKey,
  }) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubject)
          .collection("students")
          .doc(idDocsStudent)
          .collection(nameCollectionSection)
          .doc(idDocsQuizSection)
          .collection("questions")
          .doc(idDocsOfQuestionUpdate)
          .update({
        "degree": newDegree,
        "name": newKey,
      });

      print("-----------------------------");
      print("success update");
      print("-----------------------------");
      return right(1);
    } catch (e) {
      print("-----------------------------");
      print("error update");
      print("-----------------------------");
      return left(FireBaseFailure("error on update Degree Student $e"));
    }
  }

  //delete Student
  Future<Either<Failure, int>> deleteStudent({
    required String idDocsStudent,
    required String baseIdDocsSubject,
  }) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubject)
          .collection("students")
          .doc(idDocsStudent)
          .delete();

      print("-----------------------------");
      print("delete Student success update");
      print("-----------------------------");
      return right(1);
    } catch (e) {
      print("-----------------------------");
      print("error delete Student error update");
      print("-----------------------------");
      return left(FireBaseFailure("error on delete a Student $e"));
    }
  }
}
