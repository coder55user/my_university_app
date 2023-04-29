import 'package:app_excle/core/failure/request_state.dart';
import 'package:app_excle/features/students/data/controller/student_repo_imp.dart';
import 'package:app_excle/features/students/data/models/student_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:progress_state_button/progress_button.dart';

part 'add_student_state.dart';

class AddStudentCubit extends Cubit<AddStudentState> {
  AddStudentCubit(this.repositorySubjectImpl) : super(AddStudentState());

  //
  static AddStudentCubit get(context) => BlocProvider.of(context);
  RepositoryStudentImpl repositorySubjectImpl;

  //add subject

  void addStudent({
    required StudentModel studentModel,
    required String docsIdSubject,
  }) async {
    emit(AddStudentState(
      requestState: RequestState.Loading,
      buttonState: ButtonState.loading,
    ));

    //
    final result = await repositorySubjectImpl.createStudent(
        studentModel: studentModel, docsIdSubject: docsIdSubject);
    //Error
    result.fold((l) {
      emit(
        AddStudentState(
          requestState: RequestState.Error,
          buttonState: ButtonState.fail,
        ),
      );
    },
        //Success
        (r) {
      emit(
        AddStudentState(
          requestState: RequestState.Success,
          buttonState: ButtonState.success,
        ),
      );
      createAnotherOperation(
        baseDocsIdSubject: docsIdSubject,
        idDocsStudent: r,
      );
    });
  }

  //create Another Operation
  void createAnotherOperation({
    required String baseDocsIdSubject,
    required String idDocsStudent,
  }) async {
    //loading
    emit(
      state.copyWith(
        anotherRequestState: RequestState.Loading,
        buttonState: ButtonState.idle,
      ),
    );
    //result
    final result = await repositorySubjectImpl.createAnotherOperation(
      baseDocsIdSubject: baseDocsIdSubject,
      idDocsStudent: idDocsStudent,
    );

    //error
    result.fold(
      (l) {
        emit(
          state.copyWith(
            anotherRequestState: RequestState.Error,
          ),
        );
      },

      //success
      (r) {
        emit(
          state.copyWith(
            anotherRequestState: RequestState.Success,
          ),
        );
      },
    );
  }
}
