class CloModelReport {
  String? cloTypeName;
  double? degreeClo;
  String? cloId;

  CloModelReport({
    this.cloTypeName,
    this.degreeClo,
    this.cloId,
  });

  //

  CloModelReport.fromMap(Map<String, dynamic> json ) {
    cloTypeName = json['clo_name'];
    degreeClo = json['clo_degree'];
    cloId =  json['clo_id'];
  }
}
