import 'package:app_excle/core/failure/firebase_failure.dart';
import 'package:app_excle/features/subject/data/models/clo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class BaseCloController {
//create docs of a clo
  Future<Either<Failure, int>> addClos({
    required int skillsCount,
    required int skillsValue,
    required int skillsKnowledge,
    required int numberClo,
    required String baseIdDocsSubjects,
  }) async {
    try {
      Map<String, dynamic> data = {
        "clo_id": "clo_id $numberClo",
        "clo_description": "description of clo",
      };
      final docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubjects)
          .collection("clos")
          .add(data);

      //add the skills
      createSkill(docs: docs);

      //add the value
      createValue(docs: docs);

      //add the Knowledge
      createKnowledge(docs: docs);
      return right(1);
    } catch (e) {
      return left(FireBaseFailure("error on add clo"));
    }
  }

  void createKnowledge({
    required DocumentReference<Map<String, dynamic>> docs,
  }) {
    //add the Knowledge
    for (int i = 1; i <= 3; i++) {
      docs.collection("knowledge").add({"K$i": false});
    }
    print("------------------------------");
    print("Knowledge success");
    print("------------------------------");
  }

  void createValue({required DocumentReference<Map<String, dynamic>> docs}) {
    //add the value
    for (int i = 1; i <= 3; i++) {
      docs.collection("value").add({"V$i": false});
    }
    print("------------------------------");
    print("value success");
    print("------------------------------");
  }

  void createSkill({
    required DocumentReference<Map<String, dynamic>> docs,
  }) {
    //add the skills
    for (int i = 1; i <= 5; i++) {
      // Map<String, dynamic> data = {"count": 5};

      docs.collection("skill").add({"S$i": false});
    }
    print("------------------------------");
    print("skills success");
    print("------------------------------");
  }

  //delete Clo
  Future<Either<Failure, int>> deleteClo({
    required String baseIdDocsSubjects,
    required String docsCloDelete,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubjects)
          .collection("clos")
          .doc(docsCloDelete)
          .delete();

      return right(1);
    } catch (e) {
      return left(FireBaseFailure("error on delete clo"));
    }
  }

  //delete Clo
  Future<Either<Failure, int>> updateClo({
    required String baseIdDocsSubjects,
    required String docsCloUpdate,
    required String cloId,
    required String cloDescription,
  }) async {
    try {
      Map<String, dynamic> data = {
        "clo_id": cloId,
        "clo_description": cloDescription,
      };
      final docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubjects)
          .collection("clos")
          .doc(docsCloUpdate)
          .update(data);

      return right(1);
    } catch (e) {
      return left(FireBaseFailure("error on update clo"));
    }
  }

  //update Clo Knowledge
  Future<Either<Failure, int>> updateCloKnowledge({
    required String baseIdDocsSubjects,
    required String docsCloUpdate,
    required String docsKnowledgeCloUpdate,
    required bool newKnowledgeData,
    required String newKey,
    required String collectionNameDetail,
  }) async {
    try {
      Map<String, dynamic> data = {
        "id": newKey,
        "data": newKnowledgeData,
      };
      //
      final docs = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubjects)
          .collection("clos")
          .doc(docsCloUpdate)
          .collection(collectionNameDetail)
          .doc(docsKnowledgeCloUpdate)
          .update(data);

      return right(1);
    } catch (e) {
      print(e);
      return left(FireBaseFailure("error on update clo"));
    }
  }

  //get data Clo detail
  Future<Either<Failure, List<CloModel>>> getDataCloDetail({
    required String baseIdDocsSubjects,
    required String docsCloId,
    required String nameCollectionInClo,
  }) async {
    try {
      List<CloModel> data = [];
      //
      final result = await FirebaseFirestore.instance
          .collection("subjects2")
          .doc(baseIdDocsSubjects)
          .collection("clos")
          .doc(docsCloId)
          .collection(nameCollectionInClo)
          .get();
      for (var element in result.docs) {
        data.add(CloModel.fromMap(
          json: element.data(),
          base_docs_id: " ",
          sub_docs_id: element.id,
        ));
        print(element.data());
      }

      return right(data);
    } catch (e) {
      print(e);
      return left(FireBaseFailure("error on update clo"));
    }
  }
}
