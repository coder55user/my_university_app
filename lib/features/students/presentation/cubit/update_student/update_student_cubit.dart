import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/students/data/controller/update_student_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_state_button/progress_button.dart';

part 'update_student_state.dart';

class UpdateStudentCubit extends Cubit<UpdateStudentState> {
  UpdateStudentCubit({required this.updateStudentController})
      : super(UpdateStudentState());

  //
  static UpdateStudentCubit get(context) => BlocProvider.of(context);

  //
  UpdateStudentController updateStudentController;

  //add subject

  void updateStudentDegree({
    required String idDocsStudent,
    required String baseIdDocsSubject,
    required String idDocsQuizSection,
    required String nameCollectionSection,
    required String idDocsOfQuestionUpdate,
    required double newDegree,
    required String newKey,

  }) async {
    emit(UpdateStudentState(
      requestState: RequestState.Loading,
      buttonState: ButtonState.loading,
    ));

    //
    final result = await updateStudentController.updateDegreeStudent(
      idDocsStudent: idDocsStudent,
      baseIdDocsSubject: baseIdDocsSubject,
      idDocsQuizSection: idDocsQuizSection,
      nameCollectionSection: nameCollectionSection,
      idDocsOfQuestionUpdate: idDocsOfQuestionUpdate,
      newDegree: newDegree,
      newKey: newKey,
    );
    //Error
    result.fold((l) {
      emit(UpdateStudentState(
        requestState: RequestState.Error,
        buttonState: ButtonState.fail,
      ));
    },
        //Success
        (r) {
      emit(UpdateStudentState(
        requestState: RequestState.Success,
        buttonState: ButtonState.success,
      ));
    });
  }
}
