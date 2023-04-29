import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class CloController {
  //!get  base clo data
  Future<Either<Failure, List<CloModel>>> getClo({
    required String baseDocsIdSubject,
  }) async {
    List<CloModel> data = [];
    try {
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseDocsIdSubject)
          .collection("clos")
          .get();
      for (var element in result.docs) {
        data.add(
          CloModel.fromMap(
            json: element.data(),
            base_docs_id: element.id,
            sub_docs_id: "",
          ),
        );
        print(element.data());
      }
      return right(data);
    } catch (e) {
      return left(FireBaseFailure("message on get clo $e"));
    }
  }
}
