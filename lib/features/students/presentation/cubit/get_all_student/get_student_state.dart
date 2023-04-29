part of 'get_student_cubit.dart';

@immutable
class StoreStudentState {
  //all students
  final RequestState requestStateDataStudents;
  final List<StudentModel> dataStudents;

  //Section Type
  final RequestState requestSectionTypeState;
  final List<StudentModel> dataSectionType;

  //Question Section
  final RequestState requestQuestionSectionState;
  final List<StudentQuestionModel> dataQuestionSection;

  //sum of quiz
  final double sumOfQuiz;

  //----------------constructor-----------------------
  const StoreStudentState({
    //all students
    this.requestStateDataStudents = RequestState.Loading,
    this.dataStudents = const [],
    //Section Type
    this.dataSectionType = const [],
    this.requestSectionTypeState = RequestState.Loading,
    //Question Section
    this.dataQuestionSection = const [],
    this.requestQuestionSectionState = RequestState.Loading,
    //sum of quiz
    this.sumOfQuiz = 0.0,
  });

  //copy With method
  StoreStudentState copyWith({
    //all students
    RequestState? requestStateDataStudents,
    List<StudentModel>? dataStudents,
    //Section Type
    RequestState? requestSectionTypeState,
    List<StudentModel>? dataSectionType,
    //Question Section
    RequestState? requestQuestionSectionState,
    List<StudentQuestionModel>? dataQuestionSection,
    //sum of quiz
    double? sumOfQuiz,
  }) {
    return StoreStudentState(
      //all students
      dataStudents: dataStudents ?? this.dataStudents,
      requestStateDataStudents:
          requestStateDataStudents ?? this.requestStateDataStudents,
      //Section Type
      dataSectionType: dataSectionType ?? this.dataSectionType,
      requestSectionTypeState:
          requestSectionTypeState ?? this.requestSectionTypeState,
      //Question Section
      dataQuestionSection: dataQuestionSection ?? this.dataQuestionSection,
      requestQuestionSectionState:
          requestQuestionSectionState ?? this.requestQuestionSectionState,

      //sum of quiz
      sumOfQuiz: sumOfQuiz ?? this.sumOfQuiz,
    );
  }
}
