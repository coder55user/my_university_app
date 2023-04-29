part of 'delete_subject_cubit.dart';

@immutable
class DeleteSubjectState {
  //Delete Subject
  final RequestState requestState;
  final String message;

  DeleteSubjectState({
    this.requestState = RequestState.Loading,
    this.message = "",
  });
}
