import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/subject/data/models/count_quiz_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class BaseControllerQuiz {
  //create docs of a clo
  Future<Either<Failure, int>> addQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required int numberQuestion,
    required String name,
  }) async {
    //data of every quiz
    try {
      Map<String, dynamic> data = {"name": name};
      final docsQuizCreate = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .add(data);

      //add question for every quiz
      await addQuestion(
        docsQuizCreate: docsQuizCreate,
        numberQuestion: numberQuestion,
      );

      //add the quiz for every student
      await addQuizToStudent(
        baseDocsIdSubject: baseDocsIdSubject,
        quizType: quizType,
        numberQuestion: numberQuestion,
        name: name,
      );
      return right(1);
    } catch (e) {
      return left(FireBaseFailure("error on create quiz"));
    }
  }

  Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docsQuizCreate,
    required int numberQuestion,
  }) async {
    for (var i = 1; i <= numberQuestion; i++) {
      //
      Map<String, dynamic> data = {
        "name": "Q $i",
        "clo_id": "",
        "clo_name": "",
      };
      await docsQuizCreate.collection("questions").add(data);
    }
  }

  //-------------------------------add quiz to specific student----------------------------
  //create docs of a clo
  Future<Either<Failure, int>> addQuizToStudent({
    required String baseDocsIdSubject,
    required String quizType,
    required int numberQuestion,
    required String name,
  }) async {
    //data of every quiz
    try {
      Map<String, dynamic> data = {"name": name};

      //get all the student id docs
      final studentIdDocs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection("students")
          .get();

      //loop
      for (var element in studentIdDocs.docs) {
        //add the quiz for every student
        final docsQuizCreate = await FirebaseFirestore.instance
            .collection("subjects2")
            .doc(baseDocsIdSubject)
            .collection("students")
            .doc(element.id)
            .collection(quizType)
            .add(data);
        //add question for every quiz
        await addQuestionToQuizStudent(
          docsQuizCreate: docsQuizCreate,
          numberQuestion: numberQuestion,
        );
      }

      return right(1);
    } catch (e) {
      return left(FireBaseFailure("error on create quiz"));
    }
  }

  Future<void> addQuestionToQuizStudent({
    required DocumentReference<Map<String, dynamic>> docsQuizCreate,
    required int numberQuestion,
  }) async {
    for (var i = 1; i <= numberQuestion; i++) {
      //
      Map<String, dynamic> data = {
        "name": "q$i",
        "degree": 0.0,
      };
      await docsQuizCreate.collection("questions").add(data);
    }
  }
}
