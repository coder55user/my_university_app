part of 'add_subject_cubit.dart';

@immutable

//Add Subject State
class AddSubjectState {
  RequestState? requestState;
  String? idSubject;
  ButtonState? buttonState;
  RequestState? anotherRequestState;

  //----------------constructor-----------------------
  AddSubjectState({
    this.buttonState,
    this.idSubject,
    this.requestState,
    this.anotherRequestState,
  });

  //copy With method
  AddSubjectState copyWith({
    RequestState? requestState,
    RequestState? anotherRequestState,
    String? idSubject,
    ButtonState? buttonState,
  }) {
    return AddSubjectState(
      buttonState: buttonState ?? this.buttonState,
      idSubject: idSubject ?? this.idSubject,
      requestState: requestState ?? this.requestState,
      anotherRequestState: anotherRequestState??this.anotherRequestState,
    );
  }
}
