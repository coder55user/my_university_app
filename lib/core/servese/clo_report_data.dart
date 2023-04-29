import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/core/servese/clo_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'excel_api.dart';

class CloReportDataController {
  List<String> docsName = [
    "quizzes",
    "laps",
    "finalExam",
    "midTermExams",
    "assignments",
  ];

  //get docs of quiz
  Future<List<CloModelReport>> getDocsQuizType({
    required String baseDocsIdSubject,
  }) async {
    List<CloModelReport> data = [];

    //
    for (var quizType in docsName) {
      //get the docs of the quiz type
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection(quizType)
          .get();
      //loop through all the docs in quiz type
      for (var docsQuiz in result.docs) {
        final docsQuestion = await FirebaseFirestore.instance
            .collection("subjects2")
            .doc(baseDocsIdSubject)
            .collection(quizType)
            .doc(docsQuiz.id)
            .collection("questions")
            .get();
        for (var element in docsQuestion.docs) {
          data.add(CloModelReport.fromMap(element.data()));
          // print(element.data());
        }
      }
    }

    return data;
  }

  Future<Either<Failure, int>> collectTheData({
    required String baseDocsIdSubject,
  }) async {
    try {
      final data = await getDocsQuizType(
        baseDocsIdSubject: baseDocsIdSubject,
      );
       await ExcelApi.createExcel(
        cloMap: collateData(data),
      );
      return right(1);
    } catch (e) {
      return left(FireBaseFailure("error oncollectTheData "));
    }
  }

  Map<String, double> collateData(List<CloModelReport> cloList) {
    Map<String, double> cloMap = {};
    double totalSum = 0.0;
    cloMap['total'] = totalSum;

    for (CloModelReport clo in cloList) {
      if (clo.cloId!.isNotEmpty && clo.cloTypeName!.isNotEmpty) {
        String cloID = clo.cloTypeName!;
        double degree = clo.degreeClo!;

        if (cloMap.containsKey(cloID)) {
          cloMap[cloID] = cloMap[cloID]! + degree;
          cloMap['total'] = cloMap['total']! + degree;
        } else {
          cloMap[cloID] = degree;
          cloMap['total'] = cloMap['total']! + degree;
        }
      }
    }

    return cloMap;
  }
}
