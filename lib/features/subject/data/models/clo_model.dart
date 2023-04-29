class CloModel {
  String? baseIdDocs;
  String? subIdDocs;
  //
  String? subCloId;
  String? baseCloId;
  //
  String? cloDescription;
  bool? data;
  CloModel({
    this.baseIdDocs,
    this.subIdDocs,
    this.cloDescription,
    this.subCloId,
    this.data,
  });

  //

  CloModel.fromMap({
    required Map<String, dynamic> json,
    required String base_docs_id,
    required String sub_docs_id,
  }) {
    baseIdDocs = base_docs_id;
    subIdDocs = sub_docs_id;

    //
    subCloId = json['id'];
    baseCloId = json['clo_id'];
    cloDescription = json['clo_description'];
    data = json['data'];
  }

  // Map<String, dynamic> toMap() => {
  //       'clo_description': cloDescription,
  //       'id': cloId,
  //       'data': data,
  //     };
}
