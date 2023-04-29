part of 'delete_student_cubit.dart';

@immutable
class DeleteStudentState {
  //Delete Subject
  final RequestState requestState;

  const DeleteStudentState({
    this.requestState = RequestState.Loading,
  });
}
