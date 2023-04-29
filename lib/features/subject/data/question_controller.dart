import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/subject/data/models/count_quiz_type_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class QuestionController {
  //!get Count Of Question
  Future<Either<Failure, List<QuestionOfQuizModel>>> getQuestionDataOfQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsCollectionQuiz,
  }) async {
    List<QuestionOfQuizModel> data = [];

    //
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .doc(docsCollectionQuiz)
          .collection('questions')
          .get();
      for (var element in result.docs) {
        data.add(
          QuestionOfQuizModel.fromMap(element.data(), element.id),
        );
      }
      return right(data);
    } catch (e) {
      return left(FireBaseFailure("message on get Question Of quiz $e"));
    }
  }

  //!get Count Of Question
  Future<Either<Failure, int>> updateQuestionDataOfQuiz({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuiz,
    required String docsIdQuestionUpdate,
    required String newCloIdUpdateData,
    required String newCloNameData,
    required String name,
  }) async {
    //data update
    QuestionOfQuizModel data = QuestionOfQuizModel(
      cloId: newCloIdUpdateData,
      cloName: newCloNameData,
      name: name,
      cloDegree: 0.0,
    );
    //
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .doc(docsQuiz)
          .collection('questions')
          .doc(docsIdQuestionUpdate)
          .update(
        {
          "clo_id": newCloIdUpdateData,
          "clo_name": newCloNameData,
          "name": name,
          // "clo_degree": 0.0,
        },
      );

      return right(1);
    } catch (e) {
      return left(FireBaseFailure("message on update Question Of quiz $e"));
    }
  }

  //!get Count Of Question
  Future<Either<Failure, int>> updateDegreeOfQuizType({
    required String baseDocsIdSubject,
    required String quizType,
    required String docsQuiz,
    required String docsIdQuestionUpdate,
    required double newDegree,
  }) async {
    //data update

    //
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .doc(docsQuiz)
          .collection('questions')
          .doc(docsIdQuestionUpdate)
          .update(
        {
          "clo_degree": newDegree,
        },
      );

      return right(1);
    } catch (e) {
      return left(FireBaseFailure("message on update Question Of quiz $e"));
    }
  }
}
