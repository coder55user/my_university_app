part of 'store_subject_cubit.dart';

@immutable
class StoreSubjectState {
  //data subject
  final RequestState subjectRequestState;
  final List<SubjectModel> dataSubject;
  //clo
  final List<CloModel> dataClo;
  final RequestState cloRequestState;
  //count quiz type
  final List<QuizTypeModel> dataQuizType;
  final RequestState quizTypeRequestState;
  //Question Data Of Quiz
  final List<QuestionOfQuizModel> dataQuestion;
  final RequestState questionDataRequestState;

  //clo report state
  final RequestState? cloReportRequestState;

  const StoreSubjectState({
    //data subject
    this.subjectRequestState = RequestState.Loading,
    this.dataSubject = const [],
    //clo
    this.cloRequestState = RequestState.Loading,
    this.dataClo = const [],
    //count quiz type
    this.quizTypeRequestState = RequestState.Loading,
    this.dataQuizType = const [],
    //Question Data Of Quiz
    this.questionDataRequestState = RequestState.Loading,
    this.dataQuestion = const [],
    //clo report state
    this.cloReportRequestState,
  });

  //
  StoreSubjectState copyWith({
    //data subject
    RequestState? subjectRequestState,
    List<SubjectModel>? dataSubject,
    //clo
    RequestState? cloRequestState,
    List<CloModel>? dataClo,
    //count quiz type
    RequestState? quizTypeRequestState,
    List<QuizTypeModel>? dataQuizType,

    //Question Data Of Quiz
    RequestState? questionDataRequestState,
    List<QuestionOfQuizModel>? dataQuestion,
    //clo report state
    RequestState? cloReportRequestState,
  }) {
    return StoreSubjectState(
      //data subject
      dataSubject: dataSubject ?? this.dataSubject,
      subjectRequestState: subjectRequestState ?? this.subjectRequestState,
      //clo
      dataClo: dataClo ?? this.dataClo,
      cloRequestState: cloRequestState ?? this.cloRequestState,
      //count quiz type
      dataQuizType: dataQuizType ?? this.dataQuizType,
      quizTypeRequestState: quizTypeRequestState ?? this.quizTypeRequestState,
      //Question Data Of Quiz
      dataQuestion: dataQuestion ?? this.dataQuestion,
      questionDataRequestState:
          questionDataRequestState ?? this.questionDataRequestState,
      //clo report state
      cloReportRequestState:
          cloReportRequestState ?? this.cloReportRequestState,
    );
  }
}
