part of 'add_student_cubit.dart';

@immutable
class AddStudentState {
  RequestState? requestState;
  String? idSubject;
  ButtonState? buttonState;
  RequestState? anotherRequestState;

  //----------------constructor-----------------------
  AddStudentState({
    this.buttonState,
    this.idSubject,
    this.requestState,
    this.anotherRequestState,
  });

  //copy With method
  AddStudentState copyWith({
    RequestState? requestState,
    RequestState? anotherRequestState,
    String? idSubject,
    ButtonState? buttonState,
  }) {
    return AddStudentState(
      buttonState: buttonState ?? this.buttonState,
      idSubject: idSubject ?? this.idSubject,
      requestState: requestState ?? this.requestState,
      anotherRequestState: anotherRequestState ?? this.anotherRequestState,
    );
  }
}
