class SubjectModel {
  String? department;
  int? section;
  int? creditHours;
  String? mClass;
  int? noOfStudents;
  String? courseTitle;
  String? instructorName;
  String? semester;
  String? id;
  SubjectModel({
    this.courseTitle,
    this.creditHours,
    this.department,
    this.instructorName,
    this.mClass,
    this.noOfStudents,
    this.section,
    this.semester,
    this.id,
  });

  //

  SubjectModel.fromMap(Map<String, dynamic> json,String docs_id) {
    department = json['department'];
    section = json['section'];
    creditHours = json['creditHours'];
    mClass = json['mClass'];
    noOfStudents = json['noOfStudents'];
    courseTitle = json['courseTitle'];
    instructorName = json['instructorName'];
    semester = json['semester'];
    id = docs_id;
  }

  Map<String, dynamic> toMap() => {
        'department': department,
        'section': section,
        'creditHours': creditHours,
        'mClass': mClass,
        'noOfStudents': noOfStudents,
        'courseTitle': courseTitle,
        'instructorName': instructorName,
        'semester': semester,
        'id': id,
      };
}

List<SubjectModel> dummyData = [
  SubjectModel(
    courseTitle: "Mobile Application Development",
    instructorName: "Dr. Mohammed Khairi",
    department: "Information System",
    semester: "First Semester 2022/2023",
    creditHours: 3,
    section: 55,
    noOfStudents: 24,
    mClass: "BSC",
  ),
];
