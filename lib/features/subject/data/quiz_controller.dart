import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/subject/data/models/count_quiz_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class QuizController {
  //!get Count Quiz Type
  Future<Either<Failure, List<QuizTypeModel>>> getCountQuizType({
    required String baseDocsIdSubject,
    required String quizType,
  }) async {
    List<QuizTypeModel> data = [];
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .get();

      for (var element in result.docs) {
        data.add(QuizTypeModel.fromMap(element.data(), element.id));
      }
      return right(data);
    } catch (e) {
      return left(FireBaseFailure("message on getCountQuizType $e"));
    }
  }

  Future<Either<Failure, int>> deleteQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuizDelete,
    required String nameQuiz,
  }) async {
    try {
      //
      await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .doc(docsQuizDelete)
          .delete();

      //
      await deleteQuizFromEveryStudents(
        baseDocsIdSubject: baseDocsIdSubject,
        quizType: quizType,
        docsQuizDelete: docsQuizDelete,
        nameQuiz: nameQuiz,
      );
      return right(1);
    } catch (e) {
      return left(FireBaseFailure("message on delete quiz $e"));
    }
  }

  //delete the quiz from every students
  Future<Either<Failure, int>> deleteQuizFromEveryStudents({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuizDelete,
    required String nameQuiz,
  }) async {
    try {
      //get all the id of students
      final studentsIdDocs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection("students")
          .get();

      //loop
      for (var element in studentsIdDocs.docs) {
        //delete the quiz from every students
        final quizDocs = await FirebaseFirestore.instance
            .collection("subjects2")
            .doc(baseDocsIdSubject)
            .collection("students")
            .doc(element.id)
            .collection(quizType)
            .get();

        //check to delete
        for (var secondElement in quizDocs.docs) {
          //
          if (secondElement.data()['name'] == nameQuiz) {
            await FirebaseFirestore.instance
                .collection("subjects2")
                .doc(baseDocsIdSubject)
                .collection("students")
                .doc(element.id)
                .collection(quizType)
                .doc(secondElement.id)
                .delete();
            print("we found");
          }
          //
        }
      }
      print("success delete quizzes from students");
      return right(1);
    } catch (e) {
      return left(FireBaseFailure("message on delete quiz from students $e"));
    }
  }
}
