import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/students/data/models/student_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'method_helper.dart';

class RepositoryStudentImpl {
  //create Subject

  Future<Either<Failure, String>> createStudent({
    required StudentModel studentModel,
    required String docsIdSubject,
  }) async {
    try {
      //
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(docsIdSubject)
          .collection("students")
          .add(studentModel.toMap());
      print("-----------------------");
      print("add a new students");
      print("-----------------------");

      //
      print("------------------------------");
      print("  success add subject");
      print("------------------------------");

      return right(result.id);
    } catch (e) {
      print("------------------------------");
      print("  error on add students");
      print("------------------------------");
      return left(FireBaseFailure("error on insert subject$e"));
    }
  }

  Future<Either<Failure, String>> createAnotherOperation({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //docs of students
    try {
      await StudentQuizzesOperation.createStudentQuizzes(
        idDocsStudent: idDocsStudent,
        baseDocsIdSubject: baseDocsIdSubject,
      );
      print("-----------------------");
      print("createStudentQuizzes");
      print("-----------------------");
      //
      await StudentAssignmentsOperation.createAssignmentQuizzes(
        idDocsStudent: idDocsStudent,
        baseDocsIdSubject: baseDocsIdSubject,
      );
      print("-----------------------");
      print("createAssignmentQuizzes");
      print("-----------------------");
      //
      await StudentMidTermExamsOperation.createMidTermExamsQuizzes(
        idDocsStudent: idDocsStudent,
        baseDocsIdSubject: baseDocsIdSubject,
      );
      print("-----------------------");
      print("createMidTermExamsQuizzes");
      print("-----------------------");
      //
      await StudentFinalExamOperation.createFinalExamQuizzes(
        idDocsStudent: idDocsStudent,
        baseDocsIdSubject: baseDocsIdSubject,
      );
      print("-----------------------");
      print("createFinalExamQuizzes");
      print("-----------------------");
      //laps
      await StudentLapsOperation.createLapsQuizzes(
        idDocsStudent: idDocsStudent,
        baseDocsIdSubject: baseDocsIdSubject,
      );
      return right("susses createAnotherOperation");
    } catch (e) {
      print("------------------------------");
      print("  error on add students");
      print("------------------------------");
      return left(FireBaseFailure("error on createAnotherOperation$e"));
    }
  }

  //get All students
  Future<Either<Failure, List<StudentModel>>> getAllStudent(
    String docs,
  ) async {
    try {
      List<StudentModel> data = [];
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(docs)
          .collection("students")
          .get();
      for (var element in result.docs) {
        print(element);
        data.add(StudentModel.fromMap(
          json: element.data(),
          IdDocs: element.id,
        ));
      }

      return right(data);
    } catch (e) {
      return left(FireBaseFailure("error on insert subject$e"));
    }
  }
}

//!---------------------------------Quizzes Operation-------------------------------------------
class StudentQuizzesOperation {
  //create docs of a clo
  static Future<void> createStudentQuizzes({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //list of name quiz
    final nameQuiz = await MethodStudentHelper.getNameOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "quizzes",
    );

    //list of docs id Quiz
    final docsQuiz = await MethodStudentHelper.getDocsOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "quizzes",
    );
    //loop as count of quiz that you want to create
    for (int i = 0; i < nameQuiz.length; i++) {
      //get count of question for every quiz
      final countQuestion = await MethodStudentHelper.getCountOfQuestions(
        baseDocsIdSubject: baseDocsIdSubject,
        quizType: "quizzes",
        docsQuiz: docsQuiz[i],
      );

      var docs = await MethodStudentHelper.addQuizTypeToStudent(
        baseDocsIdSubject: baseDocsIdSubject,
        idDocsStudent: idDocsStudent,
        dataQuiz: nameQuiz[i],
        collectionName: "quizzes",
      );

      //add question for every quiz
      await addQuestion(
        docsTypeQuiz: docs,
        baseDocsIdSubject: baseDocsIdSubject,
        countQuestion: countQuestion,
      );
    }
  }

  // add Question for quiz
  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docsTypeQuiz,
    required String baseDocsIdSubject,
    required int countQuestion,
  }) async {
    //loop to  create the question
    for (int i = 1; i <= countQuestion; i++) {
      //create question for the quiz
      await MethodStudentHelper.addTheQuestionForQuiz(
        docsTypeQuiz: docsTypeQuiz,
        i: i,
      );
    }
  }
}

//!---------------------------------Student Assignments Operation-------------------------------------------
class StudentAssignmentsOperation {
  //create docs of a clo
  static Future<void> createAssignmentQuizzes({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //list of name quiz
    final nameQuiz = await MethodStudentHelper.getNameOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "assignments",
    );
    //list of docs id Quiz
    final docsQuiz = await MethodStudentHelper.getDocsOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "assignments",
    );
    //loop as count of quiz that you want to create
    for (int i = 0; i < nameQuiz.length; i++) {
      //get count of question for every quiz
      final countQuestion = await MethodStudentHelper.getCountOfQuestions(
        baseDocsIdSubject: baseDocsIdSubject,
        quizType: "assignments",
        docsQuiz: docsQuiz[i],
      );
      //data of every quiz
      // Map<String, dynamic> data = {"name": nameQuiz[i]};
      //add the quiz
      // var docsTypeQuiz = await docsStudents.collection("assignments").add(data);
      var docsTypeQuiz = await MethodStudentHelper.addQuizTypeToStudent(
        baseDocsIdSubject: baseDocsIdSubject,
        idDocsStudent: idDocsStudent,
        dataQuiz: nameQuiz[i],
        collectionName: "assignments",
      );

      //add question for every quiz
      await addQuestion(
        docsTypeQuiz: docsTypeQuiz,
        baseDocsIdSubject: baseDocsIdSubject,
        countQuestion: countQuestion,
      );
    }
  }

  // add Question for quiz
  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docsTypeQuiz,
    required String baseDocsIdSubject,
    required int countQuestion,
  }) async {
    //loop to  create the question
    for (int i = 1; i <= countQuestion; i++) {
      //create question for the quiz
      await MethodStudentHelper.addTheQuestionForQuiz(
        i: i,
        docsTypeQuiz: docsTypeQuiz,
      );
    }
  }
}

//!---------------------------------Student Mid Term Exams Operation-------------------------------------------
class StudentMidTermExamsOperation {
  //create docs of a clo
  static Future<void> createMidTermExamsQuizzes({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //list of name quiz
    final nameQuiz = await MethodStudentHelper.getNameOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "midTermExams",
    );
    //list of docs id Quiz
    final docsQuiz = await MethodStudentHelper.getDocsOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "midTermExams",
    );
    //loop as count of quiz that you want to create
    for (int i = 0; i < nameQuiz.length; i++) {
      //get count of question for every quiz
      final countQuestion = await MethodStudentHelper.getCountOfQuestions(
        baseDocsIdSubject: baseDocsIdSubject,
        quizType: "midTermExams",
        docsQuiz: docsQuiz[i],
      );

      var docsTypeQuiz = await MethodStudentHelper.addQuizTypeToStudent(
        baseDocsIdSubject: baseDocsIdSubject,
        idDocsStudent: idDocsStudent,
        dataQuiz: nameQuiz[i],
        collectionName: "midTermExams",
      );

      //add question for every quiz
      await addQuestion(
        docsTypeQuiz: docsTypeQuiz,
        baseDocsIdSubject: baseDocsIdSubject,
        countQuestion: countQuestion,
      );
    }
  }

  // add Question for quiz
  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docsTypeQuiz,
    required String baseDocsIdSubject,
    required int countQuestion,
  }) async {
    //loop to  create the question
    for (int i = 1; i <= countQuestion; i++) {
      //create question for the quiz
      await MethodStudentHelper.addTheQuestionForQuiz(
        docsTypeQuiz: docsTypeQuiz,
        i: i,
      );
    }
  }
}

//!---------------------------------Student Mid Term Exams Operation-------------------------------------------
class StudentFinalExamOperation {
  //create docs of a clo
  static Future<void> createFinalExamQuizzes({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //add the quiz
    var docsTypeQuiz = await MethodStudentHelper.addQuizTypeToStudent(
      baseDocsIdSubject: baseDocsIdSubject,
      idDocsStudent: idDocsStudent,
      dataQuiz: "final Exam",
      collectionName: "finalExam",
    );

    //add question for every quiz
    await addQuestion(
      docsTypeQuiz: docsTypeQuiz,
      baseDocsIdSubject: baseDocsIdSubject,
    );
  }

  // add Question for quiz
  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docsTypeQuiz,
    required String baseDocsIdSubject,
  }) async {
    //loop to  create the question
    for (int i = 1; i <= 10; i++) {
      //create question for the quiz
      await MethodStudentHelper.addTheQuestionForQuiz(
        docsTypeQuiz: docsTypeQuiz,
        i: i,
      );
    }
  }
}

//!---------------------------------Student laps Operation-------------------------------------------
class StudentLapsOperation {
  //create docs of a clo
  static Future<void> createLapsQuizzes({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //list of name quiz
    final nameQuiz = await MethodStudentHelper.getNameOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "laps",
    );
    //list of docs id Quiz
    final docsQuiz = await MethodStudentHelper.getDocsOfQuizType(
      baseDocsIdSubject: baseDocsIdSubject,
      quizType: "laps",
    );
    //loop as count of quiz that you want to create
    for (int i = 0; i < nameQuiz.length; i++) {
      //get count of question for every quiz
      final countQuestion = await MethodStudentHelper.getCountOfQuestions(
        baseDocsIdSubject: baseDocsIdSubject,
        quizType: "laps",
        docsQuiz: docsQuiz[i],
      );
      //data of every quiz
      // Map<String, dynamic> data = {"name": nameQuiz[i]};
      //add the quiz
      var docsTypeQuiz = await MethodStudentHelper.addQuizTypeToStudent(
        baseDocsIdSubject: baseDocsIdSubject,
        idDocsStudent: idDocsStudent,
        dataQuiz: nameQuiz[i],
        collectionName: "laps",
      );

      //add question for every quiz
      await addQuestion(
        docsTypeQuiz: docsTypeQuiz,
        baseDocsIdSubject: baseDocsIdSubject,
        countQuestion: countQuestion,
      );
    }
  }

  // add Question for quiz
  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docsTypeQuiz,
    required String baseDocsIdSubject,
    required int countQuestion,
  }) async {
    //loop to  create the question
    for (int i = 1; i <= countQuestion; i++) {
      //create question for the quiz
      await MethodStudentHelper.addTheQuestionForQuiz(
        docsTypeQuiz: docsTypeQuiz,
        i: i,
      );
    }
  }
}
