import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/students/data/controller/update_student_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'delete_student_state.dart';

class DeleteStudentCubit extends Cubit<DeleteStudentState> {
  DeleteStudentCubit({required this.updateStudentController})
      : super(const DeleteStudentState());
  static DeleteStudentCubit get(context) => BlocProvider.of(context);
  UpdateStudentController updateStudentController;
  //delete subject
  void deleteSubject({
    required String idDocsStudent,
    required String baseIdDocsSubject,
  }) async {
    //set state loading
    emit(const DeleteStudentState(
      requestState: RequestState.Loading,
    ));

    //get the docs to delete
    final result = await updateStudentController.deleteStudent(
        idDocsStudent: idDocsStudent, baseIdDocsSubject: baseIdDocsSubject);

    //error
    result.fold(
      (l) {
        emit(const DeleteStudentState(
          requestState: RequestState.Error,
        ));
      },
      //success
      (r) {
        emit(
          const DeleteStudentState(
            requestState: RequestState.Success,
          ),
        );
      },
    );
  }
}
