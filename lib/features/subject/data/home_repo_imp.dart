import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/subject_model.dart';

class RepositorySubjectImpl {
  //create Subject
  Future<Either<Failure, String>> createSubject(
    SubjectModel subjectModel,
  ) async {
    print("------------------------------");
    print("start createSubject");
    print("------------------------------");

    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .add(subjectModel.toMap());
      print("------------------------------");
      print("add new subjects");
      print("------------------------------");

      // create many collect
      await ColsOperation.createClos(result);
      print("------------------------------");
      print("create Clos");
      print("------------------------------");

      return right(result.id);
    } catch (e) {
      print("------------------------------");
      print("error on add new subjects $e");
      print("------------------------------");
      return left(FireBaseFailure("error on insert subject$e"));
    }
  }

  Future<Either<Failure, String>> createAnotherOperation({
    required String baseIdSubject,
  }) async {
    try {
      await QuizzesOperation.createQuizzes(baseIdSubject: baseIdSubject);
      print("------------------------------");
      print(" create Quizzes");
      print("------------------------------");
      await FinalExamOperation.createFinalExamExams(
          baseIdSubject: baseIdSubject);
      print("------------------------------");
      print(" create createFinalExamExams");
      print("------------------------------");
      await AssignmentsOperation.createAssignment(baseIdSubject: baseIdSubject);
      print("------------------------------");
      print(" create Assignment");
      print("------------------------------");
      await MidTermExamsOperation.createMidTermExams(
          baseIdSubject: baseIdSubject);

      print("------------------------------");
      print("  create MidTermExams");
      print("------------------------------");

      print("------------------------------");
      await LapsOperation.createLapsExams(baseIdSubject: baseIdSubject);
      print(" create Laps Exams");
      print("------------------------------");

      print("------------------------------");

      print("------------------------------");
      return right("success create Another Operation ");
    } catch (e) {
      print("------------------------------");
      print("error on create Another Operation $e");
      print("------------------------------");
      return left(FireBaseFailure("error on create Another Operation$e"));
    }
  }

  //get All Subject
  Future<Either<Failure, List<SubjectModel>>> getAllSubject() async {
    try {
      List<SubjectModel> data = [];
      final result =
          await FirebaseFirestore.instance.collection("subjects2").get();
      for (var element in result.docs) {
        //
        data.add(SubjectModel.fromMap(element.data(), element.id));

        // ids.add(element.id);
      }

      return right(data);
    } catch (e) {
      print("------------------------------");
      print(" error getAllSubject");
      print("------------------------------");
      return left(FireBaseFailure("error on insert subject$e"));
    }
  }

  Future<Either<Failure, String>> deleteSubject(String docs) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(docs)
          .delete();
      return right("Susses delete subject");
    } catch (e) {
      return left(FireBaseFailure("error on delete subject$e"));
    }
  }
}

//!---------------------------Cols Operation----------------------------------
class ColsOperation {
  //create docs of a clo
  static Future<void> createClos(
    DocumentReference<Map<String, dynamic>> result,
  ) async {
    for (int i = 1; i <= 3; i++) {
      Map<String, dynamic> data = {
        "clo_id": "clo_id $i",
        "clo_description": "description of clo",
      };
      var docs = await result.collection("clos").add(data);
      print("------------------------------");
      print("clos");
      print("------------------------------");

      //add the skills
      createSkill(docs);

      //add the value
      createValue(docs);

      //add the Knowledge
      createKnowledge(docs);
    }
  }

  static void createKnowledge(DocumentReference<Map<String, dynamic>> docs) {
    //add the Knowledge

    for (int i = 1; i <= 3; i++) {
      Map<String, dynamic> data = {
        "id": "k$i",
        "data": false,
      };
      docs.collection("knowledge").add(data);
    }
    print("------------------------------");
    print("Knowledge");
    print("------------------------------");
  }

  static void createValue(DocumentReference<Map<String, dynamic>> docs) {
    //add the value
    for (int i = 1; i <= 3; i++) {
      Map<String, dynamic> data = {
        "id": "v$i",
        "data": false,
      };
      docs.collection("value").add(data);
    }
    print("------------------------------");
    print("value");
    print("------------------------------");
  }

  static void createSkill(DocumentReference<Map<String, dynamic>> docs) {
    //add the skills
    for (int i = 1; i <= 5; i++) {
      Map<String, dynamic> data = {
        "id": "s$i",
        "data": false,
      };
      docs.collection("skill").add(data);
    }
    print("------------------------------");
    print("skills");
    print("------------------------------");
  }
}

//!---------------------------------Quizzes Operation-------------------------------------------
class QuizzesOperation {
  //create docs of a clo
  static Future<void> createQuizzes({
    required String baseIdSubject,
  }) async {
    //loop as count of quiz that you want to create
    for (int i = 1; i <= 2; i++) {
      //data of every quiz
      Map<String, dynamic> data = {"name": "quiz $i"};
      var docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdSubject)
          .collection("quizzes")
          .add(data);
      //add the quiz
      //add question for every quiz
      await addQuestion(docs: docs, baseDocsIdSubject: baseIdSubject);
    }
  }

  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docs,
    required String baseDocsIdSubject,
  }) async {
    for (var i = 1; i <= 3; i++) {
      //
      Map<String, dynamic> data = {
        "name": "Q $i",
        "clo_id": "",
        "clo_name": "",
        "clo_degree": 0.0,
      };
      await docs.collection("questions").add(data);
    }
  }
}

//!----------------------------------------Assignments Operation----------------------------------------------------
class AssignmentsOperation {
  //create docs of a Assignments
  static Future<void> createAssignment({
    required String baseIdSubject,
  }) async {
    //loop as count of Assignment that you want to create
    for (int i = 1; i <= 3; i++) {
      //data of every quiz
      Map<String, dynamic> data = {"name": "assignment $i"};
      //add the Assignments
      var docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdSubject)
          .collection("assignments")
          .add(data);

      //add question for every quiz
      await addAssignments(docs: docs, baseDocsIdSubject: baseIdSubject);
    }
  }

  static Future<void> addAssignments({
    required DocumentReference<Map<String, dynamic>> docs,
    required String baseDocsIdSubject,
  }) async {
    for (var i = 1; i <= 2; i++) {
      //
      Map<String, dynamic> data = {
        "name": "Q $i",
        "clo_id": "",
        "clo_name": "",
        "clo_degree": 0.0,
      };
      await docs.collection("questions").add(data);
    }
  }
}

//!----------------------------------------MidTermExams Operation----------------------------------------------------
class MidTermExamsOperation {
  //create docs of a Assignments
  static Future<void> createMidTermExams({
    required String baseIdSubject,
  }) async {
    //loop as count of Assignment that you want to create
    for (int i = 1; i <= 2; i++) {
      //data of every quiz
      Map<String, dynamic> data = {"name": "mid Term Exam $i"};
      //add the Assignments
      var docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdSubject)
          .collection("midTermExams")
          .add(data);

      //add question for every quiz
      await addQuestion(docs: docs, baseDocsIdSubject: baseIdSubject);
    }
  }

  static Future<void> addQuestion({
    required DocumentReference<Map<String, dynamic>> docs,
    required String baseDocsIdSubject,
  }) async {
    for (var i = 1; i <= 5; i++) {
      //
      Map<String, dynamic> data = {
        "name": "Q $i",
        "clo_id": "",
        "clo_name": "",
        "clo_degree": 0.0,
      };
      await docs.collection("questions").add(data);
    }
  }
}

//!----------------------------------------FinalExam Operation----------------------------------------------------
class FinalExamOperation {
  //create docs of a FinalExam
  static Future<void> createFinalExamExams({
    required String baseIdSubject,
  }) async {
    //data of every quiz
    Map<String, dynamic> data = {"name": "final Exam "};

    //add the FinalExam
    var docs = await FirebaseFirestore.instance
        .collection("subjects2")
        .doc(baseIdSubject)
        .collection("finalExam")
        .add(data);

    //add question for every FinalExam
    await addFinalExamQuestions(docs: docs, baseDocsIdSubject: baseIdSubject);
  }

  static Future<void> addFinalExamQuestions({
    required DocumentReference<Map<String, dynamic>> docs,
    required String baseDocsIdSubject,
  }) async {
    for (var i = 1; i <= 10; i++) {
      //
      Map<String, dynamic> data = {
        "name": "Q $i",
        "clo_id": "",
        "clo_name": "",
        "clo_degree": 0.0,
      };
      await docs.collection("questions").add(data);
    }
  }
}

//!----------------------------------------Laps Operation----------------------------------------------------
class LapsOperation {
  //create docs of a Laps
  static Future<void> createLapsExams({
    required String baseIdSubject,
  }) async {
    //loop as count of Laps that you want to create
    for (int i = 1; i <= 2; i++) {
      //data of every quiz
      Map<String, dynamic> data = {"name": "lap $i"};
      //add the Laps
      var docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdSubject)
          .collection("laps")
          .add(data);

      //add question for every Laps
      await addLaps(docs: docs, baseDocsIdSubject: baseIdSubject);
    }
  }

  static Future<void> addLaps({
    required DocumentReference<Map<String, dynamic>> docs,
    required String baseDocsIdSubject,
  }) async {
    for (var i = 1; i <= 4; i++) {
      //
      Map<String, dynamic> data = {
        "name": "Q $i",
        "clo_id": "",
        "clo_name": "",
        "clo_degree": 0.0,
      };
      await docs.collection("questions").add(data);
    }
  }
}
